set nobuflisted
set cursorline

nnoremap <silent><buffer><Esc>   <cmd>wincmd p<CR>
nnoremap <silent><buffer>q       <cmd>wincmd c<CR>

inoremap <silent><buffer><C-c>   <cmd>wincmd c<CR>
inoremap <silent><buffer><Tab>   <cmd>lua require'grug-far'.get_instance():goto_next_input()<CR>
inoremap <silent><buffer><S-Tab> <cmd>lua require'grug-far'.get_instance():goto_prev_input()<CR>
inoremap <silent><buffer><C-CR>  <Esc>:lua require'grug-far'.get_instance():goto_next_match()<CR>:lua require'grug-far'.get_instance():goto_location()<CR>
