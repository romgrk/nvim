
let pretty_indent_namespace = nvim_create_namespace('pretty_indent')

function! PrettyIndent()
    let l:view=winsaveview()
    call cursor(1, 1)
    call nvim_buf_clear_namespace(0, g:pretty_indent_namespace, 1, -1)
    while 1
        let l:match = search('^$', 'W')
        if l:match ==# 0
            break
        endif

        let l:indent = cindent(l:match)
        if l:indent > 0
            call nvim_buf_set_virtual_text(
            \   0,
            \   g:pretty_indent_namespace,
            \   l:match - 1,
            \   [[repeat(repeat(' ', &shiftwidth - 1) . '│', l:indent / &shiftwidth), 'IndentGuide']],
            \   {}
            \)
        endif
    endwhile
    call winrestview(l:view)
endfunction

augroup PrettyIndent
    autocmd!
    autocmd TextChanged * call PrettyIndent()
    autocmd BufEnter    * call PrettyIndent()
    autocmd InsertLeave * call PrettyIndent()
augroup END
