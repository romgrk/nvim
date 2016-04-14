" File: github.vim
" Author: romgrk
" Date: 12 Mar 2016
" Description: github helper
" !::exe [so %]

command! OpenProjectInGithub silent !cd %:h && hub browse

let s:cache  = {}
let s:remote = {}

function! IsGithub (...)
    let dir = fnamemodify((a:0 ? a:1 : @%), ':p:h')
    if exists('s:cache[dir]')
        return s:cache[dir]
    end

    let out = system('cd ' . dir . ' && git remote show origin')
    if out[0:4] ==# '^fatal'
        let s:cache[dir] = 0
    else
        let s:remote[dir] = matchstr(out, 'Fetch.\+$')
        if out =~# 'github.com'
            let s:cache[dir] = 1
        else
            let s:cache[dir] = 0
        end
    end
    return s:cache[dir]
endfunc

