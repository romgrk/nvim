setlocal sw=4
setlocal ts=4

nnoremap <buffer> K :YcmCompleter GetDoc<CR>

nnoremap <buffer><silent> gK    :call LanguageClient#textDocument_hover()<CR>
nnoremap <buffer><silent> gd    :call LanguageClient#textDocument_definition()<CR>
nnoremap <buffer><silent> <F2>  :call LanguageClient#textDocument_rename()<CR>
nnoremap <buffer><silent> <F3>  :call LanguageClient#textDocument_references()<CR>
