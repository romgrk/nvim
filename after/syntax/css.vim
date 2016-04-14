
syn match cssComma /[:;]/
syn match cssComma /[:;]/

syn match cssIncludeKeyword /@\(-[a-z]\+-\)\=\(media\|keyframes\|import\|charset\|namespace\|page\|binding-set\)/ contained

hi link cssComma Comment

