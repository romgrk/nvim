
tmap  <buffer> <Esc> <NOP>
tmap  <buffer> <Esc><Esc> <C-c>
tnore <buffer> <A-k> <Esc>k
tnore <buffer> <A-l> <Esc>l

"setlocal laststatus=0
"au BufLeave <buffer> setlocal laststatus=2
call lightline#update_once()
