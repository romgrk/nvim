" !::exe [so %]
" Enable git
function! git#Enable ()

" GitGutter TODO assert usage
nnoremap <silent>[h :GitGutterPrevHunk<CR>
nnoremap <silent>]h :GitGutterNextHunk<CR>
nnoremap   [Space]hh :GitGutter
nnoremap   [Space]hs :GitGutterStageHunk<CR>
nnoremap   [Space]hv :GitGutterPreviewHunk<CR>
nnoremap   [Space]hr :GitGutterRevertHunk<CR>
nnoremap         -- :GitGutterRevertHunk<CR>
nnoremap         \\ :GitGutterPreviewHunk<CR>
nnoremap         ++ :GitGutterStageHunk<CR>

nnoremap [Space]gc :Gcommit<Space>
nnoremap [Space]gm :Gcommit % -m ''<Left>

execute 'GitGutterEnable'
endfu

" Disable git
function! git#Disable ()

execute 'GitGutterDisable'
endfu
