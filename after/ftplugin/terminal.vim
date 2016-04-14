setlocal nonu
setlocal nobuflisted
au BufEnter <bufer> startinsert

nmap <buffer> i     a
nmap <buffer> <Esc> :wincmd p<CR>

tnoremap <buffer> <C-A-r> <C-\><C-N>:resize<CR>i
tmap <buffer> <A-c> <A-c>
nmap <buffer> <A-c> <A-c>
