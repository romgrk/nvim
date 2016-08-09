" vim: fdm=marker
" File: highlight.vim
" Author: romgrk
" Date: 16 Oct 2015
" !::exe [So]

exe 'augroup ' . expand('<sfile>:t') | au!
au ColorScheme * exe 'source ' . expand('<sfile>:p')
au VimEnter * :call pp#prettyTheme()
exe 'augroup END'

" General                                                                    {{{

let bg_normal = hi#bg('Normal')
let bg_normal = (bg_normal[0] != '#') ? '#282828' : bg_normal
let bg_light  = color#Lighten(bg_normal, '0.3')

call hi#("Highlight", hi#("Search"))
call hi#('AutoHL', 'none', bg_light, 'none')

hi! link    Noise          Comment
hi!         FoldedLineNr   guifg=#599eff

call hi#('MediumGreen',  ['#005f00', '#afdf00'] )
call hi#('MediumOrange', ['#870000', '#ffb700'] )
call hi#('SessionTab',   ['#ffb700', colors.base02, 'none' ] )
call hi#('cFunctionTag', hi#fg('Function'), bg_light, 'none')
call hi#('cTypeTag',     hi#fg('Type'),     bg_light, 'none')

" }}}
" Plugin specific                                                            {{{

hi! link NERDtreeDir Directory

hi! link CtrlPTagKind            Delimiter
hi! link CtrlPMatch              Error

hi! link TagbarScope             Class
hi! link TagbarFoldIcon          Comment

if (&bg == 'light')
    let indentLine_color_gui ='#bebebe'
    hi! IndentGuidesEven guibg=#eeeeee
    hi! link IndentGuidesOdd  Folded

    hi! link MatchParen          bg_brightteal
    hi! link hiPairs_matchPair   bg_brightteal
    hi! link hiPairs_unmatchPair bg_brightteal
else
    let indentLine_color_gui ='#303030'
    hi! IndentGuidesEven guibg=#212121
    hi! IndentGuidesOdd  guibg=#2d2d2d

    hi! link MatchParen          b_brightteal
    hi! link hiPairs_matchPair   b_brightteal
    hi! link hiPairs_unmatchPair b_brightteal
end

call hi#('multiple_cursors_cursor', colors.darkred, colors.pink, 'bold')
call hi#('multiple_cursors_visual', hi#('Visual'))

" }}}
" GitGutter                                                                  {{{
let s:bg = hi#bg('LineNr')
call hi#('GitGutterAdd',          hi#fg('Success'), s:bg, '')
call hi#('GitGutterDelete',       hi#fg('Error'),   s:bg, '')
call hi#('GitGutterChange',       hi#fg('Info'),    s:bg, '')
call hi#('GitGutterChangeDelete', hi#fg('Warning'), s:bg, '')
" }}}
" Notes, notation, etc.                                                      {{{
hi! link vifmNotation  OldSpecial
hi! link notesXXX            ErrorMsg
hi! link notesDoneMarker     TextSuccess
hi! link notesTODO           TextWarning
" }}}
" ExtraWhitespace [disabled]                                                 {{{
" highlight ExtraWhitespace ctermfg=166 guifg=#d65d0e
" augroup ExtraWhitespace
    " au!
    " " this one is which you're most likely to use?
    " autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    " autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    " autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    " autocmd BufWinLeave * call clearmatches()
" augroup END
"}}}

if get(g:, 'colors_name') is 'materialtheme'
    hi Folded guibg=#2f3e46 guifg=none
    hi! link BufferActive Normal
    hi! link BufferActiveMod Type
    hi! link TabLineFill CursorLine
    hi! link CursorLineNr Delimiter
    hi! Visual guibg=#3a4d56
end
