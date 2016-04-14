let b:panel = 1
setlocal nonu
setlocal nobuflisted
setlocal buftype=nofile

au BufEnter <buffer> setlocal cursorline

"if exists('*TabLineUpdate')
    "au TextChanged <buffer> call TabLineUpdate()
    "call TabLineUpdate()
"end

nmap <buffer> i :VimFilerPrompt<CR>

nmap <buffer> gj      :Autojump<CR>
nmap <buffer> v       <Plug>(vimfiler_quick_look)
nmap <buffer> <space> <Plug>(vimfiler_quick_look)

nmap <buffer> D     :VimFilerDouble<CR>
nmap <buffer> <A-a> :VimFilerDouble<CR>

nmap <silent><nowait> <buffer> <A-w>      :GoNextVimfilerWindow<CR>
nmap <silent><nowait> <buffer> <Tab>      :GoFirstListedWindow<CR>
nmap <silent><nowait> <buffer> <Esc>      :VimFilerClose default<CR>

let kExpand = "\<Plug>(vimfiler_expand_tree)"
let kEdit   = "yy:Edit \<C-r>\"\<CR>"
let kOpen   = "yy:Edit \<C-r>\"\<CR>g\<A-e>"

nmap <buffer> <Plug>(vimfiler_edit_file) yy:Edit <C-r>"<CR>
nmap <buffer><expr> e vimfiler#smart_cursor_map(
            \
            \kExpand,
            \"yy:Edit \<C-r>\"\<CR>:VimFiler<CR>")
nmap <buffer><expr> o vimfiler#smart_cursor_map(
            \
            \kExpand,
            \"yy:Edit \<C-r>\"\<CR>:VimFiler<CR>")

nmap <buffer> <C-v> <Plug>(vimfiler_switch_vim_buffer_mode)
nmap <buffer> g;    <Plug>(vimfiler_choose_action)
nmap <buffer> gh    <Plug>(vimfiler_switch_to_home_directory)
nmap <buffer> gp    :VimFiler <C-r>=getcwd()<CR><CR>
nmap <buffer> gv    :VimFiler <C-r>=$vim<CR><CR>
nmap <buffer> gg    :VimFiler <C-r>=$HOME . '/github/'<CR><CR>

nmap <buffer> J    <Plug>(vimfiler_jump_last_child)
nmap <buffer> K    <Plug>(vimfiler_jump_first_child)
nmap <buffer> p    Kk
nmap <buffer> u    <Plug>(vimfiler_switch_to_parent_directory)
nmap <buffer> <BS> <Plug>(vimfiler_switch_to_parent_directory)

nmap <buffer> a <Plug>(vimfiler_new_file)
nmap <buffer> A <Plug>(vimfiler_make_directory)

nmap <buffer> <expr><nowait> x "\<Plug>(vimfiler_toggle_mark_current_line_up)" . "j"
nmap <buffer> <expr><nowait> v "\<Plug>(vimfiler_toggle_mark_current_line_up)" . "j"

nmap <buffer> h .
nmap <buffer> l  <NOP>
"nmap <buffer> ge <NOP>
