"syn region Paren matchgroup=delimiter start=/(/ end=/)/ transparent
"syn region Curly matchgroup=delimiter start=/{/ end=/}/ transparent
"syn region Bracket matchgroup=delimiter start=/\[/ end=/]/ transparent
setlocal textwidth=100
setlocal foldmethod=marker
setlocal foldmarker={,}

syn match cSemicolon /;\s*$/
syn match cAssign /=/

hi! link cParen   Delimiter
hi! link cBracket Delimiter
hi! link cCurly   Delimiter

hi! link cSemicolon Comment
hi! link cAssign    Comment

hi! link cCustomClass               Variable
hi! link cCustomTemplateClass       StorageClass
hi! link cCustomAngleBracketContent Var1
"hi! link cCustomAngleBracketContent Class

let cpp_class_scope_highlight = 1
"let cpp_experimental_template_highlight = 1
