" !::exe [so % | doauto Syntax]
silent au! AutoFold

setlocal foldmethod=syntax

setlocal iskeyword=@,48-57,_,192-255,#

setlocal keywordprg=:ZHelp

nmap <buffer> gH :ZHelp<space>

"nmap <buffer> K  :ZHelp<space><C-R><C-W><CR>

nnoremap <buffer> gdd gd
nmap <buffer> gdg :Goto<space>
nmap <buffer> gdn :Goto nmap
nmap <buffer> gdi :Goto imap
nmap <buffer> gdf :Goto fu <C-R><C-W>
nmap <buffer> gdc :Goto com <C-R><C-W>
nmap <buffer> gdh :Goto hi <C-R><C-W>

imap <A-q><A-i> <Esc>0wy;bf)i

" To make use of pope's endwise
"nmap o A<CR>

nnoremap <buffer> s<A-j> A <Bar><Esc>J
nnoremap <buffer> s<A-k> $F<BAR>dwi<BS><CR><Esc>
nmap <buffer> sJ  s<A-j>
nmap <buffer> sK  s<A-k>

" TODO bundle this in a plugin
fu! s:imap (leader, key, val)
    let leader = a:leader
    let key    = a:key  | let val    = a:val
    execute 'imap <buffer> ' . leader . key . ' ' . val
endfu

let s:leader = '<A-i>'
let s:altkeys   = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
let s:altkeys  .= '1234567890-=[]{};:''"\,<.>/?!@#$%^&*()_+`~'
let s:ctrlkeys  = 'ABCDEFGKLNOPQRSTUVWXYZ1234567890-=[{};:''"\,<.>/?!#$%^&*()_+`~'
" Special keys                                                               {{{
unlet! s:specialKeys
let    s:specialKeys = [
\ ['<',       '<lt>lt>'],
\ ['<CR>',    '<lt>CR>'],
\ ['<Tab>',   '<lt>Tab>'],
\ ['<Esc>',   '<lt>Esc>'],
\ ['<space>', '<lt>space>'],
\ ['<BS>',    '<lt>BS>'],
\ ['=',       '<lt>C-r>='],
\ ['p',       '<lt>Plug>'],
\ ['P',       '<lt>Plug>()<Left>'],
\ ['b',       '<lt>buffer>'],
\ ['e',       '<lt>expr>'],
\ ['s',       '<lt>silent>'],
\ ['S',       '<lt>SID>'],
\ ['i',       '<lt>SID>'],
\ ['u',       '<lt>unique>'],
\ ['\',       '\<lt>Bar>'],
\ ['\|',      '<lt>Bar>'],
\ [',',       '<lt>leader>'],
\ ['j',       '<lt>Down>'],
\ ['k',       '<lt>Up>'],
\ ['h',       '<lt>Left>'],
\ ['l',       '<lt>Right>'],
\]
"                                                                            }}}

for i in range(len(s:altkeys))
    let k = s:altkeys[i]
    let key = '<A-' . k . '>'
    let val = '<lt>' . key[1:]
    call s:imap(s:leader, key, val)
endfor

for i in range(len(s:ctrlkeys))
    let k = s:ctrlkeys[i]

    let key = '<C-'.k.'>'
    let val = '<lt>'.key[1:]
    call s:imap(s:leader, key, val)

    let key = '<C-A-'.k.'>'
    let val = '<lt>'.key[1:]
    call s:imap(s:leader, key, val)
endfor

for [key, val] in s:specialKeys
    call s:imap(s:leader, key, val)
endfor

" vim: nofoldenable:
