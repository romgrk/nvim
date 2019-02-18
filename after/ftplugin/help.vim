setlocal nonu
setlocal nolist
setlocal signcolumn=no
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
