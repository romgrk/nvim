setlocal nonu
setlocal nolist
call BookmarkLastHelp()

nnoremap <buffer> q          :wincmd c<CR>
nnoremap <buffer> <esc><esc> :wincmd c<CR>

nnoremap <buffer> <CR>   <C-]>
nnoremap <buffer> <A-CR> /<C-R><C-W><CR>:nohl<CR>
nnoremap <nowait><buffer> ] /\v\\|[^\|]+\\|<CR>:nohl<CR>
nnoremap <nowait><buffer> [ ?\v\\|[^\|]+\\|<CR>:nohl<CR>
nnoremap <buffer> <A-]> /\v\<Bar>[^<Bar>]+\<Bar><CR>
nnoremap <buffer> <A-[> ?\v\<Bar>[^<Bar>]+\<Bar><CR>

nnoremap <buffer><nowait> j         <C-E>gj
nnoremap <buffer><nowait> k         <C-Y>gk
nnoremap <buffer><nowait> <A-j>     5<C-E>
nnoremap <buffer><nowait> <A-k>     5<C-Y>
nnoremap <buffer><nowait> <space>   <C-d>
nnoremap <buffer><nowait> <M-space> <C-u>
nnoremap <buffer><nowait> d         <C-d>
nnoremap <buffer><nowait> u         <C-u>
nnoremap <buffer><nowait> <A-d>     <C-d>
nnoremap <buffer><nowait> <A-u>     <C-u>

