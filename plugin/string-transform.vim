" File: string-transform.vim
" Author: romgrk
" Date: 26 Mar 2016
" Description:
" !::exe [So]

function! s:mapfunc (method)
    exec 'nmap <silent><Plug>(' . a:method . '_operator)  :set opfunc=<SID>opfunc<CR>"="' . a:method . '"<CR>g@'
    exec 'vmap <silent><Plug>(' . a:method . '_operator)  :<C-U>call <SID>opfunc(visualmode(), "' . a:method . '")<CR>'
endfunc

call <SID>mapfunc('snake_case')
call <SID>mapfunc('kebab_case')
call <SID>mapfunc('start_case')
call <SID>mapfunc('camel_case')
call <SID>mapfunc('upper_camel_case')

function! s:opfunc (type, ...)
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@

    echom string(a:000)

    " If invoked from Visual mode, use '< and '> marks.

        if (!empty(a:000))     | silent exe "normal! `<" . a:type . "`>y"
    elseif (a:type == 'line')  | silent exe "normal! '[V']y"
    elseif (a:type == 'block') | silent exe "normal! `[\<C-V>`]y"
    else                       | silent exe "normal! `[v`]y"
    end

    let @@ = g:transform[getreg('=')](@@)

    normal! gv""p

    let &selection = sel_save
    let @@         = reg_save
endfunc


let transform = {}
function! transform.snake_case(string)
    return join(s:split_words(a:string), '_')
endfu
function! transform.camel_case(string)
    let words = s:split_words(a:string)
    let string = words[0]
    for word in words[1:]
        let string .= substitute(word, '\v^.', '\u\0', '')
    endfor
    return string
endfu
function! transform.upper_camel_case(string)
    return join(map(s:split_words(a:string), {key, word -> substitute(word, '\v^.', '\u\0', '')}), '')
endfu
function! transform.kebab_case(string)
    return join(s:split_words(a:string), '-')
endfu
function! transform.start_case(string)
    return join(map(s:split_words(a:string), {key, word -> substitute(word, '\v^\l', '\u\0', '')}), ' ')
endfu


function! s:split_words(string)
    let words = split(a:string, '\v_|-|(\u+\zs\ze\u\U)|(\U\zs\ze\u)')
    let i = 0
    for word in words
        if word =~ '\v\u\U+'
            let words[i] = substitute(word, '\v\u\U+', '\l\0', '')
        end
        let i += 1
    endfor
    return words
endfu

" let g:words = <SID>split_words('snake_case')
" let g:words = <SID>split_words('camelCase')
" let g:words = <SID>split_words('camelURLCase')
" let g:words = <SID>split_words('kebab-case')
