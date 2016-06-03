" File: plugins.vim
" Author: romgrk
" Description: plugins mappings
" Last: 5 April 2016
" !::exe [so %]

let buftabline_show = 0

"=============================================================================
" Paths                                                                      {{{

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

" }}}
"=============================================================================
" Session options (vim-session)                                              {{{

let session_directory = $vim . '/sessions'
let session_command_aliases = 1
let session_default_to_last = 1
let session_persist_colors  = 1
let session_persist_globals = ['g:session_persist_globals']

let session_autoload = 'yes'
let session_autosave = 'yes'
let session_autosave_silent = 1
let session_autosave_periodic = 1

if !exists('g:session')
    let g:session = {} | end

" }}}
"=============================================================================
" Text/motion plugins                                                        {{{

let incsearch#magic = '\v' " very magic
let incsearch#auto_nohlsearch = 1

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

let NERDCreateDefaultMappings = 0

" }}}
"=============================================================================
" Folding                                                                    {{{

let vimsyn_folding     = 'af'
let xml_syntax_folding = 1
let tex_fold_enabled   = 1
let php_folding        = 1
let perl_fold          = 1

let fastfold_savehook = 1
let fastfold_fold_command_suffixes = ['x','X','a','A','o','O','c','C']
let fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
"nmap zuz (FastFoldUpdate)


" }}}
"=============================================================================
" Tags                                                                      {{{1

let tagbar_left = 0
"let tagbar_width = 40
"let tagbar_zoomwidth = 0
let tagbar_autoshowtag = 1
let tagbar_autopreview = 0
"let tagbar_iconchars = ['▶', '▼']

function! s:buftag (val)
    return printf(a:val, "--language-force=", " --", "-types=")
endfunc
let ctrlp_buftag_ctags_bin = '/usr/local/bin/ctags'
let ctrlp_buftag_types = {
\ 'typescript': s:buftag('%stypescript%stypescript%sniecamfpt'),
\ 'coffee' : { 'bin': 'coffeetags', 'args': '-f-', },
\ 'moon': { 'bin': 'ctags', 'args': '-f-', },
\ }

" tagbar_type_% {{{
" let tagbar_type_typescript = {
    " \ 'ctagstype' : 'typescript',
    " \ 'kinds'     : [
        " \ 'n:modules',
        " \ 't:types',
        " \ 'i:interfaces',
        " \ 'e:enum',
        " \ 'c:classes',
        " \ 'a:abstract classes',
        " \ 'm:members',
        " \ 'f:functions',
        " \ 'p:properties',
    " \ ]
" \ }
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
"}}}

let easytags_async          = 1
let easytags_dynamic_files  = 2
let easytags_resolve_links  = 1
let easytags_auto_update    = 1
let easytags_auto_highlight = 0
" easytags_languages {{{
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
\   'javascript': {
\     'cmd': 'jsctags',
\       'args': [],
\       'fileoutput_opt': '-f',
\       'stdout_opt': '-f-',
\       'recurse_flag': '-R',
\   },
\}
"}}}

" 1}}}
"=============================================================================
" Various                                                                   {{{1

let colorizer_maxlines = -1
let colorizer_startup  = 0

let haddock_browser = 'chrome'
let haskellmode_completion_ghc = 1

let used_javascript_libs = ''

autocmd VimEnter * :call pp#prettyTheme()

" }}}1
"=============================================================================
" EOF
