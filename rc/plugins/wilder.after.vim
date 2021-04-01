call wilder#enable_cmdline_enter()
" only / and ? are enabled by default
call wilder#set_option('modes', ['/', '?', ':'])
call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ }))
