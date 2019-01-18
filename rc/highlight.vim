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

hi! link QuickFixLine Highlight

"call hi#("Highlight", hi#("Search"))

hi! link    Noise          Comment

call hi#('SessionTab',   ['#ffb700', colors.base02, 'none' ] )

" }}}
" Plugin specific                                                            {{{

hi! link NERDtreeDir Directory

hi! link CtrlPTagKind            Delimiter
hi! link CtrlPMatch              Error

hi! link TagbarScope             Class
hi! link TagbarFoldIcon          Comment

hi! link SearchReplaceMatch      EasyMotionTargetDefault
hi! link SneakLabel              EasyMotionTargetDefault
hi! link SneakLabelMask          Noise

hi! link ALEErrorSign   TextError
hi! link ALEWarningSign TextWarning
hi! link ALEInfoSign    TextInfo

silent call hi#fullfill('ALEErrorSign')
silent call hi#fullfill('ALEWarningSign')
silent call hi#fullfill('ALEInfoSign')
silent call hi#bg('ALEErrorSign',   hi#bg('LineNr'))
silent call hi#bg('ALEWarningSign', hi#bg('LineNr'))
silent call hi#bg('ALEInfoSign',    hi#bg('LineNr'))


if (&bg == 'light')
    hi! link MatchParen          bg_brightteal
    hi! link hiPairs_matchPair   bg_brightteal
    hi! link hiPairs_unmatchPair bg_brightteal

    hi! link HighlightedyankRegion Highlight

    " GitGutter                                                                  {{{
    hi! link GitGutterAdd          DiffAdded
    hi! link GitGutterDelete       DiffRemoved
    hi! link GitGutterChange       DiffModified
    hi! link GitGutterChangeDelete DiffRemoved
    " }}}
else
    hi! link MatchParen          b_brightteal
    hi! link hiPairs_matchPair   b_brightteal
    hi! link hiPairs_unmatchPair b_brightteal

    hi! link HighlightedyankRegion Search

    " GitGutter                                                                  {{{
    let s:bg = hi#bg('LineNr')
    call hi#('GitGutterAdd',          hi#fg('TextSuccess'), s:bg, '')
    call hi#('GitGutterDelete',       hi#fg('TextError'),   s:bg, '')
    call hi#('GitGutterChange',       hi#fg('TextInfo'),    s:bg, '')
    call hi#('GitGutterChangeDelete', hi#fg('TextWarning'), s:bg, '')
    " }}}
end

call hi#('multiple_cursors_cursor', colors.darkred, colors.pink, 'bold')
hi! link multiple_cursors_visual visual


" }}}
" Notes, notation, etc.                                                      {{{
hi! link vifmNotation        OldSpecial
hi! link notesXXX            TextError
hi! link notesDoneMarker     TextSuccess
hi! link notesTODO           TextWarning
" }}}
