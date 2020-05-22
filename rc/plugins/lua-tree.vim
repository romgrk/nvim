hi! link LuaTreeFolderName Directory
hi! LuaTreeFolderIcon guifg=#EBAD0D

hi! NERDTreeFlags    guifg=#EBAD0D

let lua_tree_show_icons = {
\ 'git': 1,
\ 'folders': 1,
\ 'files': 1,
\}

let lua_tree_bindings = {
\ 'edit':        'o',
\ 'edit_vsplit': '<C-v>',
\ 'edit_split':  '<C-x>',
\ 'edit_tab':    '<C-t>',
\ 'cd':          '.',
\ 'create':      'a',
\ 'remove':      'd',
\ 'rename':      'r'
\ }
