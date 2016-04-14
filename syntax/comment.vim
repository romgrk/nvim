
let b:comment_syntax = 1

" Syntax: match commentTitle   contained /\v^\W+\zs\w.+:/
" @tag
" Note
" TODO
" DONE
" FIXME
" XXX
" watchme

syntax match commentTag     contained /\v\@\w+/
syntax match commentDoc     contained /\v\@\w+\ze\s*:/
syntax match commentDesc    contained /\v:\s*\zs.+$/
syntax match commentSection contained /\v^\s*.?\zs\s+[A-Z]\w+:.*/ contains=commentDoc,commentDesc

syn case ignore
syntax keyword commentTodo    contained note todo
syntax keyword commentDone    contained done
syntax keyword commentWatch   contained watchme
syntax keyword commentFixme   contained fixme
syntax keyword commentXXX     contained xxx urgent
syn case match

syntax cluster comments contains=
            \commentSection,commentTitle,commentTag,
            \commentTodo,commentDone,
            \commentWatch,commentFixme,commentXXX

hi! link commentTag     Tag
hi! link commentSection CommentTitle
hi! link commentDoc     SpecialComment
hi! link commentDesc    fg_base3
hi! link commentTitle   Title
hi! link commentTodo    BoldInfo
hi! link commentDone    BoldSuccess
hi! link commentWatch   BoldDebug
hi! link commentXXX     BoldError
hi! link commentFixme   BoldWarning

