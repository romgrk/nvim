setlocal nonumber
setlocal nobuflisted
setlocal nolist
setlocal scrolloff=0

nmap <buffer> i     a
nmap <buffer> <Esc> :wincmd p<CR>

tnoremap <buffer> <C-A-R> <C-\><C-N>:resize +1<CR>:resize -1<CR>i
tnoremap <buffer> <C-D> <C-D><CR>
nmap     <buffer> <A-c> <A-c>
tmap     <buffer> <A-w> <C-\><C-N><A-w>

"au BufWinEnter,WinEnter <buffer> UpdateTerminalSize
au InsertEnter          <buffer> setlocal nocursorline
