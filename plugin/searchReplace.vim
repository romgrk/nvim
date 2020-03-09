" !::exe [So]

let s:isSearching = v:false
let s:directory = '.'
let s:pattern = ''
let s:paths = []
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

let s:promptWindowId = v:null
let s:searchWindowId = v:null

let s:promptPattern     = 'Pattern      '
let s:promptDirectories = 'Directories  '

let s:command = v:null
let s:commandWithColumns = v:null

let s:hlNamespace = nvim_create_namespace('SearchReplace')

if !exists('g:searchReplace_closeOnExit')
    let g:searchReplace_closeOnExit = v:true
end
if !exists('g:searchReplace_editCommand')
    let g:searchReplace_editCommand = 'edit'
end

command! -nargs=* -complete=dir Search    :call <SID>searchCommand(<f-args>)
command! -nargs=1               Replace   :call <SID>runReplace(<f-args>)

hi default link SearchReplaceMatch Search

function! s:searchCommand (...)
    if a:0 > 1
        let s:pattern = a:000[0]
        let s:paths   = a:000[1:]
        call s:runSearch()
    else
        call s:createPromptWindow()
    end
endfunc

function! s:runSearch()
    " global s:pattern
    " global s:paths
    let s:replacement = ''
    let s:totalMatches = 0
    let s:waitingCount = 0
    let s:totalReplacements = 0
    let s:replacementFiles = []
    let s:replacementJobs = []
    let s:search = {}
    let s:matches = []

    let s:command =
        \ "rg --json "
        \ . join(map(copy(s:paths), {_,v -> '--glob ' . shellescape(v)}), " ")
        \ . " " . shellescape(s:pattern)

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
        if text =~ '^> '
            let currentFile = s:extractFilename(text)
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
            call setline(1, '> ' . (a:match.data.path.text))
        else
            call append(line('$'), '')
            call append(line('$'), '> ' . (a:match.data.path.text))
        end
        return
    end

    if a:match.type != 'match'
        return
    end

    call add(s:matches, a:match)

    let prefix = '' . a:match.data.line_number . ': '
    let lineNumber = line('$')

    call append(lineNumber, prefix . substitute(a:match.data.lines.text, '\n', '', ''))

    for submatch in a:match.data.submatches
        let lineNumber = line('$') - 1
        let length = len(submatch.match.text)
        let columnStart = submatch.start + len(prefix)
        let columnEnd = columnStart + length

        call nvim_buf_add_highlight(
            \ 0, s:hlNamespace, 'SearchReplaceMatch',
            \ lineNumber, columnStart, columnEnd)
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
            call nvim_buf_clear_namespace(0, s:hlNamespace, 0, -1)
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
    file SearchReplace
    setlocal nonumber
    setlocal buftype=nofile
    setlocal nobuflisted
    setlocal foldmethod=expr
    setlocal foldexpr=SearchWindowFoldLevel(v:lnum)

    let s:searchWindowId = win_getid()

    " Create mappings
    if g:searchReplace_closeOnExit
        au BufLeave <buffer> bd
    end
    nnoremap                 <buffer>q     <C-W>c
    nnoremap                 <buffer><Esc> <C-W>p
    nnoremap <silent><nowait><buffer>d     :call <SID>search_deleteLine()<CR>
    nnoremap <silent><nowait><buffer>o     :call <SID>search_openLine()<CR>
    nnoremap <silent><nowait><buffer><CR>  :call <SID>search_openLine()<CR>
    nnoremap   <expr><nowait><buffer><A-r> <SID>replaceMapping()
    nnoremap   <expr><nowait><buffer><C-r> <SID>replaceMapping()

    " Add highlights
    call matchadd('Comment', '^> ', 0)
    call matchadd('Directory', '\v(\> )@<=.*', 0)
    call matchadd('LineNr', '\v^\d+:', 0)
endfunction

