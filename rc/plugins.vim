" File: plugins.vim
" Author: romgrk
" Description: plugins mappings
" Last: 5 April 2016
" !::exe [so %]

" Excludes: non-code buffers, shared by various plugins

let exclude_filetypes =
    \ ['nerdtree', 'terminal', 'cocactions', 'help', 'todoist',
    \  'fugitive', 'clap_input', 'LuaTree']

let exclude_buftypes =
    \ ['help', 'terminal', 'nowrite']

" Settings:

let jsx_ext_required        = 1 " Allow JSX in normal JS files
let javascript_plugin_jsdoc = 1

" Icons:
"
let icons = {
\ 'bufferline_separator_active':   '▎',
\ 'bufferline_separator_inactive': '▎',
\ 'gitgutter_sign_added':            "\u00a0│",
\ 'gitgutter_sign_removed':          "\u00a0│",
\ 'gitgutter_sign_modified':         "\u00a0│",
\ 'gitgutter_sign_modified_removed': "\u00a0│",
\}

"=============================================================================
" Paths                                                                      {{{

let $XDG_RUNTIME_DIR = $HOME . '/tmp'

let local_vimrc            = {}
let local_vimrc.names      = ['.vimrc', '.localrc']
let local_vimrc.cache_file = path#Join([$XDG_CACHE_HOME, 'local_vimrc'])

let bookmarks_file = path#Join([$XDG_CACHE_HOME, 'nvim', 'bookmarks'])

let templates_directory = path#Join([$vim, 'templates'])

" Miniyank
let miniyank_filename = $XDG_CACHE_HOME . '/miniyank.mpack'

" Notes
let notes_directories = ['~/notes']

" Ultisnips
let UltiSnipsSnippetsDir         = $vim . '/after/snip'
let UltiSnipsSnippetDirectories  = [$vim . '/after/snip']

if has('win32')
let python_host_prog  = 'C:\Python27\python.exe'
let python3_host_prog = 'C:\Python34\python.exe'
end


" }}}
"=============================================================================
" Text/motion plugins                                                        {{{

let incsearch#magic = '\v' " very magic
let incsearch#auto_nohlsearch = 1

let jump_keys = ";lkjhgfdsaqwertyuiopzxcvbnm"

let columnMove_mappings = 0

" }}}
"=============================================================================
" Syntax, Folding                                                           {{{

let vimsyn_embed = 'P'
let vimsyn_folding = 'afP'
let vimsyn_noerror = 1

let xml_syntax_folding = 0
let tex_fold_enabled   = 1
let php_folding        = 1
let perl_fold          = 1
" let perl_fold_blocks   = 1

let fastfold_savehook = 1
let fastfold_fold_command_suffixes  = ['x','X','a','A','o','O','c','C']
let fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
" nmap zuz (FastFoldUpdate)

let python_highlight_all = 1

" }}}
"=============================================================================
" Various                                                                   {{{1

let vcoolor_disable_mappings = 1

let miniyank_maxitems = 100

let hexmode_patterns = '*.bin,*.exe,*.dat,*.o,*.wasm'
let hexmode_xxd_options = '-g 1'

" }}}1
"=============================================================================
" EOF
