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
let s:job = {}
let s:search = {}
let s:matches = []
let s:position = 'right'

let s:command = v:null
let s:commandWithColumns = v:null

if !exists('g:searchReplace_closeOnExit')
    let g:searchReplace_closeOnExit = v:true
end
if !exists('g:searchReplace_editCommand')
    let g:searchReplace_editCommand = 'edit'
end

command! -nargs=* -complete=dir Search    :call <SID>runSearch(<f-args>)
command! -nargs=1               Replace   :call <SID>runReplace(<f-args>)

hi default link SearchReplaceMatch Search

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
    let s:matches = []

    let s:command = "rg --json " . shellescape(s:pattern) . " " . join(s:paths)

    let s:job = {}
    let s:job.cmd = s:command
    let s:job.cwd = fnamemodify(expand(s:directory), ':p')
    let s:job.buffer = v:null
    let s:job.stdout = []
    let s:job.stderr = []
    let s:job.didExit = v:false
    let s:job.on_stdout = function('s:onStdout')
    let s:job.on_stderr = function('s:onStderr')
    let s:job.on_exit = function('s:onExit')
    let s:job.jobID = jobstart(s:job.cmd, s:job)

    call s:echo('WarningMsg', 'Running search for ')
    call s:echo('Normal', s:pattern)

    let s:isSearching = v:true

    call s:createSearchWindow()
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

function! s:onStdout(jobID, data, event) dict
    call extend(self.stdout, a:data)

    let matches = s:filterData(a:data)
    for m in matches
        let text = m
        if s:job.buffer != v:null
            let text .= s:job.buffer
            let s:job.buffer = v:null
        end
        let jsonData = v:null
        try
            let jsonData = json_decode(m)
        catch
            let s:job.buffer = m
            return
        endtry
        call s:appendMatch(jsonData)
    endfor
endfunction

function! s:onStderr(jobID, data, event) dict
    call extend(self.stderr, a:data)
endfunction

function! s:onExit(...) dict
    let self.didExit = v:true
    let self.stdout = filter(self.stdout, "v:val != ''")
    let self.stderr = filter(self.stderr, "v:val != ''")

    if len(s:matches) == 0
        call s:echo('WarningMsg', 'No match found for ')
        call s:echo('Normal', s:pattern)
        call s:closeSearchWindow()
        return
    end

    call s:echo('WarningMsg', 'Search completed')
endfunction

function! s:appendMatch(match)
    if a:match.type == 'begin'
        if len(s:matches) == 0
            call setline(1, '### ' . (a:match.data.path.text) . ' ###')
        else
            call append(line('$'), '### ' . (a:match.data.path.text) . ' ###')
        end
        return
    end

    if a:match.type != 'match'
        return
    end

    call add(s:matches, a:match)

    let prefix = '' . a:match.data.line_number . ': '
    let lineNumber = line('$')

    call append(lineNumber, prefix . (a:match.data.lines.text))

    for submatch in a:match.data.submatches
        let lineNumber = line('$')
        let pos = [lineNumber, submatch.start + 1 + len(prefix), len(submatch.match.text)]

        call matchaddpos('SearchReplaceMatch', [pos])
    endfor
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
        end

        execute bufnr('SearchReplace') . 'bwipe!'
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
    setlocal nobuflisted
    file SearchReplace
    let s:lastBufnr = bufnr('%')

    " Create mappings
    if g:searchReplace_closeOnExit
        au BufLeave <buffer> bd
    end
    nnoremap                 <buffer>q     <C-W>p
    nnoremap                 <buffer><Esc> <C-W>p
    nnoremap   <expr><nowait><buffer><A-r> <SID>replaceMapping()
    nnoremap   <expr><nowait><buffer><CR>  <SID>replaceMapping()
    nnoremap <silent><nowait><buffer>d     :call <SID>deleteLine()<CR>
    nnoremap <silent><nowait><buffer>o     :call <SID>openLine()<CR>

    " Add highlights
    call matchadd('Comment', '###')
    call matchadd('Directory', '\v(###)@<=.*(###)@=')
    call matchadd('Label', '\v^\d+:')
endfunction

function! s:closeSearchWindow ()
    " Buffer will be deleted by autocmd
    wincmd p

    let s:isSearching = v:false
endfunction

function! s:replaceMapping()
    if !s:job.didExit
        call s:echo('WarningMsg', 'Search is not completed yet')
        return "\<nop>"
    end
    return ":Replace\<space>"
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

function! s:openLine()
    let text = getline('.')
    let firstLine = line('.')
    if text =~ '^###'
        let filename = s:extractFilename(text)
        execute g:searchReplace_editCommand . ' ' . filename
    elseif text =~ '^\d\+:'
        let lineNumber = s:extractLineNumber(getline('.'))
        let previousFilenameLine = search('### .* ###', 'nb')
        let filenameLine = getline(previousFilenameLine)
        let filename = s:extractFilename(filenameLine)
        execute g:searchReplace_editCommand . ' ' . filename
        execute 'normal! ' . lineNumber . 'ggzz'
    end
endfunction

function! s:filterData(data)
    return filter(a:data, "v:val != ''")
endfunction

function! s:escape(pattern)
    return substitute(a:pattern, '\/', '\\/', 'g')
endfunction

function! s:echo(hlgroup, ...)
    exe ':echohl ' . a:hlgroup
    echon join(a:000)
endfunction

function! s:extractFilename (line)
    return substitute(substitute(a:line, '### ', '', ''), ' ###', '', '')
endfunc

function! s:extractLineNumber (line)
    return substitute(a:line, ':.*', '', '')
endfunc

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


let g:SearchReplace = s:
