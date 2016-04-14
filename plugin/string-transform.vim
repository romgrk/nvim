" File: string-transform.vim
" Author: romgrk
" Date: 26 Mar 2016
" Description:
" !::exe [so %]

function! s:mapfunc (method)
    exec 'nmap <Plug>(' . a:method . 'Operator)  :set opfunc=<SID>opfunc<CR>"="' . a:method . '"<CR>g@'
    exec 'vmap <Plug>(' . a:method . 'Operator)  :<C-U>call <SID>opfunc(visualmode(), "' . a:method . '")<CR>'
endfunc

call <SID>mapfunc('camelCase')
call <SID>mapfunc('snakeCase')
call <SID>mapfunc('startCase')
call <SID>mapfunc('kebabCase')
call <SID>mapfunc('lowerCase')
call <SID>mapfunc('upperCase')

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

    let @@ = <SID>transform(get(a:, 1, getreg('=')), @@)

    normal! gv""p

    let &selection = sel_save
    let @@         = reg_save
endfunc

function! s:transform (method, string)
    let code =
    \ 'require("lodash").' . a:method . '(process.argv[1])'
    let out =  system(
                \ 'node -p '
                \ . shellescape(code) . ' '
                \ . shellescape(a:string))
    if (char2nr(out[-1:]) == 10)
        let out = out[:-2] | end
    return substitute(out, '\v^\s+|\s+$', '', 'g')
endfunc

function! s:SID()
    return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfun


