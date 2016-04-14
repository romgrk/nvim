" File: highlight.vim
" Author: romgrk
" Date: 16 Oct 2015
" !::exe [so %]

exe 'augroup ' . expand('<sfile>:t') | au!
autocmd ColorScheme * exe 'source ' . expand('<sfile>')
exe 'augroup END'

if exists('g:pp') | call pp#prettyTheme() | end

" General & Plugins                                                          {{{

call hi#("AutoHL",   "none", "#404040", "none")
"call hi#("SearchHL", "none", "#404040", "none")

hi! link Noise                   Comment

call hi#('EasyMotionTargetDefault', '#ff0000', '', 'bold')
hi!  link SneakPluginTarget      EasyMotionTargetDefault
hi!  link SneakStreakTarget      EasyMotionTargetDefault
hi!  link SneakStreakMask        EasyMotionShadeDefault
call hi#('SneakStreakMask', hi#('EasyMotionShadeDefault'))

hi! link TagbarScope             Class
hi! link TagbarFoldIcon          Comment

hi! link hiPairs_matchPair   MatchParen
hi! link hiPairs_unmatchPair MatchParen

call hi#('multiple_cursors_cursor', colors.darkred, colors.pink,     'bold')
"hi! link multiple_cursors_visual Visual
"hi! link multiple_cursors_visual AutoHL
hi! link multiple_cursors_visual Visual

" }}}
" Tabline & Statusline                                                       {{{

let tabsel = hi#('TabLineSel')
hi link BufferIcon         TabLine
hi link Buffer             TabLine
hi link BufferActive       TabLine
hi link BufferActiveIcon   TabLine
"let bufsel = hi#('BufferCurrent', tabsel[0], tabsel[1])
"hi! link BufferCurrent      TabLineSel
"hi! link BufferCurrentIcon  TabLineSel
hi link TabGutter          CursorLineNr
hi link TabGutterSplit     CursorLineNr
hi link Separator          VertSplit

let s:groups = {}
let s:groups['MediumGreen']  = ['#005f00',      '#afdf00']
let s:groups['MediumOrange'] = ['#870000',      '#ffb700']
let s:groups['SessionTab']   = ['#ffb700',      colors.base0, 'bold' ]
let s:groups['FilerTab']     = [ colors.base03, colors.base2, 'none' ]
let s:groups['FilerIcon']    = [ colors.base02, colors.base2, 'bold' ]
let s:groups['FilerAccent']  = [ colors.red,    colors.base2, 'bold' ]
let s:groups['TabGutter']      = [colors.base0,    '#171717' ]
let s:groups['TabGutterSplit'] = ['#666660',    '#171717' ]
for k in keys(s:groups)
    call hi#(k, s:groups[k])
endfor     "                                                                 }}}

" Tags                                                                       {{{

fu! s:highlightTags ()
    let bg = hi#bg('Normal')
    if (bg[0] != '#') | return | end
    let hl_bg = color#Lighten(bg, 35)

    "if str2nr(bg[1:], 16) < 0x888888 | silent | else | let hl_bg = color#Darken(bg,  35) | end

    call hi#('vimAutoGroupTag',      hi#fg('Type'),       hl_bg, 'none')
    call hi#('vimCommandTag',        hi#fg('Statement'),  hl_bg, 'none')
    call hi#('vimFuncNameTag',       hi#fg('Function'),   hl_bg, 'none')
    call hi#('vimScriptFuncNameTag', hi#fg('StaticFunc'), hl_bg, 'none')
    call hi#('cFunctionTag',         hi#fg('Function'),   hl_bg, 'none')
endfunc
call s:highlightTags()

"                                                                            }}}
" GitGutter                                                                  {{{

let s:bg = hi#bg('LineNr')
if(s:bg[0] == '#')
    call hi#('GitGutterAdd',          hi#fg('DiffAdd'),      s:bg, '')
    call hi#('GitGutterDelete',       hi#fg('DiffDelete'),   s:bg, '')
    call hi#('GitGutterChange',       hi#fg('DiffChange'),   s:bg, '')
    call hi#('GitGutterChangeDelete', hi#fg('DiffModified'), s:bg, '')
end

"                                                                            }}}
" Notes, notation, etc. {{{

hi! link vifmNotation  OldSpecial

hi! link notesXXX            ErrorMsg
hi! link notesDoneMarker     TextSuccess
hi! link notesTODO           TextWarning

" }}}
" JS & JSON                                                                   {{{

hi! link javascriptIdentifierName   Identifier

hi! link jsonQuote               Delimiter
hi! link jsonKeyword             Keyword
hi! link jsonKeywordMatch        Comment
" }}}
" Coffee                                                                     {{{
hi! link coffeeObject       Type
hi! link coffeeObjAssign    StorageClass
hi! link coffeeDotAccess    Function
hi! link coffeeGlobal       Constant
hi! link coffeeBracket      Delimiter
hi! link coffeeParen        Delimiter
hi! link coffeeSpecialOp    StringDelimiter
hi! link coffeeSpecialVar   Identifier
hi! link coffeeSpecialIdent Variable
"                                                                            }}}
" TypeScript                                                                 {{{
hi! link tsPreProc              PreProc
hi! link typescriptEndColons    Comment
hi! link typescriptFuncKeyword  Keyword
hi! link typescriptIdentifier   Keyword
hi! link typescriptLogicSymbols Operator
hi! link typescriptParens       Delimiter
"                                                                            }}}
" Shell                                                                      {{{
hi! link zshKSHFunction Function
hi! link zshVariableDef Var1
hi! link zshDeref Var1
hi! link zshTypes StorageClass
"                                                                            }}}
" }}}
