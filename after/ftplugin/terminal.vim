setlocal nonumber
setlocal nobuflisted
setlocal nolist
setlocal scrolloff=0

nmap <buffer> i     a
nmap <buffer> <Esc> :wincmd p<CR>

nmap     <buffer> <A-c> <A-c>

"au BufWinEnter,WinEnter <buffer> UpdateTerminalSize
au InsertEnter          <buffer> setlocal nocursorline
