
function! s:navigate (times, direction)
    for idx in range(a:times)
        call clap#navigation#linewise(a:direction)
    endfor
    return ''
endfunc

inoremap <silent><buffer> <Esc>   <C-O>:<C-u>call clap#handler#exit() <Bar> stopinsert<CR>

inoremap <silent><buffer> <A-j>   <C-R>=<SID>navigate(1, 'down')<CR>
inoremap <silent><buffer> <A-k>   <C-R>=<SID>navigate(1, 'up')<CR>

inoremap <silent><buffer> <A-d>   <C-R>=<SID>navigate(5, 'down')<CR>
inoremap <silent><buffer> <A-u>   <C-R>=<SID>navigate(5, 'up')<CR>

inoremap <silent><buffer> <Tab>   <C-O>:<C-u>call clap#navigation#linewise('down')<CR>
inoremap <silent><buffer> <S-Tab> <C-O>:<C-u>call clap#navigation#linewise('up')<CR>

inoremap <silent><buffer> <A-u> <C-r>=clap#handler#back_action()<CR>
inoremap <silent><buffer> <A-h> <C-r>=clap#handler#back_action()<CR>
inoremap <silent><buffer> <A-l> <C-r>=clap#handler#tab_action()<CR>
