" File: autocmd.vim
" Author: romgrk
" Description:
" Last Modified:  5 May 2016
" Exec: !::exe [So]

exe 'augroup RC'
    au!

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

    "au FocusLost * wa!
    au VimLeave *  SaveSession!
    au QuitPre  *  SaveSession!

    au SessionLoadPost * SourceLocalVimrc

    " Save/load current view
    "au VimLeave ?* mkview!
    "au VimEnter ?* silent loadview

    " Jump back at last pos
    au BufReadPost * call RestorePosition()
    " Close list
    au BufDelete   * call StoreBuffer(expand('<afile>'))

    " Terminal
    if has('nvim')
    au TermOpen * setfiletype terminal
    au TermOpen * au BufEnter <buffer=abuf> startinsert
    end

    " Cmdwin in ./cmdwin.vim


    " Styling listeners:

    " Modified-buffer styling
    au BufReadPost,BufNewFile * call BufferReadHandler()

    " CursorLine & CursorColumn
    au WinLeave * setlocal nocursorline nocursorcolumn
    au WinEnter * let &l:cul = &g:cul
    au WinEnter * let &l:cuc = &g:cuc

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
    au BufNewFile,BufReadPost .babelrc setfiletype json
    au BufNewFile,BufReadPost .tern-project setfiletype json

    "au BufWritePre,FileWritePre *.vim   ks|call LastMod()|'s
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
    au BufWritePre *.vim      %DeleteTrailingWS
    au BufWritePre *.coffee   %DeleteTrailingWS
    au BufWritePre *.[cc,cpp] %DeleteTrailingWS
augroup END

augroup Colorizer
    au!
augroup END
