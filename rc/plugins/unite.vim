" File: unite.vim
" Author: romgrk
" Description: Unite settings
" Date: 27 Oct 2015
" !::exe [so %]

" Start insert.
"call unite#custom#profile('default', 'context', {
"\   'start_insert': 1
"\ })

let unite_force_overwrite_statusline = 0

" Default settings.
call unite#custom#profile('default', 'context', {
\   'start_insert': 0,
\   'winheight': 10,
\   'direction': 'botright',
\ })

" Unite mapping in ftplugin/unite.vim
