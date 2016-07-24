setlocal expandtab
setlocal ts=2 sw=2
setlocal foldmethod=indent

imap <silent><buffer> <A-;> <Esc><C-E>
imap <silent><buffer> <A-e> <Esc><C-E>
imap <buffer> <A-CR>  <br/>

nmap <buffer> <Tab>   %
xmap <buffer> <Tab>   %

" inoremap <silent><expr><buffer> <Tab> pumvisible()
            " \ ? "" \ : "=emmet#expandAbbr(0,"")"

"end
