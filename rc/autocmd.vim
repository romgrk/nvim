" File: autocmd.vim
" Author: romgrk
" Description:
" Last Modified: 26 March 2016
" Exec: !::exe [source %]

exe 'augroup RC'
    au!

    au WinLeave * setlocal nocursorline
    au WinEnter * setlocal cursorline
    au WinEnter * if (&buflisted && (&tw > winwidth(0)) && get(g:, 'autowidth', 1))
               \|     echo win#().width(&tw)
               \| end

    " Cmdwin in ./cmdwin.vim

    " Preview
    au BufWinEnter * if &previewwindow
                  \|    call PreviewEnter()
                  \| end

    " Terminal
    au TermOpen * setfiletype terminal
    au TermOpen * au BufEnter <buffer=abuf> startinsert

    " Close list
    au BufDelete * call StoreBuffer(expand('<afile>'))

    " Auto-detect tab length
    au BufReadPost * call AutodetectShiftWidth()

    " Quickfix
    au BufReadPost,BufEnter quickfix nmap <buffer> <CR>  <CR>
    au BufReadPost,BufEnter quickfix nmap <buffer> <Esc> :cclose<CR>

    " Auto-Bookmarks
    au FileType help          call BookmarkLastHelp()
    au BufLeave */doc/*.txt   call BookmarkLastHelp()
    au BufLeave ~/notes/*.txt let session.lastnote = @%

    " Auto-delete whitespaces at EOL
    au BufWritePre *.py       %DeleteTrailingWS
    au BufWritePre *.vim      %DeleteTrailingWS
    au BufWritePre *.coffee   %DeleteTrailingWS
    au BufWritePre *.[cc,cpp] %DeleteTrailingWS

    "au BufWritePre,FileWritePre *.file  ks|call LastMod()|'s
    "au BufWritePre,FileWritePre *.vim   ks|call LastMod()|'s

    au BufReadPost,BufNewFile package.json  Vison package.json
    au BufReadPost,BufNewFile *
    \  if &omnifunc == ""
    \|     setlocal omnifunc=syntaxcomplete#Complete
    \| end

    " Colors
    au FileType css  ColorHighlight
    au FileType sass ColorHighlight
    au FileType scss ColorHighlight

exe 'augroup END'

augroup Pulse
autocmd! User PrePulse
autocmd! User PostPulse
autocmd  User PrePulse  set cursorcolumn
autocmd  User PostPulse set nocursorcolumn
augroup END

augroup Colorizer
    au!
augroup END
