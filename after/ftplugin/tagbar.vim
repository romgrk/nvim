let autowidth=0
setlocal nolist
nm <buffer> <esc>       :wincmd p<CR>
nm <buffer> <c-tab>     :wincmd p<CR><c-tab>
nm <buffer> <s-c-tab>   :wincmd p<CR><s-c-tab>

hi! link TagbarSignature Type
