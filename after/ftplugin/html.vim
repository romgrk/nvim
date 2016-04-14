"if get(b:, 'current_syntax', '') == 'html'
setlocal tabstop=2 sw=2
"setlocal fdm=indent
imap <silent><buffer> <A-;> <esc><C-e>
imap <silent><buffer> <A-e> <esc><C-e>
imap <buffer> <A-CR> <br/>

"end
