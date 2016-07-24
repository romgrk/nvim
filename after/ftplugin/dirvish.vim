setlocal nonu

nnoremap <buffer> h :keeppatterns g@\v/\.[^\/]+/?$@d<cr>
nmap     <buffer> <C-R> R
nmap     <buffer>     i /

nnoremap <buffer> u     <Plug>(dirvish_up)
nmap     <buffer> gu    <Plug>(dirvish_up)
nmap     <buffer> <A-u> <Plug>(dirvish_up)
nmap     <buffer> q     <Plug>(dirvish_quit)

nnoremap <buffer> e :call dirvish#open('edit', 0)<CR>
xnoremap <buffer> e :call dirvish#open('edit', 0)<CR>
nnoremap <buffer> v :call dirvish#open('vsplit', 0)<CR>
xnoremap <buffer> v :call dirvish#open('vsplit', 0)<CR>
nnoremap <buffer> t :call dirvish#open('tabedit', 0)<CR>
xnoremap <buffer> t :call dirvish#open('tabedit', 0)<CR>
"nmap     <buffer> o p
"xmap     <buffer> o p
nnoremap <buffer> a o
nnoremap <buffer> a o

nnoremap <buffer> <silent> <space> :!gloobus-preview <C-R><C-A><CR>

sort r /[^\/]$/

call feedkeys('i')
