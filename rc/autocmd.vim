" File: autocmd.vim
" Author: romgrk
" Description:
" Last Modified:  5 May 2016
" Exec: !::exe [So]

augroup RC
    au!

    au VimResized * wincmd =

    " Session
    au SessionLoadPost * :SourceLocalVimrc

    " Jump back at last pos
    au BufReadPost * call RestorePosition()
    " Close list
    au BufDelete   * call StoreBuffer(expand('<afile>:p'))

    " Terminal
    if has('nvim')
    au TermOpen * call <SID>on_term_open()
    " au TermOpen * au BufEnter <buffer=abuf> startinsert
    end

    " Cmdwin in ./cmdwin.vim

    " Styling listeners:

    " CursorLine & CursorColumn
    au WinLeave * exe 'setlocal nocursorline nocursorcolumn'
    au WinEnter * if &bt == '' | let &l:cul = &g:cul | end
    au WinEnter * if &bt == '' | let &l:cuc = &g:cuc | end

    " Colors
    au FileType css,scss,sass,less HexokinaseTurnOn

    " Preview
    au BufWinEnter * if &previewwindow | call PreviewOpen()  | end
    au WinEnter    * if &previewwindow | call PreviewEnter() | end
    au WinLeave    * if &previewwindow | call PreviewLeave() | end

    " QuickFix
    au QuickFixCmdPost [^l]* call QuickFixOpen('c')
    au QuickFixCmdPost    l* call QuickFixOpen('l')
    au BufReadPost quickfix  call QuickFixEnter()

    " Auto-Bookmarks
    au FileType help          call BookmarkLastHelp()
    au BufLeave */doc/*.txt   call BookmarkLastHelp()
    au BufLeave ~/notes/*.txt let session.lastnote = @%

augroup END

function! s:did_load (...)
    augroup DeleteTrailingWS
        au!
        " Auto-delete whitespaces at EOL
        au BufWritePre *.py                %DeleteTrailingWS
        au BufWritePre *.[cc,cpp,h,hh,hpp] %DeleteTrailingWS
        au BufWritePre *.[js,ts,tsx]       %DeleteTrailingWS
    augroup END
endfunc
call timer_start(100, function('s:did_load'))


function! s:on_term_open ()
    setlocal nonumber
    setlocal nocursorline nocursorcolumn
    setlocal signcolumn=no
    if exists(':VimadeBufDisable')
        VimadeBufDisable
    end

    setl winhl=Normal:TermNormal,NormalNC:TermNormalNC
endfunc
