" !::exe [so %]
" Enable git
function! git#Enable ()

" GitGutter TODO assert usage
nnoremap <silent>[h  :GitGutterPrevHunk<CR>
nnoremap <silent>]h  :GitGutterNextHunk<CR>
nnoremap   <leader>hh :GitGutter
nnoremap   <leader>hs :GitGutterStageHunk<CR>
nnoremap   <leader>hv :GitGutterPreviewHunk<CR>
nnoremap   <leader>hr :GitGutterUndoHunk<CR>
nnoremap          -- :GitGutterUndoHunk<CR>
nnoremap          \\ :GitGutterPreviewHunk<CR>
nnoremap          ++ :GitGutterStageHunk<CR>

execute 'GitGutterEnable'
endfu

" Disable git
function! git#Disable ()

execute 'GitGutterDisable'
endfu
