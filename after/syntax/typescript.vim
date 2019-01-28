" syn keyword tsPreProc module
" syn keyword tsDelimiter console
" syn keyword tsDelimiter window
" hi! link tsPreProc              PreProc
syn keyword typescriptSource require
            \ containedin=ALLBUT,typescriptDotNotation

hi! link typescriptSource Special
hi! link typescriptHtmlElemProperties Normal

hi! link typescriptGlobal       Global
hi! link typescriptEndColons    Comment
hi! link typescriptFuncKeyword  Keyword
hi! link typescriptIdentifier   Keyword
hi! link typescriptLogicSymbols Operator
hi! link typescriptParens       Delimiter
hi! link typescriptDotNotation  Delimiter

hi! link typescriptRegexpString Regexp

hi! link typescriptNull         Constant

runtime! syntax/comment.vim
syn match typescriptLineComment "\/\/.*" contains=@Spell,@comments,typescriptRef
