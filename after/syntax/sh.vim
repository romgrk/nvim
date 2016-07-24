
runtime! syntax/comment.vim

syn cluster	shCommentGroup	remove=shTodo
syn cluster	shCommentGroup	add=@comments

" Shell                                                                      {{{
hi! link zshHereDoc Comment
hi! link zshKSHFunction Function
hi! link zshVariableDef Var1
hi! link zshDeref Var1
hi! link zshTypes StorageClass
" }}}
