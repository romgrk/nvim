" File: autocmd.vim
" Author: romgrk
" Description:
" Last Modified:  5 May 2016
" Exec: !::exe [source %]

exe 'augroup RC'
    au!

    "au FocusLost * wa!
    au QuitPre *  SaveSession!
    au VimLeave *  SaveSession!

    " Jump back at last pos
    au BufReadPost * call RestorePosition()
    " Close list
    au BufDelete   * call StoreBuffer(expand('<afile>'))

    " Cursor line
    au WinLeave * setlocal nocursorline
    au WinEnter * setlocal cursorline
    au WinEnter * if (&bl && (&tw > winwidth(0)) && get(g:, 'autowidth', 0))
               \| echo win#().width(&tw) | end

    " Preview
    au BufWinEnter * if &previewwindow | call PreviewOpen()  | end
    au WinEnter    * if &previewwindow | call PreviewEnter() | end
    au WinLeave    * if &previewwindow | call PreviewLeave() | end

    " Terminal
    au TermOpen * setfiletype terminal
    au TermOpen * au BufEnter <buffer=abuf> startinsert

    " Cmdwin in ./cmdwin.vim

    " Quickfix TODO use this hook
    au QuickFixCmdPost [^l]* nested cwindow
    au QuickFixCmdPost    l* nested lwindow
    "au BufReadPost quickfix  setlocal modifiable
                         "\ | silent exe 'g/^/s//\=line(".")." "/'
                         "\ | setlocal nomodifiable

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
    au BufReadPost,BufNewFile * if (&omnifunc == "")
                             \|     setlocal omnifunc=syntaxcomplete#Complete
                             \| end

    " Colors
    au FileType css  ColorHighlight
    au FileType sass ColorHighlight
    au FileType scss ColorHighlight
    au FileType less ColorHighlight
    au BufReadPost */colors/*.vim ColorHighlight

    " Conceal leading spaces
    au FileType * if (&bt=='') | call LeadingSP() | end

exe 'augroup END'

function! LeadingSP ()
    syntax match LeadingSP   / /    contained conceal cchar=·
    syntax match LeadingSP_R /^ \+/ contains=LeadingSP containedin=ALLBUT,Comment transparent
endfunc

function! PreviewOpen()
    setlocal nofoldenable
    setlocal nonumber
    setlocal wrap
    let g:previewwindow = winnr()
    Log ' -- PREVIEW (' . expand('%') . ') -- '
endfunc
function! PreviewEnter()
    resize +10
    nnoremap <buffer> <Esc><Esc> :wincmd c<CR>
endfunc
function! PreviewLeave()
    exec 'resize ' . &previewheight
    nunmap! <buffer> <Esc><Esc>
endfunc

augroup Colorizer
    au!
augroup END
