runtime! syntax/comment.vim
syntax cluster cCommentGroup add=@comments

setlocal fdm=syntax

nmap <buffer> =h   :call ToggleHeader()<CR>
nmap <buffer> <F4> :call ToggleHeader()<CR>
