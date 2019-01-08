" File: plugins.vim
" Author: romgrk
" Description: plugins mappings
" Last: 5 April 2016
" !::exe [so %]

let jsx_ext_required        = 1 " Allow JSX in normal JS files
let javascript_plugin_jsdoc = 1

let ale_sign_error   = '⨯ ' " ✖
let ale_sign_warning = '· ' " ⚠

let LanguageClient_diagnosticsDisplay = {
\ 1: {
\     "name": "Error",
\     "texthl": "ALEError",
\     "signText": "⨯",
\     "signTexthl": "ALEErrorSign",
\ },
\ 2: {
\     "name": "Warning",
\     "texthl": "ALEWarning",
\     "signText": "·",
\     "signTexthl": "ALEWarningSign",
\ },
\ 3: {
\     "name": "Information",
\     "texthl": "ALEInfo",
\     "signText": "ℹ",
\     "signTexthl": "ALEInfoSign",
\ },
\ 4: {
\     "name": "Hint",
\     "texthl": "ALEInfo",
\     "signText": "➤",
\     "signTexthl": "ALEInfoSign",
\ },
\}



"=============================================================================
" Paths                                                                      {{{

let $XDG_RUNTIME_DIR = $HOME . '/tmp'

let local_vimrc            = {}
let local_vimrc.names      = ['.vimrc', 'vimrc', '.localrc']
let local_vimrc.cache_file = path#Join([$XDG_CACHE_HOME, 'local_vimrc'])

let bookmarks_file = path#Join([$XDG_CACHE_HOME, 'nvim', 'bookmarks'])

let templates_directory = ['~/templates']

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

let unstack_mapkey = '<F9>'

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
" Tags                                                                      {{{1

let ctags_cmd = 'ctags'

let easytags_cmd = ctags_cmd
let easytags_async = 1
let easytags_dynamic_files = 1
let easytags_events = ['BufWritePost']


let ctrlp_buftag_ctags_bin = ctags_cmd

let ctrlp_buftag_types = {
\ 'typescript': '--language-force=typescript --typescript-types=niecamfpt',
\ 'css':        '--language-force=css --css-types=tic',
\ 'scss':       '--language-force=scss --scss-types=vmtic',
\ 'less':       '--language-force=less --less-types=cmv',
\ 'vim':        '--language-force=vim --vim-kinds=acfv',
\ 'proto':      '--language-force=protobuf --vim-kinds=pmfegs',
\ 'javascript' : {
    \ 'bin': 'jsctags',
    \ 'args': '-f -',
\ },
\ }

let tagbar_type_css = {
    \ 'ctagsbin' : 'ctags',
    \ 'ctagsargs' : '--file-scope=yes -o - ',
    \ 'kinds' : [
        \ 'c:classes:1:0',
        \ 'i:ids:1:0',
        \ 't:tags:1:0',
        \ 's:selectors:1:0',
    \ ],
\ }

let tagbar_type_scss = {
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
let tagbar_type_c = {
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

let vcoolor_disable_mappings = 1

let miniyank_maxitems = 100

let hexmode_patterns = '*.bin,*.exe,*.dat,*.o,*.wasm'
let hexmode_xxd_options = '-g 1'

let colorizer_maxlines = -1
let colorizer_startup  = 0

let NERDTreeIndicatorMapCustom = {
\   'Modified'  : '✹',
\   'Staged'    : '✚',
\   'Untracked' : '✭',
\   'Renamed'   : '➜',
\   'Unmerged'  : '═',
\   'Deleted'   : '✖',
\   'Dirty'     : '✹',
\   'Clean'     : '✔︎',
\   'Unknown'   : '?'
\ }

" }}}1
"=============================================================================
" EOF
