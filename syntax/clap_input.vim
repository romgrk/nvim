
function! s:navigate (times, direction)
    for idx in range(a:times)
        call clap#handler#navigate_result(a:direction)
    endfor
    return ''
endfunc

inoremap <silent> <buffer> <A-j> <C-R>=<SID>navigate(1, 'down')<CR>
inoremap <silent> <buffer> <A-k> <C-R>=<SID>navigate(1, 'up')<CR>

inoremap <silent> <buffer> <A-d> <C-R>=<SID>navigate(5, 'down')<CR>
inoremap <silent> <buffer> <A-u> <C-R>=<SID>navigate(5, 'up')<CR>

inoremap <silent><buffer> <Tab>   <C-O>:call clap#handler#navigate_result('down')<CR>
inoremap <silent><buffer> <S-Tab> <C-O>:call clap#handler#navigate_result('up')<CR>
