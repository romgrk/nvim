" File: definition.vim
" Author: romgrk
" Date: 13 May 2016
" Description: Jump where the given expression was last set.
" !::exe [so %]

command! -nargs=* -complete=expression Goto call <SID>goto(<q-args>)

" Example mappings:
" nmap <leader>gc     :Goto command<space>
" nmap <leader>gf     :Goto function<space>
" nmap <leader>gm     :Goto nmap<space>
" nmap <leader>ga     :Goto abbrev<space>

function! s:goto (str)
    let out = ''

    try
        redir => out
        silent! execute 'verbose' a:str
        redir END

    catch /.*/
        echom v:exception
        " g_free(out);
        return
    endtry

    let lastset = matchstr(out, 'Last set from \zs\f\+')
    "echom lastset

    execute 'edit ' . lastset

    let what = matchstr(a:str, '\w\+')
    let name = matchstr(a:str, '\v\s*[^ ]\s+\zs\w+')

    "   /     [com|fu|se|nm|…]   [mand|nction|t|ap]?  [!]? <space>      TAG
    let pattern = '\s*' . what[0:1] . '(' . what[2:] . ')?\w*!?\s+.*' . name
    silent! call search('\v' . pattern)
    "echom pattern
endfunc
