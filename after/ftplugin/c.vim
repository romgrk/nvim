runtime! syntax/comment.vim
syntax cluster cCommentGroup add=@comments
syntax match   cBang /!=\@!/
hi! link cBang b_pink

setlocal foldmethod=syntax

nnoremap <silent><buffer> gh  :call ToggleHeader()<CR>
function! ToggleHeader ()
    if expand('%:e') == 'h'
        let fname = expand('%<') . '.cc'
        if filereadable(fname)
            call Edit(fname)
            return | end
        let fname = expand('%<') . '.cpp'
        if filereadable(fname)
            call Edit(fname)
            return | end
        call Warn('Couldnt find source.')
    else
        let hname = expand('%<') . '.h'
        if filereadable(hname)
            exe 'Edit ' . hname
        else
            call Warn(hname . ' doesnt exist.')
        end
    end
endfu
