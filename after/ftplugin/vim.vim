"============================================================================
" File: vim.vim
" Author: romgrk
" Date: 24 Jul 2016
" Description: here
" !::exe [so % | doauto Syntax]
"============================================================================

let b:argwrap_line_prefix = '\'

setlocal isident=@,48-57,_,192-255,#

nnoremap <buffer> gdd         :Goto<space>
nnoremap <buffer> gdm         :GotoMap<space>
nnoremap <buffer> gdn         :GotoNm<space>
nnoremap <buffer> gdf         :GotoFu <C-R><C-W>
nnoremap <buffer> gdc         :GotoCom <C-R><C-W>
nnoremap <buffer> gdo         :GotoSet <C-R><C-W>
nnoremap <buffer> gdh         :GotoHi<space>
nnoremap <buffer> s<A-j>      A <Bar><Esc>J
nnoremap <buffer> s<A-k>      $F<BAR>dwi<BS><CR><Esc>
nmap     <buffer> sJ          s<A-j>
nmap     <buffer> sK          s<A-k>

function! s:imap (leader, key, val)
    let leader = a:leader
    let key    = a:key  | let val    = a:val
    execute 'imap <buffer> ' . leader . key . ' ' . val
endfunc
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
\ ['[',       '<leader>'],
\ ['<BS>',    '<lt>BS>'],
\ ['=',       '<lt>C-r>='],
\ ['P',       '<lt>Plug>'],
\ ['p',       '<lt>Plug>()<Left>'],
\ ['b',       '<lt>buffer>'],
\ ['n',       '<lt>nowait>'],
\ ['e',       '<lt>expr>'],
\ ['s',       '<lt>silent>'],
\ ['i',       '<lt>SID>'],
\ ['u',       '<lt>unique>'],
\ ['\',       '<lt>Bar>'],
\ ['\|',      '\<lt>Bar>'],
\ [',',       '<lt>leader>'],
\ ['j',       '<lt>Down>'],
\ ['k',       '<lt>Up>'],
\ ['h',       '<lt>Left>'],
\ ['l',       '<lt>Right>'],
\]
" }}}

for i in range( len(s:altkeys))
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
