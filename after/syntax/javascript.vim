" !::exe [so %]
" Language:	JavaScript

hi! link jsFuncBraces      Delimiter
hi! link jsBraces          Delimiter
hi! link jsBrackets        Delimiter2

"hi! link jsThis            Var3
hi! link jsThis            jsPrototype
hi! link jsFunction        Keyword
hi! link jsFuncCall        Function
hi! link jsFuncAssignIdent Function
hi! link jsAssignExpIdent  Identifier
hi! link jsStorageClass    StorageClass
hi! link jsGlobalObjects   Global
hi! link jsObjectKey       Property
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

hi! link jsModuleOperators Special
hi! link jsModuleKeywords  Special

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