function! s:createPromptWindow()
    " Go to existing window if there is one
    if bufnr('SearchReplace__prompt') != -1
        let winids = win_findbuf(bufnr('SearchReplace__prompt'))
        if len(winids) > 0
            call win_gotoid(winids[0])
            call feedkeys('ggA', 'n')
            return
        end

        execute bufnr('SearchReplace__prompt') . 'bwipe!'
    end

    let width = &columns
    let col = (&columns - width)
    let row = &lines - &cmdheight - 1
    let s:promptWindowId = nvim_open_win(0, v:true, {
    \   'style': 'minimal',
    \   'anchor': 'SE',
    \   'relative': 'editor',
    \   'row': row,
    \   'col': col,
    \   'width': width,
    \   'height': 2
    \ })

    enew
    file SearchReplace__prompt
    " setlocal nonumber
    setlocal buftype=nofile
    setlocal nobuflisted
    setlocal winhl=Normal:NormalPopup,EndOfBuffer:NormapPopup

    au BufLeave <buffer> bd

    " Create mappings
    nnoremap                 <buffer><Esc> <C-w>c
    inoremap                 <buffer><Esc> <Esc>
    inoremap                 <buffer><C-c> <Esc><C-w>c
    inoremap                 <buffer><CR>  <Esc>:call <SID>prompt_enter()<CR>
    inoremap                 <buffer><TAB> <Esc>:call <SID>prompt_tab()<CR>

    nnoremap                 <buffer>o     <Nop>
    nnoremap                 <buffer>O     <Nop>
    nnoremap                 <buffer>dd    <Nop>

    " Add highlights
    call matchadd('StatusLine', s:promptPattern)
    call matchadd('StatusLine', s:promptDirectories)

    " Add text
    call append(0, s:promptPattern . s:pattern)
    call append(1, s:promptDirectories . join(s:paths, ', '))

    call feedkeys('ggA', 'n')
endfunction

function! s:closeSearchWindow ()
    if s:searchWindowId == v:null
        return
    end

    if !win_gotoid(s:searchWindowId)
        return
    end

    wincmd c

    let s:searchWindowId = v:null
    let s:isSearching = v:false
endfunction

function! s:closePromptWindow ()
    if s:promptWindowId == v:null
        return
    end

    if !win_gotoid(s:promptWindowId)
        return
    end

    wincmd c

    let s:promptWindowId = v:null
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

function! s:prompt_enter ()
    let s:pattern = s:extractPattern(getline(1))
    let s:paths   = s:extractDirectories(getline(2))
    call s:closePromptWindow()
    call s:runSearch()
endfunc

function! s:prompt_tab ()
    let currentLine = line('.')
    let newLine = currentLine == 1 ? 2 : 1
    Pp [0, newLine, newCol, 0]
    call setpos('.', [0, newLine, 1, 0])
    call feedkeys('A', 'n')
endfunc

function! s:search_deleteLine()
    let text = getline('.')
    let firstLine = line('.')
    if text =~ '^> '
        let lastLine = searchpos('^> ', 'n')[0] - 1
        if lastLine == 0
            let lastLine = line('$')
        end
        execute firstLine . ',' . lastLine . 'delete _'
    elseif text =~ '^\d\+:'
        execute firstLine . 'delete _'
    end
endfunction

function! s:search_openLine()
    let text = getline('.')
    let firstLine = line('.')
    if text =~ '^> '
        let filename = s:extractFilename(text)
        execute g:searchReplace_editCommand . ' ' . filename
    elseif text =~ '^\d\+:'
        let lineNumber = s:extractLineNumber(getline('.'))
        let previousFilenameLine = search('^> .*', 'nb')
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
    return a:line[2:]
endfunc

function! s:extractLineNumber (line)
    return substitute(a:line, ':.*', '', '')
endfunc

function! s:extractPattern (line)
    return substitute(a:line, s:promptPattern, '', '')
endfunc

function! s:extractDirectories (line)
    let input = substitute(a:line, s:promptDirectories, '', '')
    let dirs = split(input, '\s*,\s*')
    return dirs
endfunc

function! SearchWindowFoldLevel (lnum)
    let line = getline(a:lnum)
    if len(line) == 0
        return 0
    end
    return 1
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


let g:searchReplace = s:
