" File: plugins.vim
" Author: romgrk
" Description: plugins mappings
" Last: 5 April 2016
" !::exe [so %]

let local_vimrc = {}
let local_vimrc.names = ['.vimrc']
let local_vimrc.cache_file = path#Join([$XDG_CACHE_HOME, 'local_vimrc'])

let templates_directory = ['~/templates']

" Notes
let notes_directories = ['~/notes']

" Ultisnips
let UltiSnipsSnippetsDir         = $vim . '/after/snip'
let UltiSnipsSnippetDirectories  = [$vim . '/after/snip']

" Session options (vim-session)                                              {{{
let session_directory = $vim . '/sessions'
let session_command_aliases = 1
let session_default_to_last = 1
let session_persist_colors  = 0
let session_persist_globals = ['g:session_persist_globals']

let session_autoload = 'yes'
let session_autosave = 'yes'
let session_autosave_silent = 1
let session_autosave_periodic = 0

if !exists('g:session')
    let g:session = {} | end

" }}}

let colorizer_startup  = 0
let colorizer_maxlines = -1
"com! ColorHighlight let colorizer_maxlines = -1


let incsearch#auto_nohlsearch = 1

let vim_search_pulse_disable_auto_mappings = 1
let vim_search_pulse_duration = 150

"=============================================================================
" Text/motion plugins                                                        {{{

" TODO check new settings
let EasyMotion_keys = ";lkjhgfdsaqwertyuiopzxcvbnm"
let EasyMotion_do_mapping = 0
let EasyMotion_use_smartsign_us = 1

let sneak#prompt = 'Sneak: '
let sneak#use_ic_scs = 1
let sneak#target_labels = ";lkjhgfdsaqwertyuiopzxcvbnm"
let sneak#streak_esc = "\<Esc>"
let sneak#textobject_z = 0


let splitjoin_split_mapping = ''
let splitjoin_join_mapping  = ''

" }}}
"=============================================================================
" Tags                                                                      {{{1

let tagbar_left = 0
"let tagbar_width = 40
"let tagbar_zoomwidth = 0
let tagbar_autoshowtag = 1
let tagbar_autopreview = 0
"let tagbar_iconchars = ['▶', '▼']

let easytags_async          = 1
let easytags_dynamic_files  = 2
let easytags_resolve_links  = 1
let easytags_auto_update    = 1
let easytags_auto_highlight = 0
let easytags_languages      = {
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
\   'typescript': {
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

let tagbar_type_typescript = {
    \ 'ctagstype' : 'typescript',
    \ 'kinds'     : [
        \ 'f:functions',
        \ 'c:classes',
        \ 'm:methods',
        \ 's:static properties',
        \ 'p:properties',
        \ 'v:variables',
    \ ]
\ }

let tagbar_type_moon = {
    \ 'ctagstype' : 'moonscript',
    \ 'kinds'     : [
        \ 'f:functions',
        \ 'c:classes',
        \ 'm:methods',
        \ 's:static properties',
        \ 'p:properties',
        \ 'v:variables',
    \ ]
\ }

"let tagbar_type_javascript = {
    "\ 'ctagsbin' : 'jsctags',
    "\ 'kinds'     : [
        "\ 'f:functions',
        "\ 'c:classes',
        "\ 'm:methods',
        "\ 'p:properties',
        "\ 'v:global variables',
    "\ ]
"\ }

let ctrlp_buftag_types = {
\ 'coffee' : {
    \ 'bin': 'coffeetags',
    \ 'args': '-f-',
    \ },
\ 'moon': {
\     'bin': 'ctags',
\     'args': '-f-',
\   },
\ }

" 1}}}
"=============================================================================
" Various                                                                   {{{1

let haddock_browser = 'chrome'
let haskellmode_completion_ghc = 1

" }}}1
"=============================================================================
" EOF
