" !::exe [setf vim]
let b:comment_syntax = 1

" Syntax:
" Key: match commentTitle   contained /\v^\W+\zs\w.+:/
" @tag
" Note
" TODO
" DONE
" FIXME
" XXX
" watchme

syntax match commentTag     contained /\v\@\w+/
syntax match commentDoc     contained /\v\@\w+\ze\s*:/
syntax match commentDesc    contained /\v.+$/
syntax match commentSection contained /\v^\s*.?\zs\s+[A-Z][^:]+:\ze\W*\n/
syntax match commentLabel   contained /\v^\s*.?\s+\zs[A-Z][^:]+:\ze/ contains=commentDoc nextgroup=commentDesc

syntax keyword commentNote    contained NOTE Note
syntax keyword commentDone    contained DONE Done
syn case ignore
syntax keyword commentTodo    contained todo
syntax keyword commentWatch   contained watchme
syntax keyword commentFixme   contained fixme
syntax keyword commentXXX     contained xxx urgent
syn case match

syntax cluster Comment contains=
            \commentSection,commentLabel,commentTitle,commentTag,
            \commentTodo,commentDone,commentNote,
            \commentWatch,commentFixme,commentXXX
syntax cluster comments contains=
            \commentSection,commentLabel,commentTitle,commentTag,
            \commentTodo,commentDone,commentNote,
            \commentWatch,commentFixme,commentXXX

hi def link commentTag     Tag
hi def link commentSection CommentTitle
hi def link commentLabel   BoldComment
hi def link commentDoc     SpecialComment
hi def link commentDesc    Comment
hi def link commentTitle   Title
hi def link commentTodo    Todo
hi def link commentNote    Todo
hi def link commentDone    BoldSuccess
hi def link commentWatch   Debug
hi def link commentXXX     BoldError
hi def link commentFixme   BoldWarning

