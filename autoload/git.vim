" !::exe [so %]
" Enable git
function! git#Enable ()

" GitGutter TODO assert usage
nnoremap <silent>[h :GitGutterPrevHunk<CR>
nnoremap <silent>]h :GitGutterNextHunk<CR>
nnoremap        \hh :GitGutter
nnoremap        \hs :GitGutterStageHunk<CR>
nnoremap        \hv :GitGutterPreviewHunk<CR>
nnoremap        \hr :GitGutterRevertHunk<CR>
nnoremap         -- :GitGutterRevertHunk<CR>
nnoremap         ++ :GitGutterStageHunk<CR>

nmap \gc :Gcommit<space>
nmap \c  :Gcommit<space>

execute 'GitGutterEnable'
endfu

" Disable git
function! git#Disable ()


execute 'GitGutterDisable'
endfu
