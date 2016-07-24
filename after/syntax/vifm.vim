runtime! syntax/comment.vim
syn clear vifmComment
syn clear vifmInlineComment
" Whole line comment
syntax region vifmComment contained start='^\(\s\|:\)*"' end='$' contains=@Comment
" Comment at the end of a line
syntax match vifmInlineComment contained '\s"[^"]*$' contains=@Comment
