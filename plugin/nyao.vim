" !::exe [so %]
if !exists('g:nyaovim_version')
    finish
end

set title
"set showtabline=0

command! -nargs=1 -complete=dir CD call NyaoCd(<f-args>)
fu! NyaoCd (...)
    let path = fnamemodify(expand(a:1), ':p')
    call Info(path)
    exe 'cd ' . path
    call rpcnotify(0, 'cd', [path])
endfu

com! -nargs=* -bang Eval call rpcnotify(0, 'js:eval', [<q-args>])
com! Resize   Eval editor.fitToParent()
com! Reload   Eval ThisBrowserWindow.reload()
com! DevTools Eval ThisBrowserWindow.openDevTools()

let nyao_config = $HOME . '/.config/nyaovim'
let nyao_rc     = nyao_config . 'nyaovimrc.html'
let nyao_style  = nyao_config . '/src/style.scss'

com! ENYAOP  Edit ~/.config/nvim/plugin/nyao.vim
com! NYAORC  Edit ~/.config/nyaovim/nyaovimrc.html
com! NYAOI   Edit ~/.config/nyaovim/init.js

nmap gsnv  :VimFiler ~/.config/nyaovim<CR>
nmap gsnd  :VimFiler ~/.config/nyaovim<CR>
nmap gsnrc :NYAORC<CR>
nmap gsns  :Edit <C-r>=nyao_style<CR><CR>
nmap gsnp  :ENYAOP<CR>
nmap gsi   :NYAOI<CR>

map <C-Tab>   :bn<CR>
map <C-S-Tab> :bp<CR>

nnoremap <F5>    :Reload<CR>
nnoremap <C-R>   :Reload<CR>
nnoremap <C-A-I> :DevTools<CR>
nnoremap <C-A-D> :DevTools<CR>
nnoremap <A-s>   :Eval ws.setSidebar()<CR>

redraw
exe 'EchoHL TextInfo ' . g:nyaovim_version
