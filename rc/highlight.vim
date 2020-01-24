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
hi! link NERDtreeCWD Special

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


hi! CocInfoSign                       guifg=#0E8FFF
hi! CocInfoHighlight    gui=undercurl guisp=#0E8FFF
hi! CocWarningSign                    guifg=#FF9F0E
hi! CocWarningHighlight gui=undercurl guisp=#FF9F0E
hi! CocErrorSign                      guisp=#ff1010
hi! CocErrorHighlight   gui=undercurl guisp=#ff1010

hi! CocInfoFloat                      guifg=white
hi! CocWarningFloat                   guifg=#FFDD86
hi! CocErrorFloat                     guifg=#FDC1C1


" === Clap ===

hi! link ClapCurrentSelection Visual
hi! link ClapPopupCursor      Visual
hi! link ClapInput            NormalPopup
hi! link ClapSearchText       NormalPopup
hi! link ClapDisplay          NormalPopup
hi! link ClapMatches          EasyMotionTargetDefault
hi! link ClapPreview          StatusLine
hi! link ClapSpinner          StatusLine
hi! link ClapQuery            Normal

hi! link ClapFile             NormalPopup

hi! link ClapMatches1 EasyMotionTargetDefault
hi! link ClapMatches2 EasyMotionTargetDefault
hi! link ClapMatches3 EasyMotionTargetDefault
hi! link ClapMatches4 EasyMotionTargetDefault
hi! link ClapMatches5 EasyMotionTargetDefault
hi! link ClapMatches6 EasyMotionTargetDefault
hi! link ClapMatches7 EasyMotionTargetDefault
hi! link ClapMatches8 EasyMotionTargetDefault
hi! link ClapMatches9 EasyMotionTargetDefault
hi! link ClapMatches10 EasyMotionTargetDefault
hi! link ClapFuzzyMatches1 EasyMotionTargetDefault
hi! link ClapFuzzyMatches2 EasyMotionTargetDefault
hi! link ClapFuzzyMatches3 EasyMotionTargetDefault
hi! link ClapFuzzyMatches4 EasyMotionTargetDefault
hi! link ClapFuzzyMatches5 EasyMotionTargetDefault
hi! link ClapFuzzyMatches6 EasyMotionTargetDefault
hi! link ClapFuzzyMatches7 EasyMotionTargetDefault
hi! link ClapFuzzyMatches8 EasyMotionTargetDefault
hi! link ClapFuzzyMatches9 EasyMotionTargetDefault
hi! link ClapFuzzyMatches10 EasyMotionTargetDefault

" By default ClapQuery will use the bold fg of Normal and the same bg of ClapInput

hi default link ClapPreview          ClapDefaultPreview
hi default link ClapSelected         ClapDefaultSelected
hi default link ClapCurrentSelection ClapDefaultCurrentSelection

" hi! ClapDefaultPreview          ctermbg=237 guibg=#3E4452
" hi! ClapDefaultSelected         cterm=bold,underline gui=bold,underline ctermfg=80 guifg=#5fd7d7
hi! link ClapDefaultSelected Visual
hi! link ClapDefaultCurrentSelection Visual



if (&bg == 'light')
    " hi! link MatchParen          bg_brightteal
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
