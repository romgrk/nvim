" !::exe [setf vim]
if (0 == 1)
    " Comment syntax
    " Highlight tests:
    " Key: label
    " Todo

    let val = v:false
    let val = v:null

    let &l:sw = 4
    let b:saved_sw = &l:sw
end


" Comments
syn clear vimCommentTitle
runtime! syntax/comment.vim
syn cluster vimCommentGroup contains=@Comment


" Additionnal types
syn match vimBoolean  /\vv:(true|false)/ containedin=ALL contained
syn match vimNull     /v:null/           containedin=ALL contained


" &option vars
syn match vimOptionVar /\v\&([gwl]:)?\h[a-zA-Z0-9#_]*>/ contains=vimOption,vimOnlyOption,vimTermOption,vimFTOption contained
syn keyword vimLet nextgroup=vimVar,vimFuncVar,vimOptionVar,vimFBVar skipwhite let le

syn clear vimMapRhs
syn match vimMapRhs	contained ".*" contains=vimNotation,vimCtrlChar,vimFunc	skipnl nextgroup=vimMapRhsExtend

" nofold cluster groups {{{
" define groups that cannot contain the start of a fold

syn cluster vimNoFold contains=vimComment,vimLineComment,vimString,
            \vimSynKeyRegion,vimSynRegPat,vimPatRegion,vimMapLhs,
            \@EmbeddedScript
syn cluster vimEmbeddedScript contains=vimMzSchemeRegion,vimTclRegion,vimPythonRegion,
            \vimRubyRegion,vimPerlRegion
"}}}
" fold markers {{{
" syn region vimFoldMarker
      " \ start="\v\{{3}"
      " \ end="\v}{3}"
      " \ transparent fold
      " \ containedin=ALL
      " \ contains=ALL
      " \ keepend
"}}}

" fold while loops"{{{
syn region vimFoldWhile
      \ start="\<wh\%[ile]\>"
      \ end="\<endw\%[hile]\>"
      \ transparent fold
      \ keepend extend
      \ containedin=ALLBUT,@vimNoFold
      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'
"}}}
" fold for loops"{{{
syn region vimFoldFor
      \ matchgroup=Repeat
      \ start="\v<for>\ze%(\s*\n\s*\\)?\s*.+%(\s*\n\s*\\\s*)?\s*<in>"
      \ end="\<endfo\%[r]\>"
      \ transparent fold
      \ keepend extend
      \ containedin=ALLBUT,@vimNoFold
      \ nextgroup=vimVar,vimFuncVar,vimOptionVar,vimFBVar
      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'
"}}}
" fold if...else...endif constructs"{{{
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
"}}}
" fold try...catch...finally...endtry constructs"{{{
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
"}}}

" syn region vimOperParen
            " \ matchgroup=vimSep
            " \ start="{" end="}"
            " \ contains=@vimOperGroup
            " \ nextgroup=vimVar,vimFuncVar,vimOptionVar,vimFBVar
            " \ fold

" Highlight links {{{

hi! link vimFunction   Function
hi! link vimUserFunc   Function
hi! link vimOption     Control

hi! link vimScriptVar  Identifier
hi! link vimEnvvar     Special
hi! link vimOptionVar  PredefinedIdentifier

hi! link vimLet        StorageClass
hi! link vimCommand    Statement
hi! link vimCmdSep     SpecialChar

hi! link vimOper       Operator
" hi! link vimOperParen  Operator

hi! link vimHiBang     vimOper
hi! link vimHiAttrib   Control

hi! link vimMapModKey  Special
hi! link vimMapMod     SpecialDelimiter

hi! link vimBracket    SpecialDelimiter
hi! link vimNotation   SpecialKey
hi! link vimContinue   Conceal
hi! link vimSynRegPat  Regexp
hi! link vimSynRegOpt  vimSpecial
hi! link vimSynKeyOpt  vimSpecial

hi! link vimAutoCmdSfxList String

hi! link vimAutoEventList Type
hi! link vimAutoEvent Type
hi! link nvimAutoEvent Type

hi! link nvimMap vimMap

" hi! link vimSynMtchOpt vimSpecial
hi! link vimBoolean    Boolean
hi! link vimNull       Constant

hi! link CommentEmail URL
"}}}

let s:bg = hi#bg('Normal')
let s:bg = (s:bg[0] != '#') ? '#353535' : s:bg

if str2nr(s:bg[1:], 16) < 0x888888
    let s:hl_bg = color#Lighten(s:bg, 35)
else
    let s:hl_bg = color#Darken(s:bg,  35) | end

call hi#('vimAutoGroupTag',       hi#fg('Type'),       s:hl_bg, 'none')
call hi#('vimCommandTag',         hi#fg('Statement'),  s:hl_bg, 'none')
call hi#('vimFuncNameTag',        hi#fg('Function'),   s:hl_bg, 'none')
call hi#('vimScriptFuncNameTag',  hi#fg('StaticFunc'), s:hl_bg, 'none')

"call hi#('vimUserFunc',           hi#fg('Type'),       '',      'bold')

" syn sync linecont	"^\s\+\\"
