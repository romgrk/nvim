setlocal nobuflisted
setlocal nonumber

nnoremap <buffer> <CR> <CR>
"nnoremap <buffer> j     :cprevious<CR>
"nnoremap <buffer> k     :cnext<CR>
nnoremap <buffer> p     :cnext<CR>
nnoremap <buffer> n     :cprevious<CR>
nnoremap <nowait><buffer> <Esc> :WinMain<CR>
nnoremap <nowait><buffer> q     :wincmd c<CR>
