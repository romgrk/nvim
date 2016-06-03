
let NERDDelimiterMap['typescript'] =
        \ {'rightAlt': '*/', 'leftAlt': '/*', 'left': '//'}

" let tsuquyomi_disable_quickfix = 1

setlocal foldmethod=syntax

" setlocal omnifunc=tsuquyomi#complete
setlocal completeopt=menu,menuone,preview

setlocal keywordprg=:Zeavim
nnoremap <buffer> K :Zeavim<CR>


vmap <buffer> <A-'>         <Plug>NERDCommenterSexy
nmap <buffer> <A-'>         <Plug>NERDCommenterToggle



nmap     <buffer> <C-R>     <Plug>(TsuquyomiRenameSymbol)
nnoremap <buffer> <leader>r :TsuReferences<CR>

nnoremap <buffer> <leader>w :Info ' =>' . tsuquyomi#hint()<CR>
inoremap <buffer> <M-h>     <Esc>:Info ' =>' . tsuquyomi#hint()<CR>a


imap     <buffer> @         this.<Tab>

inoremap <buffer> <A-t>     this.
inoremap <buffer> <A-i>p    private<space>
inoremap <buffer> <A-i>d    document.
inoremap <buffer> <A-o>     ()<left>

inoremap <buffer> .     .<C-X><C-O><C-P>
