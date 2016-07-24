" !::exe [So]
" if !exists('g:nyaovim_version') && !(getcwd() =~ 'neovim-component')
    " finish | end

let $NYAO = $HOME . '/.config/nyaovim'
let nyao_rc    = $NYAO . '/nyaovimrc.html'
let nyao_style = $NYAO . '/src/style.scss'

function! JsEval (...)
    Info 'Sending js:eval, ' . string(a:000) . '...'
    let channel_id = get(g:,'_ui_channel',1)
    call rpcnotify(channel_id, 'js:eval', a:000)
endfunc
function! NyaoCd (...)
    let path = fnamemodify(expand(a:1), ':p')
    call Info(path)
    exec 'cd ' . path
    call JsEval('fv.setPath(' . string(getcwd()) . ')')
endfunc

function! SetFontFamily (name)
    let code =
        \ printf('editorScreen.changeFontFamily("%s")', a:name)
    call JsEval(code)
endfunc
function! SetFontSize (pixels)
    let code =
        \ printf('editorScreen.changeFontSize(%s)', a:pixels)
    call JsEval(code)
endfunc
function! SetLineHeight (ratio)
    let code =
        \ printf('editorScreen.changeLineHeight(%s)', a:ratio)
    call JsEval(code)
endfunc


" Commands: General
command! -nargs=* Eval call JsEval(<q-args>)
command! Resize   Eval fitToParent(editor)
command! Reload   exec 'SaveSession!' | Eval ThisBrowserWindow.reload()
command! DevTools Eval ThisBrowserWindow.openDevTools()

" Commands: Styling
command! -nargs=1 FontFamily call SetFontFamily(<q-args>)
command! -nargs=1 FontSize 	 call SetFontSize(<args>)
command! -nargs=1 LineHeight call SetLineHeight(<args>)

" Commands: UI views
command! -nargs=1 -complete=dir
       \ CD call NyaoCd(<f-args>)


" Mappings:
" Go-setting mappings
nmap gsnv  :Explore ~/.config/nyaovim<CR>
nmap gsnd  :Explore ~/.config/nyaovim<CR>
nmap gsnrc :Edit    ~/.config/nyaovim/nyaovimrc.html<CR>
nmap gsns  :Edit    <C-R>=nyao_style<CR><CR>
nmap gsnp  :Edit    ~/.config/nvim/plugin/nyao.vim<CR>
nmap gsi   :Edit    ~/.config/nyaovim/init.js<CR>

" Not wroking
map <C-Tab>   :bn<CR>
map <C-S-Tab> :bp<CR>

nnoremap <F5>    :Reload<CR>
nnoremap <C-A-R> :Reload<CR>
nnoremap <C-A-i> :DevTools<CR>
nnoremap <C-A-S> :Eval ws.setSidebar()<CR>


