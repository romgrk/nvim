

syntax sync fromstart

syn match vimfilerStatus '^\%1l\[in\]: \%(\[unsafe\]\)\?'
      \ nextgroup=vimfilerCurrentDirectory conceal

syn match vimfilerDirectory /\v^.*\f+\// display contains=NONE

"syn match fileIcon /\v^\s*\zs[^ ]\ze\s*\f+\// display
"syn match dotVimIcon /\v\s*\zs\W\ze\s*\f+\.vim/ display nextgroup=dotVim

syn match dotVim /^.\+\.vim/                display
syn match dotLua /^.\+\.lua/                 display
syn match dotMoon /^.\+\.moon/               display
syn match dotCoffee /^.\+\.\(coffee\|cson\)/ display

syn match dotRead /^.\+\.\(txt\|md\|log\)/ display

hi! link dotVim     Magenta
hi! link dotCoffee  Yellow
hi! link dotMoon    Blue
hi! link dotLua     Red
hi! link dotRead    Comment


hi! link vimfilerLeaf Comment
hi! link vimfilerNonMark Special

hi! link vimfilerCurrentDirectory ColorColumn
hi! link vimfilerDirectory        Directory
hi! link vimfilerOpenedFile       Question
hi! link vimfilerClosedFile       Preproc
hi! link vimfilerNormalFile       Normal
hi! link vimfilerMarkedFile       Type
hi! link vimfilerROFile           Comment
hi! link vimfilerScript           Identifier

let b:current_syntax = 'vimfiler'
