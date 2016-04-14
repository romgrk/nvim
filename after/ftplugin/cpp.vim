"setlocal fdm=
:setlocal fdm=expr
:setlocal foldexpr=GetIndentFold(v:lnum)
nmap <buffer> =h   :call ToggleHeader()<CR>
nmap <buffer> gh   :call ToggleHeader()<CR>
nmap <buffer> <F4> :call ToggleHeader()<CR>
