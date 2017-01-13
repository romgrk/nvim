
syntax match pugName /\v((block|include|extends|append|mixin) )@<=[^ ]+/

hi! link pugName       Argument
hi! link pugTag        htmlTagName
hi! link pugAttributes htmlArg
hi! link pugIdChar     Special
hi! link pugId         Special
