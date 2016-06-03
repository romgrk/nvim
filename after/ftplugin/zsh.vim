
setlocal iskeyword=@,48-57,192-255,#,_
setlocal foldmethod=expr
setlocal foldexpr=GetIndentFold(v:lnum)

nmap <buffer> <F2> :!%<CR>

inoremap <buffer> $ $<C-X><C-I><C-P>

let b:complete = "\<C-X>\<C-O>\<C-P>"
