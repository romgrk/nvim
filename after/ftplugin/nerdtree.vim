nnoremap <buffer> <Esc>       :WinMain<CR>
nnoremap <buffer> <C-tab>     :wincmd p<CR><c-tab>
nnoremap <buffer> <S-C-tab>   :wincmd p<CR><s-c-tab>

nnoremap <buffer> gp :NERDTreeCWD<CR>
nnoremap <buffer> gh :NERDTree <C-r>=expand('~')<CR><CR>

nmap <buffer> a ma
nmap <buffer> A ma/<Left>
nmap <nowait><buffer> d md
nmap <buffer> M mm

nmap <buffer> . I

setlocal conceallevel=1
