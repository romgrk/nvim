let &path = '.,' . &path
set include=^\\s*include
set includeexpr=v:fname.'.jade'
nnoremap <buffer> <C-A-E> :Neomake puglint<CR>
