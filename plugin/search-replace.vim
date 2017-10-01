"!::exe [So]

let s:isSearching = v:false
let s:matches = {}
let s:directory = '.'
let s:paths = ['.']
let s:pattern = ''
let s:replacement = ''
let s:waitingCount = 0
let s:replacementTotal = 0
let s:replacementFileTotal = 0
let s:replacementJobs = []

command! -nargs=* -complete=dir Search    :call <SID>runSearch(<f-args>)
command! -nargs=1               Replace   :call <SID>runReplace(<f-args>)

function! s:run(cmd, cwd, Fn)
    let opts = {}
    let opts.cwd = fnamemodify(expand(a:cwd), ':p')
    let opts.stdout = []
    let opts.stderr = []
    let opts.on_stdout = {jobID, data, event -> extend(opts.stdout, data)}
    let opts.on_stderr = {jobID, data, event -> extend(opts.stderr, data)}
    let opts.on_exit = a:Fn
    let opts.jobID = jobstart(a:cmd, opts)
    return opts
endfunction

function! s:runSearch(pattern, ...)
    let s:pattern = s:escape(a:pattern)

    let s:paths = ['.']
    if a:0 > 0
        let s:paths = a:000
    end

    let command = "rg -n '" . s:pattern . "' " . join(s:paths)

    call s:run(
            \ command,
            \ s:directory,
            \ function('s:onExitSearch'))
endfunction

function! s:runReplace(replacement)
    if !s:isSearching
        return | end
    let s:isSearching = v:false
    let s:replacement = s:escape(a:replacement)

    let s:replacementJobs = []

    let matches = {}
    let currentFile = ''
    for n in range(1, line('$'))
        let text = getline(n)
        if text =~ '^###'
            let currentFile = text[4:-4]
            let matches[currentFile] = []
        else
            let line = matchstr(text, '\v\d+:@=')
            call add(matches[currentFile], line)
        end
    endfor

    let files = keys(matches)

    let s:replacementTotal = 0
    let s:replacementFileTotal = 0

    for file in files
        let lines = join(matches[file], ',')
        let command = "sed -i '" . lines . "s/" . s:pattern . "/" . s:replacement . "/g' " . file
        let s:replacementFileTotal = s:replacementFileTotal + 1
        let s:replacementTotal = s:replacementTotal + len(matches[file])
        call s:run(command, s:directory, function('s:onExitReplace'))
    endfor

    let s:waitingCount = s:replacementFileTotal
endfunction

function! s:onExitSearch(...) dict
    let chunks = filter(self.stdout, {key, val -> val != ''})
    let parts = map(chunks, {key, val -> split(val, ':')})

    let s:matches = {}
    let totalMatches = 0
    for p in parts
        if len(p) < 3
            continue
        end
        let file = p[0]
        let line = p[1]
        let text = substitute(join(p[2:], ':'), '^\s\+', '', '')

        if !has_key(s:matches, file)
            let s:matches[file] = []
        end
        call add(s:matches[file], { 'line': line, 'text': text })
        let totalMatches = totalMatches + 1
    endfor

    if len(s:matches) == 0
        call EchonHL('Normal', 'No match found for ')
        call EchonHL('Special', s:pattern)
        return
    end

    let s:isSearching = v:true

    " Open scratch buffer to display results
    let height = len(s:matches) + totalMatches
    if height > 10
        let height = 10
    end

    split
    wincmd J
    exe height . 'wincmd _'
    enew
    setlocal nonumber
    setlocal buftype=nofile

    " Create mappings
    au BufLeave <buffer> bd
    nnoremap                 <buffer><Esc> <C-W>p
    nnoremap         <nowait><buffer><A-r> :Replace<space>
    nnoremap <silent><nowait><buffer>d     :call <SID>deleteLine()<CR>

    " Display content
    let lastFile = ''
    for f in keys(s:matches)
        let matches = s:matches[f]
        call append(line('$'), '### ' . f . ' ###')
        for m in matches
            call append(line('$'), '' . m.line . ': ' . m.text)
        endfor
    endfor
    normal! dd
    call matchadd('SneakLabel', s:pattern)
    call matchadd('Comment', '###')
    call matchadd('Directory', '\v(###)@<=.*(###)@=')
    call matchadd('Label', '\v^\d+:')
endfunction

function! s:onExitReplace(...) dict
    let self.stdout = filter(self.stdout, {key, val -> val != ''})
    call add(s:replacementJobs, self)

    let s:waitingCount = s:waitingCount - 1
    if s:waitingCount != 0
        Pp 'Waiting: ', s:waitingCount
        return
    end

    wincmd c

    call timer_start(100, function('s:displayDone'))
endfunction

function! s:displayDone(...)
    call EchonHL('Normal', 'Done (')
    call EchonHL('Success', s:replacementTotal)
    call EchonHL('Normal', ' replacements in ')
    call EchonHL('Success', s:replacementFileTotal)
    call EchonHL('Normal', ' files )')
endfunction

function! s:deleteLine()
    let text = getline('.')
    let firstLine = line('.')
    if text =~ '^###'
        let lastLine = searchpos('^###', 'n')[0] - 1
        if lastLine == 0
            let lastLine = line('$')
        end
        execute firstLine . ',' . lastLine . 'delete'
    else
        execute firstLine . 'delete'
    end
endfunction

function! s:escape(pattern)
    return substitute(a:pattern, "'", "''", 'g')
endfunction
