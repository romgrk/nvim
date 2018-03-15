"!::exe [So]

let s:isSearching = v:false
let s:directory = '.'
let s:paths = ['.']
let s:pattern = ''
let s:replacement = ''
let s:totalMatches = 0
let s:waitingCount = 0
let s:totalReplacements = 0
let s:replacementFiles = []
let s:replacementJobs = []
let s:search = {}
let s:searchMatches = {}
let s:isSearchDone = v:false
let s:isSearchMatchesDone = v:false
let s:position = 'right'

if !exists('g:searchReplace_closeOnExit')
    let g:searchReplace_closeOnExit = v:true
end

command! -nargs=* -complete=dir Search    :call <SID>runSearch(<f-args>)
command! -nargs=1               Replace   :call <SID>runReplace(<f-args>)

hi default link SearchReplaceMatch Search

" runs a command then calls Fn handler
function! s:run(cmd, cwd, Fn)
    let opts = {}
    let opts.cmd = a:cmd
    let opts.cwd = fnamemodify(expand(a:cwd), ':p')
    let opts.stdout = []
    let opts.stderr = []
    let opts.on_stdout = function('s:on_stdout')
    let opts.on_stderr = function('s:on_stderr')
    let opts.on_exit = function('s:on_exit')
    let opts.handler = a:Fn
    let opts.jobID = jobstart(a:cmd, opts)
    return opts
endfunction
function! s:on_stdout(jobID, data, event) dict
    call extend(self.stdout, a:data)
endfunction
function! s:on_stderr(jobID, data, event) dict
    call extend(self.stderr, a:data)
endfunction
function! s:on_exit(...) dict
    let self.stdout = filter(self.stdout, "v:val != ''")
    let self.stderr = filter(self.stderr, "v:val != ''")
    call self.handler(self)
endfunction

function! s:runSearch(pattern, ...)
    let s:paths = a:000
    let s:pattern = a:pattern
    let s:replacement = ''
    let s:totalMatches = 0
    let s:waitingCount = 0
    let s:totalReplacements = 0
    let s:replacementFiles = []
    let s:replacementJobs = []
    let s:search = {}
    let s:searchMatches = {}
    let s:isSearchDone = v:false
    let s:isSearchMatchesDone = v:false

    call s:run(
            \ "rg -nH " . shellescape(s:pattern) . " " . join(s:paths),
            \ s:directory,
            \ function('s:onExitSearch'))
    call s:run(
            \ "rg -nHo --column " . shellescape(s:pattern) . " " . join(s:paths),
            \ s:directory,
            \ function('s:onExitSearchMatches'))

    call s:echo('WarningMsg', 'Running search for ')
    call s:echo('Normal', s:pattern)
endfunction

function! s:runReplace(replacement)
    if !s:isSearching
        call s:echo('WarningMsg', 'Replace: ')
        call s:echo('Normal', 'No search in progress.')
        return
    end

    let s:isSearching = v:false
    let s:replacement = a:replacement

    let s:replacementJobs = []

    let matches = {}
    let currentFile = ''
    for n in range(1, line('$'))
        let text = getline(n)
        if text =~ '^###'
            let currentFile = text[4:-5]
            let matches[currentFile] = []
        else
            let line = matchstr(text, '\v\d+:@=')
            call add(matches[currentFile], line)
        end
    endfor

    let files = keys(matches)

    let s:totalReplacements = 0

    for file in files
        let subCommand = "s/" . s:escape(s:pattern) . "/" . s:escape(s:replacement) . "/g"
        let subCommands = join(map(matches[file], 'v:val . subCommand'), '; ')
        let command = "sed -i " . shellescape(subCommands) . " " . file
        let s:totalReplacements = s:totalReplacements + len(matches[file])
        call add(s:replacementFiles, file)
        call s:run(command, s:directory, function('s:onExitReplace'))
    endfor

    let s:waitingCount = len(s:replacementFiles)

    call s:echo('Question', 'Replace: ')
    call s:echo('Normal', 'running on ')
    call s:echo('Special', len(s:replacementFiles))
    call s:echo('Normal', ' files')
endfunction

function! s:onExitSearch(job)
    let parts = map(a:job.stdout, "split(v:val, ':')")

    let s:search = {}
    let s:totalMatches = 0
    for p in parts
        if len(p) < 3
            continue
        end
        let file = p[0]
        let line = p[1]
        let text = join(p[2:], ':')

        if !has_key(s:search, file)
            let s:search[file] = []
        end
        call add(s:search[file], { 'line': line, 'text': text })
        let s:totalMatches = s:totalMatches + 1
    endfor

    let s:isSearchDone = v:true
    call s:onSearchDone()
endfunction

function! s:onExitSearchMatches(job)
    let parts = map(a:job.stdout, "split(v:val, ':')")

    let s:searchMatches = {}
    for p in parts
        if len(p) < 4
            continue
        end
        let file = p[0]
        let line = p[1]
        let col  = p[2]
        let text = substitute(join(p[3:], ':'), '^\s\+', '', '')

        if !has_key(s:searchMatches, file)
            let s:searchMatches[file] = []
        end
        call add(s:searchMatches[file], { 'line': str2nr(line), 'col': str2nr(col), 'text': text })
    endfor

    let s:isSearchMatchesDone = v:true
    call s:onSearchDone()
endfunction

function! s:onSearchDone()
    if !(s:isSearchDone && s:isSearchMatchesDone)
        return
    end

    if len(s:search) == 0
        call s:echo('WarningMsg', 'No match found for ')
        call s:echo('Normal', s:pattern)
        return
    end

    let s:isSearching = v:true

    call s:createSearchWindow()

    " Display content
    let lastFile = ''
    for file in keys(s:search)
        let matches = s:search[file]
        let searchMatches = s:searchMatches[file]

        call append(line('$'), '### ' . file . ' ###')

        for i in range(len(matches))
            let m  = matches[i]
            let sm = searchMatches[i]

            let prefix = '' . m.line . ': '

            let lineNumber = line('$')

            call append(lineNumber, prefix . m.text)

            let pos = [lineNumber, sm.col + len(prefix), len(sm.text)]

            call matchaddpos('SearchReplaceMatch', [pos])
        endfor
    endfor
    normal! dd
    call matchadd('Comment', '###')
    call matchadd('Directory', '\v(###)@<=.*(###)@=')
    call matchadd('Label', '\v^\d+:')
endfunction

function! s:onExitReplace(job)
    call add(s:replacementJobs, a:job)

    let s:waitingCount = s:waitingCount - 1
    if s:waitingCount != 0
        echo s:waitingCount . ' remaining'
        return
    end

    if bufname('%') == 'SearchReplace'
        wincmd c
    end

    call timer_start(100, function('s:displayDone'))
endfunction

function! s:createSearchWindow()
    " Go to existing window if there is one
    if bufnr('SearchReplace') != -1
        let winids = win_findbuf(bufnr('SearchReplace'))
        if len(winids) > 0
            call win_gotoid(winids[0])
            normal! ggdG
            call clearmatches()
            return
        else
            execute bufnr('SearchReplace') . 'bwipe!'
        end
    end

    split

    if s:position == 'bottom' || s:position == 'top'
        if s:position == 'bottom'
            wincmd J
        elseif s:position == 'top'
            wincmd K
        end

        let height = len(s:search) + s:totalMatches
        if height > 10
            let height = 10
        end
        exe height . 'wincmd _'
    elseif s:position == 'right'
        wincmd L
    else " if s:position == 'left'
        wincmd H
    end

    enew
    setlocal nonumber
    setlocal buftype=nofile
    file SearchReplace
    let s:lastBufnr = bufnr('%')

    " Create mappings
    if g:searchReplace_closeOnExit
        au BufLeave <buffer> bd
    end
    nnoremap                 <buffer><Esc> <C-W>p
    nnoremap         <nowait><buffer><A-r> :Replace<space>
    nnoremap         <nowait><buffer><CR>  :Replace<space>
    nnoremap <silent><nowait><buffer>d     :call <SID>deleteLine()<CR>
endfunction

function! s:displayDone(...)
    let buffers = split(execute('ls'), "\n")
    let buffers = map(buffers, "matchstr(v:val, '\".*\"', '')[1:-2]")
    let s:buffers = map(buffers, "fnamemodify(v:val, ':p')")

    for file in s:replacementFiles
        if index(buffers, file) != -1
            let nr = bufnr(file)
            exe nr . 'bufdo edit!'
        end
    endfor

    let hasError = v:false

    for job in s:replacementJobs
        if len(job.stderr)
            call s:echo('ErrorMsg', 'Replace: ')
            call s:echo('Normal', job.stderr)
            let hasError = v:true
        end
    endfor

    if hasError | return | end

    call s:echo('Normal', 'Done (')
    call s:echo('Success', s:totalReplacements)
    call s:echo('Normal', ' replacements in ')
    call s:echo('Success', len(s:replacementFiles))
    call s:echo('Normal', ' files )')
endfunction

function! s:deleteLine()
    let text = getline('.')
    let firstLine = line('.')
    if text =~ '^###'
        let lastLine = searchpos('^###', 'n')[0] - 1
        if lastLine == 0
            let lastLine = line('$')
        end
        execute firstLine . ',' . lastLine . 'delete _'
    else
        execute firstLine . 'delete _'
    end
endfunction

function! s:escape(pattern)
    return substitute(a:pattern, '\/', '\\/', 'g')
endfunction

function! s:echo(hlgroup, ...)
    exe ':echohl ' . a:hlgroup
    echon join(a:000)
endfunction

let g:SearchReplace = s:
