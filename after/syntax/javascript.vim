" !::exe [so %]
" Language:	JavaScript

syn keyword jsNodeVars __dirname __filename containedin=ALL

hi! link jsNodeVars        Special

hi! link jsFuncBraces      Delimiter
hi! link jsBraces          Delimiter
hi! link jsBrackets        Delimiter2

hi! link jsExport          Special
hi! link jsImport          Special
hi! link jsModuleAs        Special
hi! link jsFrom            Special
hi! link jsThis            jsPrototype
if (&bg == 'light')
  hi! link jsPrototype       Keyword
  hi! link jsObjectKey       Property
else
  hi! link jsPrototype     Special
  hi! link jsObjectKey       Property
end
hi! link jsFunction        Keyword
hi! link jsFuncCall        Function
hi! link jsFuncAssignIdent Function
hi! link jsAssignExpIdent  Identifier
hi! link jsStorageClass    StorageClass
hi! link jsGlobalObjects   Global
hi! link jsFunctionKey     jsObjectKey
hi! link jsArrowFunction   Keyword
hi! link jsNull            Constant
hi! link jsUndefined       Constant
hi! link jsFuncArgs        Argument
hi! link jsBuiltins        Predefined
hi! link jsRegexpString    Regexp
hi! link jsRegexpBoundary  RegexpKey
hi! link jsRegexpCharClass RegexpDelimiter
hi! link jsTemplateVar     Normal
hi! link jsTernaryIfOperator jsOperator
hi! link jsTaggedTemplate Function

hi! link jsModuleOperators Special
hi! link jsModuleKeywords  Special

hi! link jsGlobalNodeObjects Special

"let g:javascript_conceal_function       = "ƒ"
"let g:javascript_conceal_arrow_function = "⇒"
unlet! g:javascript_conceal_function
unlet! g:javascript_conceal_arrow_function
unlet! g:javascript_ignore_javaScriptdoc
unlet! g:javascript_conceal_return
unlet! g:javascript_conceal_this
" let g:javascript_conceal_this = '@'
unlet! g:javascript_conceal_undefined
unlet! g:javascript_conceal_null
unlet! g:javascript_conceal_prototype
unlet! g:javascript_conceal_static
unlet! g:javascript_conceal_super

"syntax clear jsCommentTodo
"runtime! syntax/comment.vim
"syn region jsComment start=+\/\/+ end=/$/  keepend extend contains=jsCommentTodo,@Comments
"syn region jsComment matchgroup=jsComment start=+/\*\s*+ end=+\*/+  fold contains=jsDocTags,jsCommentTodo,jsCvsTag,@jsHtml,@Comments

