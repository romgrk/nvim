"syn region liquidStatement matchgroup=Class start='{%' end='%}'
"syn region liquidVariable matchgroup=Class start='{{' end='}}'

"hi! link liquidStatement PreProc
"hi! link liquidVariable PreProc
imap <buffer> <A-;> <C-E>
