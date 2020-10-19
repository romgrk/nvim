" vim: fdm=marker
"===============================================================================
" Options                                                                    {{{

let lua_tree_size = 25

let lua_tree_show_icons = {
\ 'git': 0,
\ 'folders': 1,
\ 'files': 1,
\}

let lua_tree_icons = {
\ 'default':     '',
\ 'symlink':     '',
\ 'folder':      {
\   'default':   '',
\   'open':      ''
\   }
\ }
" \ 'git':         {
" \   'unstaged':  '✗',
" \   'staged':    '✓',
" \   'unmerged':  '',
" \   'renamed':   '➜',
" \   'untracked': '★'
" \   },

let lua_tree_git_hl = 1

let lua_tree_bindings = {
\ 'edit':            ['<CR>', 'o'],
\ 'edit_vsplit':     '<C-v>',
\ 'edit_split':      '<C-x>',
\ 'edit_tab':        '<C-t>',
\ 'toggle_ignored':  'I',
\ 'toggle_dotfiles': 'H',
\ 'refresh':         'R',
\ 'preview':         '<Tab>',
\ 'cd':              '<C-o>',
\ 'create':          'a',
\ 'remove':          'd',
\ 'rename':          'r',
\ 'cut':             'x',
\ 'copy':            'c',
\ 'paste':           'p',
\ 'prev_git_item':   '[c',
\ 'next_git_item':   ']c',
\ }

" }}}
"===============================================================================
" Session saving                                                             {{{

" autocmd User SessionSavePre  call OnSessionSavePre()
" autocmd User SessionSavePost call OnSessionSavePost()
"
" " let s:buffer_id = bufnr('CustomPluginBuffer')
" let s:saved_state = v:null
"
" function! OnSessionSavePre()
"   if v:true
"
"     " If it's open, we close the buffer
"     LuaTreeToggle
"
"     " And we add a command that will restore it's state
"     call add(g:session_save_commands, 'LuaTreeToggle')
"
"     " And we remember that we closed it to be able to open it in
"     " the SessionSavePost event
"     let s:saved_state = 'open'
"   end
" endfunc
"
" function! OnSessionSavePost()
"   if s:saved_state == 'open'
"     let winid = win_getid()
"     LuaTreeToggle
"     call win_gotoid(winid)
"   end
" endfunc

" }}}
"===============================================================================
" Highlights                                                                 {{{

hi! LuaTreeNormal  guifg=#e0e0e0 guibg=#24292e gui=none
hi! FolderInverted guifg=#e0e0e0 gui=bold
hi! FileInverted   guifg=#e0e0e0 gui=none

hi! CursorLineInverted guibg=#343d45
" hi! link LuaTreeNormal      TabLine
hi! link LuaTreeEndOfBuffer TabLineFill
hi! link LuaTreeCursorLine  CursorLineInverted
" hi! link LuaTreeVertSplit   TabLineFill

hi! LuaTreeRootFolder guifg=#EBAD0D gui=bold

hi! LuaTreeFolderName guifg=#e0e0e0 gui=bold
hi! LuaTreeFolderIcon guifg=#EBAD0D

" hi! link LuaTreeFolderIcon   FileInverted
hi! link LuaTreeFolderName   FolderInverted
hi! link LuaTreeSymlink      FileInverted
hi! link LuaTreeExecFile     FileInverted
hi! link LuaTreeSpecialFile  FileInverted
hi! link LuaTreeImageFile    FileInverted
hi! link LuaTreeMarkdownFile FileInverted

hi! LuaTreeGitDirty   guifg=#ff3322
hi! LuaTreeGitStaged  guifg=#6CDF40
hi! LuaTreeGitMerge   guifg=#FFD33F
hi! LuaTreeGitRenamed guifg=#FFD33F
hi! LuaTreeGitNew     guifg=#ff3322

" }}}
"===============================================================================
