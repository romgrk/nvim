"setlocal fdm=
setlocal fdm=expr
setlocal foldexpr=GetIndentFold(v:lnum)
setlocal foldlevel=1

nnoremap <buffer> gh   :call ToggleHeader()<CR>
nnoremap <buffer> <F4> :call ToggleHeader()<CR>

" nnoremap <buffer> <leader>yc :YcmCompleter<space>

" nnoremap <buffer><silent> gd   :YcmCompleter GoTo<CR>
" nnoremap <buffer><silent> gD   :YcmCompleter GoToDefinition<CR>
" nnoremap <buffer><silent> K    :YcmCompleter GetDoc<CR>
