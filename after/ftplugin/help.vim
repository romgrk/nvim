setlocal nonu
setlocal nolist
call BookmarkLastHelp()
au! Colorizer

nnoremap <buffer> q          :wincmd c<CR>
nnoremap <buffer> <esc><esc> :wincmd c<CR>

nnoremap <buffer>           <CR>    <C-]>
nnoremap <buffer>         <A-CR>    /<C-R><C-W><CR>:nohl<CR>
nnoremap <nowait><buffer>    ]      /\v\\|[^\|]+\\|<CR>:nohl<CR>
nnoremap <nowait><buffer>    [      ?\v\\|[^\|]+\\|<CR>:nohl<CR>
nnoremap <buffer>         <A-]>     /\v\<Bar>[^<Bar>]+\<Bar><CR>
nnoremap <buffer>         <A-[>     ?\v\<Bar>[^<Bar>]+\<Bar><CR>
nnoremap <buffer>         <Tab>     /\|\zs\S\{-}\|/<CR><C-]>

nnoremap <buffer><nowait> j         <C-E>gj
nnoremap <buffer><nowait> k         <C-Y>gk
nnoremap <buffer><nowait> <A-j>     6j
nnoremap <buffer><nowait> <A-k>     5k
"nnoremap <buffer><nowait> <space>   <C-D>
"nnoremap <buffer><nowait> <M-space> <C-U>
nnoremap <buffer><nowait> u         4<C-Y>
nnoremap <buffer><nowait> d         5<C-E>
nnoremap <buffer><nowait> <A-u>     9<C-Y>
nnoremap <buffer><nowait> <A-d>    10<C-E>
