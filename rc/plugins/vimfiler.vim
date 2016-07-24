" !::exe [so %]
let vimfiler_force_overwrite_statusline = 0
" Icons
let vimfiler_tree_leaf_icon     = ''
let vimfiler_tree_opened_icon   = ' '
let vimfiler_tree_closed_icon   = ' '
let vimfiler_file_icon          = ' '
let vimfiler_readonly_file_icon = ' '
let vimfiler_marked_file_icon   = ' '
let vimfiler_expand_jump_to_first_child = 0
let vimfiler_quick_look_command = 'gloobus-preview'

" Default settings: side bar
fu! vimfiler#_setup ()
    if !exists('*vimfiler#custom#profile')
        au! VimEnter * call vimfiler#_setup()
        return
    end

    call vimfiler#custom#profile('default', 'context', {
    \ 'safe' : 0, 'status' : 0, 'parent' : 0,
    \ 'columns': '', 'explorer-columns': '',
    \ 'explorer': 1,
    \ 'split': 1, 'direction': 'topleft',
    \ 'winwidth': 25, 'winminwidth': 25,
    \ 'edit_action' : 'Edit',
    \ 'no-quit': 1,
    \})
endfu
call vimfiler#_setup()
