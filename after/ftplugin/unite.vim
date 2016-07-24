nmap <buffer><Esc><Esc>  q
" imap <buffer><Esc><Esc>  <Esc>q
imap <buffer> jj        <Plug>(unite_insert_leave)

imap <buffer> <Tab>     <Plug>(unite_narrowing_path)
nmap <buffer> <Tab>     <Plug>(unite_narrowing_path)

nmap <buffer> <A-p>     <Plug>(unite_toggle_auto_preview)
nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
imap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)

imap <buffer> <A-u>     <Plug>(unite_delete_backward_path)
" imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

imap <buffer> <A-k>     <Plug>(unite_select_previous_line)
imap <buffer> <A-j>     <Plug>(unite_select_next_line)
imap <buffer> <C-k>     <Plug>(unite_select_previous_line)
imap <buffer> <C-j>     <Plug>(unite_select_next_line)
" imap <buffer> <Tab>     <Plug>(unite_select_next_line)
" imap <buffer> <S-Tab>   <Plug>(unite_select_previous_line)
"imap <buffer> <C-k>     <Plug>(unite_select_next_line)
"imap <buffer> <C-j>     <Plug>(unite_select_previous_line)

imap <buffer><expr> j unite#smart_map('j', '')
nmap <buffer> '     <Plug>(unite_quick_match_default_action)
imap <buffer> '     <Plug>(unite_quick_match_default_action)
nmap <buffer> <A-;>     <Plug>(unite_quick_match_jump)
imap <buffer> <A-;>     <Esc><Plug>(unite_quick_match_jump)

nmap <buffer> <C-p>     <Plug>(unite_toggle_transpose_window)
nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)

"nn <silent><buffer><expr> l
        "\ unite#smart_map('l', unite#do_action('default'))

let unite = unite#get_current_unite()
if unite.profile_name ==# 'search'
    nn <silent><buffer><expr> r     unite#do_action('replace')
else
    nn <silent><buffer><expr> r     unite#do_action('rename')
end
nn <silent><buffer><expr> cd     unite#do_action('lcd')
nn <buffer><expr> S      unite#mappings#set_current_filters(
        \ empty(unite#mappings#get_current_filters()) ?
        \ ['sorter_reverse'] : [])

" Runs "split" action by <C-s>.
imap <silent><buffer><expr> <C-s>     unite#do_action('split')
imap <silent><buffer><expr> <C-v>     unite#do_action('vsplit')

inoremap <buffer><C-a> <Esc>0v$

