" !::exe [so %]
" Language:	JavaScript
"let s:cpo_save = &cpo
"set cpo&vim
"let &cpo = s:cpo_save
"unlet s:cpo_save
runtime syntax/yajs/web-console.vim

if exists('*LavaLampColors') && get(g:, 'colors_name', '')=~'lava'
    call LavaLampColors()
    finish
end


hi! link javascriptExport         PreProc

"hi! link javascriptIdentifierName Identifier
hi! link javascriptFuncDef        Identifier
hi! link javascriptFuncArg        Argument

"hi! link javascriptIdentifier    Keyword
hi! link javascriptFuncKeyword   Keyword
"hi! link javascriptVariable      Control
hi! link javascriptVariable      Comment
hi! link javascriptOpSymbol      Operator
hi! link javascriptExceptions    Exception

hi! link javascriptNull          Constant
hi! link javascriptGlobal        Global
hi! link javascriptParens        Delimiter
hi! link javascriptBraces        Delimiter
hi! link javascriptBrackets      Delimiter
"hi javascriptBrackets guifg=#505050

hi! link javascriptDotNotation   Delimiter
hi! link javascriptGlobalMathDot Delimiter

hi! link javascriptObjectLabel   StorageClass
hi! link javascriptProp          StorageClass
"hi! link javascriptMethod        StorageClass
hi! link javascriptMethod        Method

hi! link javascriptValue Constant
hi! link javascriptRegexpString Regexp

hi! link javascriptQDimensions   StorageClass
hi! link javascriptBEvents       StorageClass

hi! link javascriptConsoleMethod StorageClass
hi! link javascriptArrayMethod Type
hi! link javascriptBOMWindowMethod Type
hi! link javascriptBOMLocationMethod Type

hi! link javascriptMathStaticMethod StaticFunc
hi! link javascriptStringMethod StaticFunc
hi! link javascriptRegexpMethod StaticFunc

hi! link javascriptTemplateSB Delimiter

hi! link javascriptEndColons Comment
hi! link javascriptComma Comment
hi! link javascriptOperator Operator
hi! link javascriptRepeat Repeat

"syntax match commentTitle /\v.? \zs\w+:/
"syntax keyword  commentTODO  TODO
"syntax keyword  commentXXX   XXX
"syntax keyword  commentFIXME FIXME
"syntax cluster Comments contains=commentTitle,commentTODO,commentXXX,commentFIXME

"hi default link commentTitle  Title
"hi default link commentTODO   Todo
"hi default link commentXXX    Error
"hi default link commentFIXME  Error

" runtime syntax/yajs/dom-node.vim
" runtime syntax/yajs/dom-elem.vim
" runtime syntax/yajs/dom-document.vim
" runtime syntax/yajs/dom-event.vim
" runtime syntax/yajs/dom-storage.vim

