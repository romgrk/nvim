" !::exe [so %]
" Enable git
function! git#Enable ()

" GitGutter TODO assert usage
nnoremap <silent>[h  :GitGutterPrevHunk<CR>
nnoremap <silent>]h  :GitGutterNextHunk<CR>
nnoremap   [Space]hh :GitGutter
nnoremap   [Space]hs :GitGutterStageHunk<CR>
nnoremap   [Space]hv :GitGutterPreviewHunk<CR>
nnoremap   [Space]hr :GitGutterUndoHunk<CR>
nnoremap          -- :GitGutterUndoHunk<CR>
nnoremap          \\ :GitGutterPreviewHunk<CR>
nnoremap          ++ :GitGutterStageHunk<CR>

nnoremap   [Space]gp :Gpush<CR>
nnoremap   [Space]gc :Gcommit -m ''<Left>
nnoremap   [Space]gm :Gcommit % -m ''<Left>
nnoremap   [Space]gd :Gdiff %<CR>
nnoremap   [Space]ga :Git add %<CR>

execute 'GitGutterEnable'
endfu

" Disable git
function! git#Disable ()

execute 'GitGutterDisable'
endfu
