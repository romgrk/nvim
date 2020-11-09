runtime! syntax/comment.vim
syntax cluster cCommentGroup add=@comments

" setlocal foldmethod=syntax

nnoremap <buffer> gh   :call ToggleHeader()<CR>
nnoremap <buffer> <F4> :call ToggleHeader()<CR>

" nnoremap <buffer> <leader>yc :YcmCompleter<space>

" nnoremap <buffer><silent> gd   :YcmCompleter GoTo<CR>
" nnoremap <buffer><silent> gD   :YcmCompleter GoToDefinition<CR>
" nnoremap <buffer><silent> K    :YcmCompleter GetDoc<CR>



if !exists('*ToggleHeader')
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
end
