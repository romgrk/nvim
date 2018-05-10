nnoremap <buffer><silent> K     :call LanguageClient#textDocument_hover()<CR>
nnoremap <buffer><silent> gd    :call LanguageClient#textDocument_definition()<CR>
nnoremap <buffer><silent> <F2>  :call LanguageClient#textDocument_rename()<CR>
