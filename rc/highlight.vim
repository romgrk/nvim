" vim: fdm=marker
" File: highlight.vim
" Author: romgrk
" Date: 16 Oct 2015
" !::exe [So]

augroup user_highlight
    au ColorScheme * :call <SID>setup()
    au VimEnter *    :call pp#prettyTheme()
augroup END

function! s:setup()
    " General                                                                    {{{

    hi! link QuickFixLine Highlight
    hi! link    Noise          Comment

    " }}}
    " Plugin specific                                                            {{{

    hi! link SearchReplaceLineNr     TextSpecial
    hi! link SearchReplaceMatch      TextError
    hi! link SneakLabel              EasyMotionTargetDefault
    hi! link SneakLabelMask          Noise

    hi! CocInfoSign                       guifg=#0E8FFF
    hi! CocInfoHighlight    gui=undercurl guisp=#0E8FFF
    hi! CocWarningSign                    guifg=#FF9F0E
    hi! CocWarningHighlight gui=undercurl guisp=#FF9F0E
    hi! CocErrorSign                      guifg=#ff1010
    hi! CocErrorHighlight   gui=undercurl guisp=#ff1010

    " hi! CocHintSign                       guifg=#085C69
    " hi! CocHintHighlight    gui=undercurl guisp=#085C69
    " hi! CocUnusedHighlight  gui=undercurl guisp=#085C69

    " let bg = hi#bg('Normal')
    " let bg = empty(bg) ? '#000000' : bg
    " call hi#('CocRustChainingHint', color#Mix('#085C69', bg))

    " hi! link CocFloating NormalFloat
    " hi! CocInfoFloat                      guifg=white
    " hi! CocWarningFloat                   guifg=#FFDD86
    " hi! CocErrorFloat                     guifg=#FDC1C1
    hi! link CocFloating NormalPopover
    hi! link CocInfoFloat                   TextNormal
    hi! link CocWarningFloat                TextWarning
    hi! link CocErrorFloat                  TextError

    hi link gitmessengerHeader NormalFloat


    hi! link HighlightedyankRegion Highlight

    call hi#('multiple_cursors_cursor', g:colors.darkred, g:colors.pink, 'bold')
    hi! link multiple_cursors_visual visual


    " }}}
    " Notes, notation, etc.                                                      {{{
    hi! link vifmNotation        OldSpecial
    hi! link notesXXX            TextError
    hi! link notesDoneMarker     TextSuccess
    hi! link notesTODO           TextWarning
    " }}}
endfunc

call s:setup()
