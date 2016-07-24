" File: autocmd.vim
" Author: romgrk
" Description:
" Last Modified:  5 May 2016
" Exec: !::exe [source %]

exe 'augroup RC'
    au!

    "au FocusLost * wa!
    au VimLeave *  SaveSession!
    au QuitPre  *  SaveSession!

    " Jump back at last pos
    au BufReadPost * call RestorePosition()

    " Close list
    au BufDelete   * call StoreBuffer(expand('<afile>'))

    " Save/load current vim state when exiting/opening a file
    " au VimLeave ?* mkview!
    " au VimEnter ?* silent loadview

    " Cursor line&column
    au WinLeave * setlocal nocursorline
    au WinLeave * setlocal nocursorcolumn
    au WinEnter * let &l:cul = &g:cul
    au WinEnter * let &l:cuc = &g:cuc

    " Preview
    au BufWinEnter * if &previewwindow | call PreviewOpen()  | end
    au WinEnter    * if &previewwindow | call PreviewEnter() | end
    au WinLeave    * if &previewwindow | call PreviewLeave() | end

    " Terminal
    au TermOpen * setfiletype terminal
    au TermOpen * au BufEnter <buffer=abuf> startinsert

    " Cmdwin in ./cmdwin.vim

    " QuickFix
    au QuickFixCmdPost [^l]* cwindow | call QuickFixOpen('c')
    au QuickFixCmdPost    l* lwindow | call QuickFixOpen('l')

    "au BufReadPost quickfix  setlocal modifiable
                         "\ | silent exe 'g/^/s//\=line(".")." "/'
                         "\ | setlocal nomodifiable

    " Auto-Bookmarks
    au FileType help          call BookmarkLastHelp()
    au BufLeave */doc/*.txt   call BookmarkLastHelp()
    au BufLeave ~/notes/*.txt let session.lastnote = @%

    " Filetype-specific autocommands:
    "au BufWritePre,FileWritePre *.file  ks|call LastMod()|'s
    "au BufWritePre,FileWritePre *.vim   ks|call LastMod()|'s
    "au BufReadPost,BufNewFile package.json  Vison package.json

    au BufReadPost,BufNewFile * if (&omnifunc == "")
                             \|     setlocal omnifunc=syntaxcomplete#Complete
                             \| end

    " Colors
    au FileType    css      call colorizer#ColorHighlight(1)
    au FileType    sass     call colorizer#ColorHighlight(1)
    au FileType    scss     call colorizer#ColorHighlight(1)
    au FileType    less     call colorizer#ColorHighlight(1)

exe 'augroup END'

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
