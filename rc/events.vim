"============================================================================
" File: events.vim
" Author: romgrk
" Date: 23 Jul 2016
" Description: event handlers
" !::exe [So]
"============================================================================

function! PreviewOpen()
    if (expand('%') =~ '/tmp')
        set nobuflisted
    end
    setlocal nofoldenable
    setlocal nonumber
    setlocal wrap
    normal! 5z
    let g:previewwindow = winnr()
    call Info(' -- PREVIEW (' . expand('%') . ') -- ')
endfunc
function! PreviewEnter()
    resize +10
    nnoremap <buffer> <Esc><Esc> :wincmd c<CR>
endfunc
function! PreviewLeave()
    exec 'resize ' . &previewheight
    silent! nunmap <buffer> <Esc><Esc>
endfunc


function! QuickFixOpen(type)
    setlocal nobuflisted
    setlocal nofoldenable
    setlocal nonumber
    setlocal wrap
    normal! 5z

    autocmd BufEnter <buffer> call QuickFixEnter(a:type)
    autocmd BufLeave <buffer> call QuickFixLeave(a:type)

    call Warn(' -- QF (' . expand('%') . ') -- ')
endfunc
function! QuickFixEnter()
    let b:saved_height = winheight()
    resize +10
    nnoremap <buffer> <Esc><Esc> :wincmd c<CR>
endfunc
function! QuickFixLeave()
    exec 'resize ' . b:saved_height
endfunc




finish




" UNUSED:

function! SessionEnter ()
    call get#Load('.session')
    let g:session.this_session = v:this_session
    " Localrc sourcing...
    "silent execute 'SourceLocalVimrc'
endfunc
function! SessionExit ()
    if exists('g:session')
        call get#Save('.session')
    end
endfunc

