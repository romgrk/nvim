nm <buffer> <esc>       :WinMain<CR>
nm <buffer> <c-tab>     :wincmd p<CR><c-tab>
nm <buffer> <s-c-tab>   :wincmd p<CR><s-c-tab>

nm <buffer> gp :NERDTreeCWD<CR>
nm <buffer> gh :NERDTree <C-r>=expand('~')<CR><CR>

nm <buffer> a ma
nm <buffer> A ma/<Left>
nm <buffer> d md
nm <buffer> M mm

nmap <buffer> . I
