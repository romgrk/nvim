setlocal nonu
setlocal nolist
au BufLeave <buffer> call BookmarkLastHelp()

nm <buffer> q          :wincmd c<CR>
nm <buffer> <esc><esc> :wincmd c<CR>

nm <buffer> <CR>  <c-]>
nm <buffer> <A-n> /\v\\|[^\|]+\\|<CR>:nohl<CR>

nnorem <buffer><nowait> j <C-e>gj
nnorem <buffer><nowait> k <C-y>gk
nm <buffer><nowait> d <C-d>
nm <buffer><nowait> u <C-u>
nm <buffer><nowait> <A-d> <C-d>
nm <buffer><nowait> <A-u> <C-u>

nm <buffer> ]] /\v\<Bar>[^<Bar>]+\<Bar><CR>
nm <buffer> [[ ?\v\<Bar>[^<Bar>]+\<Bar><CR>
