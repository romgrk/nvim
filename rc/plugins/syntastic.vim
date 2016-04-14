" !::exe [so %]
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let syntastic_error_symbol   = ' '
"let syntastic_warning_symbol = ' '
let syntastic_error_symbol   = ' '
let syntastic_warning_symbol = ' '
"                
"          
"            
"            
let syntastic_javascript_checkers = ['eslint']
let syntastic_typescript_checkers = ['tslint']
let syntastic_clang_checkers = ['clang']
"hi! link SyntasticWarning None
fu! SyntasticHighlight ()
    let bg = hi#bg('LineNr')
    call hi#('SyntasticErrorSign',   hi#fg('ErrorMsg'),   bg)
    call hi#('SyntasticWarningSign', hi#fg('WarningMsg'), bg)
endfu
call SyntasticHighlight()
au ColorScheme * call SyntasticHighlight()
"let syntastic_check_on_open = 1
"let syntastic_check_on_wq = 0
let syntastic_auto_loc_list = 1
"let syntastic_always_populate_loc_list = 0
