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
    if (a:type ==# 'c')
        cwindow
    else
        lwindow
    end

    wincmd J

    if (&bt ==# 'quickfix')
        let g:qf_win = winnr()
    end

    "autocmd BufEnter <buffer> call QuickFixEnter()
    "autocmd BufLeave <buffer> call QuickFixLeave()

    call Warn(' -- QF (' . expand('%') . ') -- ')
endfunc
function! QuickFixEnter()
    let max_height = len(getqflist())
    let current_height = winheight(0)

    let b:saved_height = current_height
    if (current_height > max_height)
        execute 'resize ' . max_height
    end
    "au BufReadPost quickfix  setlocal modifiable
                         "\ | silent exe 'g/^/s//\=line(".")." "/'
                         "\ | setlocal nomodifiable
    "resize +10
    "nnoremap <buffer> <Esc><Esc> :wincmd c<CR>
endfunc
function! QuickFixLeave()
    "exec 'resize ' . b:saved_height
    "
endfunc
