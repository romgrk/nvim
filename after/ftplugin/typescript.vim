"au BufWritePost <buffer=abuf> call exeline#find()
setlocal fdm=syntax
nmap <buffer> <Leader>e <Plug>(TsuquyomiRenameSymbol)
nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>
