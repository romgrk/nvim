" The default Vim syntax file has limited 'fold' definitions, so define more.
"
" Folding of functions and augroups is built-in since VIM 7.2 (it was introduced
" with vim.vim version 7.1-76) if g:vimsyn_folding contains 'a' and 'f', so set
" this variable if you want it. (Also in older VIM versions.)
let g:vimsyn_embed = 'P'
let g:vimsyn_folding = 'afP'
let g:vimsyn_noerror = 1

runtime! syntax/comment.vim
syn cluster vimCommentGroup contains=@comments

syn match vimOptionVar /&\h[a-zA-Z0-9#_]*\>/ contains=vimOnlyOption,vimTermOption,vimFTOption contained
syn keyword vimLet nextgroup=vimVar,vimFuncVar,vimOptionVar skipwhite let

hi! link vimFunc       Function
hi! link vimScriptVar  Identifier
hi! link vimCommand    Keyword
hi! link vimCmdSep     SpecialChar
hi! link vimOper       Operator
hi! link vimHiBang     Operator
hi! link vimUserFunc   Function
hi! link vimFunc       Function
hi! link vimOption     Control
hi! link vimOptionVar  vimOption
hi! link vimHiAttrib   Control
hi! link vimMapModKey  OldSpecial
hi! link vimNotation   OldSpecial
hi! link vimContinue   OldSpecial
hi! link vimSynRegOpt  OldSpecial
hi! link vimSynKeyOpt  OldSpecial
hi! link vimSynMtchOpt OldSpecial

" define groups that cannot contain the start of a fold
syn cluster vimNoFold contains=vimComment,vimLineCOmment,vimCommentString,vimString,vimSynKeyRegion,vimSynRegPat,vimPatRegion,vimMapLhs,vimOperParen,@EmbeddedScript
syn cluster vimEmbeddedScript contains=vimMzSchemeRegion,vimTclRegion,vimPythonRegion,vimRubyRegion,vimPerlRegion
" fold while loops
syn region vimFoldWhile
      \ start="\<wh\%[ile]\>"
      \ end="\<endw\%[hile]\>"
      \ transparent fold
      \ keepend extend
      \ containedin=ALLBUT,@vimNoFold
      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'
" fold for loops
syn region vimFoldFor
      \ start="\v<for>%(\s*\n\s*\\)?\s*.+%(\s*\n\s*\\\s*)?\s*<in>"
      \ end="\<endfo\%[r]\>"
      \ transparent fold
      \ keepend extend
      \ containedin=ALLBUT,@vimNoFold
      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'

" fold if...else...endif constructs
" note that 'endif' has a shorthand which can also match many other end patterns
" if we did not include the word boundary \> pattern, and also it may match
" syntax end=/pattern/ elements, so we must explicitly exclude these
syn region vimFoldIfContainer
      \ start="\<if\>"
      \ end="\<en\%[dif]\>=\@!"
      \ transparent
      \ keepend extend
      \ containedin=ALLBUT,@vimNoFold
      \ contains=NONE
      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'
syn region vimFoldIf
      \ start="\<if\>"
      \ end="^\s*\\\?\s*else\%[if]\>"ms=s-1,me=s-1
      \ fold transparent
      \ keepend
      \ contained containedin=vimFoldIfContainer
      \ nextgroup=vimFoldElseIf,vimFoldElse
      \ contains=TOP
      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'
syn region vimFoldElseIf
      \ start="\<else\%[if]\>"
      \ end="^\s*\\\?\s*else\%[if]\>"ms=s-1,me=s-1
      \ fold transparent
      \ keepend
      \ contained containedin=vimFoldIfContainer
      \ nextgroup=vimFoldElseIf,vimFoldElse
      \ contains=TOP
      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'
syn region vimFoldElse
      \ start="\<el\%[se]\>"
      \ end="\<en\%[dif]\>=\@!"
      \ fold transparent
      \ keepend
      \ contained containedin=vimFoldIfContainer
      \ contains=TOP
      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'

" fold try...catch...finally...endtry constructs
syn region vimFoldTryContainer
      \ start="\<try\>"
      \ end="\<endt\%[ry]\>"
      \ transparent
      \ keepend extend
      \ containedin=ALLBUT,@vimNoFold
      \ contains=NONE
      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'
syn region vimFoldTry
      \ start="\<try\>"
      \ end="^\s*\\\?\s*\(fina\%[lly]\|cat\%[ch]\)\>"ms=s-1,me=s-1
      \ fold transparent
      \ keepend
      \ contained containedin=vimFoldTryContainer
      \ nextgroup=vimFoldCatch,vimFoldFinally
      \ contains=TOP
      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'
syn region vimFoldCatch
      \ start="\<cat\%[ch]\>"
      \ end="^\s*\\\?\s*\(cat\%[ch]\|fina\%[lly]\)\>"ms=s-1,me=s-1
      \ fold transparent
      \ keepend
      \ contained containedin=vimFoldTryContainer
      \ nextgroup=vimFoldCatch,vimFoldFinally
      \ contains=TOP
      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'
syn region vimFoldFinally
      \ start="\<fina\%[lly]\>"
      \ end="\<endt\%[ry]\>"
      \ fold transparent
      \ keepend
      \ contained containedin=vimFoldTryContainer
      \ contains=TOP
      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'

let s:bg = hi#bg('Normal')
if (s:bg[0] != '#')
    let s:bg = '#353535' | end

let s:hl_bg = color#Lighten(s:bg, 35)
"if str2nr(s:bg[1:], 16) < 0x888888 | silent | else | let s:hl_bg = color#Darken(s:bg,  35) | end
call hi#('vimAutoGroupTag',      hi#fg('Type'),       s:hl_bg, 'none')
call hi#('vimCommandTag',        hi#fg('Statement'),  s:hl_bg, 'none')
call hi#('vimFuncNameTag',       hi#fg('Function'),   s:hl_bg, 'none')
call hi#('vimScriptFuncNameTag', hi#fg('StaticFunc'), s:hl_bg, 'none')

syn region	vimOperParen	matchgroup=vimSep	start="{" end="}" contains=@vimOperGroup nextgroup=vimVar,vimFuncVar fold

