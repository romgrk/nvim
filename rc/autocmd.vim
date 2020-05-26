" File: autocmd.vim
" Author: romgrk
" Description:
" Last Modified:  5 May 2016
" Exec: !::exe [So]

function! s:onTermOpen ()
    au BufEnter <buffer> startinsert
    setfiletype terminal
    setlocal nocursorline nocursorcolumn
    setlocal signcolumn=no
    VimadeBufDisable

    if hi#exists('TermNormal') && !exists('b:fzf')
        setl winhl=Normal:TermNormal,NormalNC:TermNormalNC
    else
        setl winhl=Normal:Normal,NormalNC:NormalNC
    end

    startinsert
endfunc

exe 'augroup RC'
    au!

    au BufWritePost */plugins/*.vim     So

    au VimEnter * nested let g:previous_columns = &columns
    au VimResized * if (&columns < (g:previous_columns - 2) / 2)
                 \|   only
                 \|   let g:previous_columns = &columns
                 \| end
    au VimResized * if ((&columns + 2) > g:previous_columns * 2 && (&columns / 2) >= 80)
                 \|   vsplit
                 \|   exe "normal! \<c-w>="
                 \|   let g:previous_columns = &columns
                 \| end

    " Session
    au VimLeave *        :SaveSession!
    au QuitPre  *        :SaveSession!
    au SessionLoadPost * :SourceLocalVimrc


    " Jump back at last pos
    au BufReadPost * call RestorePosition()
    " Close list
    au BufDelete   * call StoreBuffer(expand('<afile>'))

    " Terminal
    if has('nvim')
    au TermOpen * call <SID>onTermOpen()
    end

    " Cmdwin in ./cmdwin.vim

    " Styling listeners:

    " CursorLine & CursorColumn
    au WinLeave * if &bt == '' | exe 'setlocal nocursorline nocursorcolumn' | end
    au WinEnter * if &bt == '' | let &l:cul = &g:cul | end
    au WinEnter * if &bt == '' | let &l:cuc = &g:cuc | end

    " Colors
    au FileType css,scss,sass,less call colorizer#ColorHighlight(1)


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

    " Filetype-specific autocommands:
    au BufNewFile,BufReadPost .babelrc          setfiletype json
    au BufNewFile,BufReadPost .tern-project     setfiletype json
    au BufNewFile,BufReadPost */components/*.js setfiletype javascript.jsx

    au BufReadPost,BufNewFile * if (&omnifunc == "")
                             \|     setlocal omnifunc=syntaxcomplete#Complete
                             \| end
exe 'augroup END'

augroup TabLine
    au!
    au BufNew,BufDelete       * call TabLineUpdate()
    au BufWinEnter,BufEnter   * call TabLineUpdate()
    au BufWritePost           * call TabLineUpdate()
    au TabEnter,TabNewEntered * call TabLineUpdate()
augroup END

augroup DeleteTrailingWS
    au!
    " Auto-delete whitespaces at EOL
    au BufWritePre *.py       %DeleteTrailingWS
    au BufWritePre *.[cc,cpp] %DeleteTrailingWS
augroup END

augroup Colorizer
    au!
augroup END


" augroup inactive_win
    " au!
    " au ColorScheme *          call hi#('NormalWin', ['none', hi#bg('Normal')])
    " au ColorScheme *          call hi#('InactiveWin', ['none', color#Lighten(hi#bg('Normal'), 0.1)])
    " au FileType,BufWinEnter * call s:configure_winhighlight()
    " au FocusGained *          call hi#('NormalWin', ['none', hi#bg('Normal')])
    " au FocusLost *            call hi#('NormalWin', ['none', color#Lighten(hi#bg('Normal'), 0.1)])
" augroup END

" function! s:configure_winhighlight()
    " let ft = &filetype
    " let bt = &buftype
    " " Check white/blacklist.
    " if index(['dirvish'], ft) == -1
                " \ && (index(['nofile', 'nowrite', 'acwrite', 'quickfix', 'help'], bt) != -1
                " \     || index(['startify'], ft) != -1)
        " set winhighlight=Normal:NormalWin,NormalNC:NormalWin
    " else
        " set winhighlight=Normal:NormalWin,NormalNC:InactiveWin
    " endif
" endfunction
