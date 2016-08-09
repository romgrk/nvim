nm <buffer> <Esc>       :WinMain<CR>
nm <buffer> <C-tab>     :wincmd p<CR><c-tab>
nm <buffer> <S-C-tab>   :wincmd p<CR><s-c-tab>

nm <buffer> gp :NERDTreeCWD<CR>
nm <buffer> gh :NERDTree <C-r>=expand('~')<CR><CR>

nm <buffer> a ma
nm <buffer> A ma/<Left>
nm <buffer> d md
nm <buffer> M mm

nmap <buffer> . I

setlocal conceallevel=1
