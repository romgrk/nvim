syn keyword tsPreProc require
syn keyword tsPreProc module

syn keyword tsDelimiter console
syn keyword tsDelimiter window

hi! link tsPreProc              PreProc
hi! link typescriptEndColons    Comment
hi! link typescriptFuncKeyword  Keyword
hi! link typescriptIdentifier   Keyword
hi! link typescriptLogicSymbols Operator
hi! link typescriptParens       Delimiter

hi! link typescriptRegexpString Regexp

runtime! syntax/comment.vim
syn match typescriptLineComment "\/\/.*" contains=@Spell,@comments,typescriptRef
