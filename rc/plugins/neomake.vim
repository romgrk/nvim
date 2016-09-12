"============================================================================
" File: neomake.vim
" Author: romgrk
" Date: 06 Aug 2016
" Description: Neomake config
"============================================================================
" !::exe [So]
let neomake_open_list = 2
let neomake_warning_sign = {
  \ 'text': '',
  \ 'texthl': 'WarningMsg',
  \ }
let neomake_error_sign = {
  \ 'text': '',
  \ 'texthl': 'ErrorMsg',
  \ }


let neomake_javascript_enabled_makers = ['npm', 'eslint']
let neomake_javascript_npm_maker = {
  \ 'exe': 'npm',
  \ 'args': ['run', 'build'],
  \ 'errorformat': '%f: line %l\, col %c\, %m',
  \ }


let neomake_make_maker = {
  \ 'exe': 'make',
  \ 'args': [],
  \ 'errorformat': '%f:%l:%c: %m',
  \ }

