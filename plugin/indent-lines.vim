
let pretty_indent_namespace = nvim_create_namespace('pretty_indent')

function! PrettyIndent()
    let view = winsaveview()

    let topline = line('w0')
    let botline = line('w$')

    " Set cursor position to beginning of file.
    call cursor(topline, 0)

    call nvim_buf_clear_namespace(
        \ 0, g:pretty_indent_namespace, 1, -1)

    let last_topline = topline
    let position = s:search('^$', botline)
    while !empty(position)
        let lnum = position[0]
        let topline = position[0] + 1
        call cursor(topline, 0)

        let l:indent = cindent(lnum)
        if l:indent > 0
            call nvim_buf_set_virtual_text(
            \   0,
            \   g:pretty_indent_namespace,
            \   lnum - 1,
            \   [[repeat(repeat(' ', &shiftwidth - 1) . '│', l:indent / &shiftwidth), 'IndentGuide']],
            \   {}
            \)
        endif

        let position = s:search('^$', botline)
        if topline == last_topline
            break
        end
        let last_topline = topline
    endwhile

    call winrestview(view)
endfunction

function! s:search(pattern, end_line)
    let search_result = searchpos(a:pattern, "c", a:end_line)
    return search_result[0] == 0 ? v:null : search_result
endfunction

augroup PrettyIndent
    autocmd!
    autocmd TextChanged * call PrettyIndent()
    autocmd BufEnter    * call PrettyIndent()
    autocmd InsertLeave * call PrettyIndent()
    autocmd WinScrolled * call PrettyIndent()
augroup END
