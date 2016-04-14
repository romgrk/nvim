" File: match.vim
" Author: romgrk
" Date: 02 Apr 2016
" !::exe [so %]

let s:hl = "EasyMotionTargetDefault"
let s:matchmap = {}

func! match#place(c, pos, ...)
  let s:matchmap[a:c] = a:pos
  exec "syntax match " . (a:0 ? a:1 : s:hl) . " '\\%".a:pos[0]."l\\%".a:pos[1]."c.' conceal cchar=".a:c
endf

func! match#clear()
    for k in keys(s:matchmap)
        unlet! s:matchmap[k]
    endfor
    call clearmatches()
endf
