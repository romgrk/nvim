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

syntax keyword commentTodo    contained TODO NOTE Todo Note
syntax keyword commentDone    contained DONE Done
syn case ignore
syntax keyword commentWatch   contained watchme
syntax keyword commentFixme   contained fixme
syntax keyword commentXXX     contained xxx urgent
syn case match

syntax cluster comments contains=
            \commentSection,commentTitle,commentTag,
            \commentTodo,commentDone,
            \commentWatch,commentFixme,commentXXX

hi def link commentTag     Tag
hi def link commentSection CommentTitle
hi def link commentDoc     SpecialComment
hi def link commentDesc    Comment
hi def link commentTitle   Title
hi def link commentTodo    Todo
hi def link commentDone    BoldSuccess
hi def link commentWatch   BoldDebug
hi def link commentXXX     BoldError
hi def link commentFixme   BoldWarning

