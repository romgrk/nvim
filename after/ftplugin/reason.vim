nnoremap <buffer><silent> gd   :call LanguageClient_textDocument_definition()<CR>
nnoremap <buffer><silent> gq   :call LanguageClient_textDocument_formatting()<CR>
nnoremap <buffer><silent> K    :call LanguageClient_textDocument_hover()<CR>
nnoremap <buffer><silent> <F2> :call LanguageClient_textDocument_rename()<CR>
