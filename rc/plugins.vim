" File: plugins.vim
" Author: romgrk
" Description: plugins mappings
" Last: 5 April 2016
" !::exe [so %]

let jsx_ext_required        = 1 " Allow JSX in normal JS files
let javascript_plugin_jsdoc = 1

"=============================================================================
" Paths                                                                      {{{

let $XDG_RUNTIME_DIR = $HOME . "/tmp"

let local_vimrc            = {}
let local_vimrc.names      = ['.vimrc', 'vimrc', '.localrc']
let local_vimrc.cache_file = path#Join([$XDG_CACHE_HOME, 'local_vimrc'])

let bookmarks_file = path#Join([$XDG_CACHE_HOME, 'nvim', 'bookmarks'])

let templates_directory = ['~/templates']

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
" Session options (vim-session)                                              {{{

let session_directory = $vim . '/sessions'
let session_command_aliases = 1
let session_default_to_last = 1
let session_persist_colors  = 1
let session_persist_globals = ['g:session_persist_globals', 'g:session']

let session_autoload = 'yes'
let session_autosave = 'yes'
let session_autosave_silent = 1
let session_autosave_periodic = 1
let session_lock_enabled = 0

if !exists('g:session')
    let g:session = {} | end

" }}}
"=============================================================================
" UI options                                                            {{{

let buftabline_show = 0

" }}}
"=============================================================================
" Text/motion plugins                                                        {{{

let incsearch#magic = '\v' " very magic
let incsearch#auto_nohlsearch = 1

let jump_keys = ";lkjhgfdsaqwertyuiopzxcvbnm"
let EasyMotion_keys = jump_keys
let EasyMotion_use_smartsign_us = 1
let EasyMotion_do_mapping = 0

let sneak#streak = 1
let sneak#prompt = '≫ '
let sneak#use_ic_scs = 1
let sneak#target_labels = jump_keys
let sneak#streak_esc = "\<Esc>"
let sneak#textobject_z = 0

let splitjoin_split_mapping = ''
let splitjoin_join_mapping  = ''

let NERDCreateDefaultMappings = 0

let columnMove_mappings = 0

" }}}
"=============================================================================
" Syntax, Folding                                                           {{{

let vimsyn_embed = 'P'
let vimsyn_folding = 'afP'
let vimsyn_noerror = 1

let xml_syntax_folding = 1
let tex_fold_enabled   = 1
let php_folding        = 1
let perl_fold          = 1

let fastfold_savehook = 1
let fastfold_fold_command_suffixes  = ['x','X','a','A','o','O','c','C']
let fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
" nmap zuz (FastFoldUpdate)

" }}}
"=============================================================================
" Tags                                                                      {{{1

let ctrlp_buftag_ctags_bin = '/usr/local/bin/ctags'

let ctrlp_buftag_types = {
\ 'typescript': '--language-force=typescript --typescript-types=niecamfpt',
\ 'css':        '--language-force=css --css-types=tic',
\ 'scss':       '--language-force=scss --scss-types=vmtic',
\ }

let g:tagbar_type_css = {
    \ 'ctagsbin' : 'ctags',
    \ 'ctagsargs' : '--file-scope=yes -o - ',
    \ 'kinds' : [
        \ 'c:classes:1:0',
        \ 'i:ids:1:0',
        \ 't:tags:1:0',
        \ 's:selectors:1:0',
    \ ],
\ }

let g:tagbar_type_scss = {
    \ 'ctagsbin' : 'ctags',
    \ 'ctagsargs' : '--file-scope=yes -o - ',
    \ 'kinds' : [
        \ 'v:variables:1:0',
        \ 'm:mixins:1:0',
        \ 'c:classes:1:0',
        \ 'i:ids:1:0',
        \ 't:tags:1:0',
    \ ],
\ }
let g:tagbar_type_c = {
    \ 'ctagsbin' : 'ctags',
    \ 'ctagsargs' : '--file-scope=yes -o - ',
    \ 'kinds' : [
        \ 'd:macros:1:0',
        \ 'p:prototypes:1:0',
        \ 'g:enums',
        \ 'e:enumerators:0:0',
        \ 't:typedefs:0:0',
        \ 's:structs',
        \ 'u:unions',
        \ 'm:members:0:0',
        \ 'v:variables:0:0',
        \ 'f:functions',
    \ ],
\ }
let tagbar_type_typescript = {
    \ 'ctagstype' : 'typescript',
    \ 'kinds'     : [
        \ 'n:modules',
        \ 't:types',
        \ 'i:interfaces',
        \ 'e:enum',
        \ 'c:classes',
        \ 'a:abstract classes',
        \ 'm:members',
        \ 'f:functions',
        \ 'p:properties',
    \ ] }

let easytags_languages = {
\   'coffee': {
\     'cmd': 'coffeetags',
\       'args': ['--include-vars'],
\       'fileoutput_opt': '-f',
\       'stdout_opt': '-f-',
\       'recurse_flag': '-R'
\   },
\   'moon': {
\     'cmd': 'ctags',
\       'args': [],
\       'fileoutput_opt': '-f',
\       'stdout_opt': '-f-',
\       'recurse_flag': '-R',
\   },
\   'javascript': {
\     'cmd': 'jsctags',
\       'args': [],
\       'fileoutput_opt': '-f',
\       'stdout_opt': '-f-',
\       'recurse_flag': '-R',
\   },
\}

" 1}}}
"=============================================================================
" Various                                                                   {{{1

let colorizer_maxlines = -1
let colorizer_startup  = 0

if exists('*unite#custom#profile')
    call unite#custom#profile('default', 'context', {
    \   'start_insert': 0,
    \   'winheight': 10,
    \   'direction': 'botright',
    \ })
end

let zv_file_types = {
\   'html'             : 'html,css,javascript',
\   'css'              : 'css,html,javascript',
\   'python'           : 'python 3',
\   'javascript'       : 'javascript,nodejs',
\   'typescript'       : 'typescript,javascript,html',
\   '^(G|g)ulpfile\.'  : 'gulp,javascript,nodejs',
\   'help'             : 'vim',
\ }


" }}}1
"=============================================================================
" EOF
