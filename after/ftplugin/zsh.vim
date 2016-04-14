
setlocal iskeyword=@,48-57,192-255,#,_
setlocal foldmethod=expr
setlocal foldexpr=GetIndentFold(v:lnum)

nmap <buffer> <F2> :!%<CR>

