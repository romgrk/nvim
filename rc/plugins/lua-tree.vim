" vim: fdm=marker
"===============================================================================
" Options                                                                    {{{

let lua_tree_size = 25

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

hi! LuaTreeNormal  guifg=#ffffff guibg=#24292e gui=none
hi! FolderInverted guifg=#ffffff gui=bold
hi! FileInverted   guifg=#ffffff gui=none

hi! CursorLineInverted guibg=#343d45
" hi! link LuaTreeNormal      TabLine
hi! link LuaTreeEndOfBuffer TabLineFill
hi! link LuaTreeCursorLine  CursorLineInverted
" hi! link LuaTreeVertSplit   TabLineFill

hi! LuaTreeFolderName guifg=#ffffff gui=bold
hi! LuaTreeFolderIcon guifg=#EBAD0D
" hi! link LuaTreeFolderIcon   FileInverted
hi! link LuaTreeFolderName   FolderInverted
hi! link LuaTreeSymlink      FileInverted
hi! link LuaTreeExecFile     FileInverted
hi! link LuaTreeSpecialFile  FileInverted
hi! link LuaTreeImageFile    FileInverted
hi! link LuaTreeMarkdownFile FileInverted

hi! LuaTreeGitDirty   guifg=red
hi! LuaTreeGitStaged  guifg=red
hi! LuaTreeGitMerge   guifg=red
hi! LuaTreeGitRenamed guifg=red
hi! LuaTreeGitNew     guifg=red

" }}}
"===============================================================================
