" File: definition.vim
" Author: romgrk
" Date: 13 May 2016
" Description: Jump where the given expression was last set.
" !::exe [So]

command! -nargs=* -complete=expression Goto    call <SID>goto(<q-args>)
command! -nargs=1 -complete=command    GotoCom call <SID>goto('com '.<q-args>)
command! -nargs=1 -complete=function   GotoFu  call <SID>goto('fu '.<q-args>)
command! -nargs=1 -complete=option     GotoSet call <SID>goto('set '.<q-args>.'?')
command! -nargs=1 -complete=mapping    GotoNm  call <SID>goto('nmap '.<q-args>)
command! -nargs=1 -complete=mapping    GotoMap call <SID>goto('map '.<q-args>)
command! -nargs=1 -complete=highlight  GotoHi  call <SID>goto('hi '.<q-args>)

" Example mappings:
" nmap <leader>gc     :Goto command<space>
" nmap <leader>gf     :Goto function<space>
" nmap <leader>gs     :Goto set<space>?<Left>
" nmap <leader>gm     :Goto nmap<space>
" nmap <leader>ga     :Goto abbrev<space>

function! s:goto (str)
    let str = substitute(a:str, '\v[()]', '', 'g')

    silent! let out = execute('verbose ' . str)

    let lastset = matchstr(out, 'Last set from \zs\f\+')

    if empty(lastset)
        call pp#echo( ['WarningMsg', 'Couldn’t find definition for '],
                    \ ['String', printf('“%s”', str)])
        return
    end

    execute 'edit ' . lastset

    let what = matchstr(a:str, '\w\+')
    let name = matchstr(a:str, '\v\s*[^ ]\s+\zs\w+')

    "   /     [com|fu|se|nm|…]   [mand|nction|t|ap]?  [!]? <space>      TAG
    let pattern = '\s*' . what[0:1] . '(' . what[2:] . ')?\w*!?\s+.*' . name
    silent! call search('\v' . pattern)
    "echom pattern
endfunc
