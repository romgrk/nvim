" File: cmdwin.vim
" Author: romgrk
" Date: 17 Mar 2016
" Description: special windows
" !::exe [so %]

exe 'augroup ' . expand('<sfile>')
    au!
    " Command-line window
    au CmdwinEnter [:@=]    call <SID>cmdwinEnter()
    au CmdwinLeave [:@=]    call <SID>cmdwinLeave()

    au CmdwinEnter [/?] call <SID>searchwinEnter()
    au CmdwinLeave [/?] call <SID>searchwinLeave()
exe 'augroup END'

function! s:winEnter ()
    nnoremap <buffer> <CR>  <CR>
    nnoremap <buffer> <Esc> <C-c>
    nmap     <buffer> <A-w> <C-\><C-N>
    nnoremap <buffer> <C-c> <C-\><C-N>
    nnoremap <buffer> q     <C-\><C-N>

    inoremap <buffer> <Esc> <Esc>
    imap     <buffer> <A-w> <Esc><C-\><C-N>
    inoremap <buffer> <C-c> <Esc><C-\><C-N>

    setlocal nonu
endfunc

function! s:cmdwinEnter ()
    call <SID>winEnter()
    "imap <buffer> <Tab> <C-X><C-V>
    let b:cpt_save = &cpt
    set complete=.
    setlocal notimeout
endfunc
function! s:cmdwinLeave ()
    let &cpt = b:cpt_save
endfunc

function! s:searchwinEnter (...)
    call <SID>winEnter()
    setfiletype pattern
    startinsert
endfunc
function! s:searchwinLeave (...)
endfunc
