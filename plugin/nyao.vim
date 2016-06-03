" !::exe [So]
if !exists('g:nyaovim_version') && !(getcwd() =~ 'neovim-component') && !(SessionLine()==#'nyao')
    finish
end

fu! NyaoCd (...)
    let path = fnamemodify(expand(a:1), ':p')
    call Info(path)
    exe 'cd ' . path
    call rpcnotify(0, 'cd', [path])
endfu

function! JsEval (...)
    Info 'Sending js:eval, ' . string(a:000) . '...'
    let channel_id = get(g:,'_channel_id',1)
    call rpcnotify(channel_id, 'js:eval', a:000)
endfunc

command! -nargs=1 -complete=dir CD call NyaoCd(<f-args>)
command! -nargs=* Eval     call JsEval(<q-args>)
command!          Resize   Eval editor.fitToParent()
command!          Reload   exec 'SaveSession!' | Eval ThisBrowserWindow.reload()
command!          DevTools Eval ThisBrowserWindow.openDevTools()

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
nnoremap <C-A-R> :Reload<CR>
nnoremap <C-A-I> :DevTools<CR>
nnoremap <C-A-D> :DevTools<CR>
nnoremap <C-A-S> :Eval ws.setSidebar()<CR>

if !exists('g:did_spname')
    let g:did_spname = 1
    call HL_SpName()
end

" Info expand('<sfile>') . ' sourced'
