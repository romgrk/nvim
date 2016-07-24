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

    au CmdwinEnter [/?]     call <SID>searchwinEnter()
    au CmdwinLeave [/?]     call <SID>searchwinLeave()
exe 'augroup END'

function! s:winEnter ()
    let g:session_autosave_periodic = 0
    autocmd! CursorHold  <buffer>
    autocmd! CursorHoldI <buffer>

    nnoremap <buffer> <CR>  <CR>
    nnoremap <buffer> <Esc> <C-C>
    nmap     <buffer> <A-w> <C-\><C-N>
    nnoremap <buffer> <C-C> <C-\><C-N>
    nnoremap <buffer> q     <C-\><C-N>

    inoremap <buffer> <Esc> <Esc>
    imap     <buffer> <A-w> <Esc><C-\><C-N>
    inoremap <buffer> <C-C> <Esc><C-\><C-N>
endfunc

function! s:winLeave ()
    let g:session_autosave_periodic = 1
endfunc

function! s:cmdwinEnter ()
    call <SID>winEnter()
    let opts = ['cpt', 'to']
    let b:opts = { }
    for l:o in l:opts
        let b:opts[l:o] = eval('&' . l:o)
    endfor
    setlocal complete=.
    setlocal notimeout
    setlocal nonumber
endfunc

function! s:cmdwinLeave ()
    if exists('b:opts')
        for l:o in keys(b:opts)
            let cmd = printf('let &%s = b:opts["%s"]', l:o, l:o)
            echo cmd
            execute cmd
        endfor
    end
    call <SID>winLeave()
endfunc

function! s:searchwinEnter (...)
    call <SID>winEnter()
    setfiletype pattern
    startinsert
endfunc
function! s:searchwinLeave (...)
    call <SID>winLeave()
endfunc
