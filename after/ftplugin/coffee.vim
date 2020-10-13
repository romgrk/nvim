" File: coffee.vim
" Author: romgrk
" Description: coffee settings
" Last Modified: November 05, 2014


exe 'source ' . expand('<sfile>:p:h') . '/node.vim'

com! -nargs=1 CV CoffeeCompile | :<args>

" Options
setlocal foldmethod=expr
setlocal foldexpr=GetIndentFold(v:lnum)

" Run shortcut
nmap <buffer> <F3> :!coffee <C-R>=expand("%:r")<CR><CR>

" vmap <buffer> <leader>c <esc>:'<,'>:CoffeeCompile<CR>
" map  <buffer> <leader>c :CoffeeCompile<CR>

