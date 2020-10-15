" File: init.vim
" Author: romgrk
" Description: neovim init file

"=============================================================================
" Vim setup                                                                {{{

let $vim = stdpath('config')

" Load one file from ./rc/
function! s:source_rc(file)
    if a:file =~# '.lua$'
        execute 'luafile ' . fnameescape($vim . '/rc/' . a:file)
    else
        execute 'source ' . fnameescape($vim . '/rc/' . a:file)
    end
endfu

" Load all files from ./rc/plugins/
function! s:source_plugins()
    for file in split(glob($vim . '/rc/plugins/*'), "\n")
        exe 'source ' . file
    endfor
endfunc

" }}}
"=============================================================================
" Settings                                                                 {{{

call s:source_rc('settings.vim')
call s:source_rc('plugins.vim')

" Plugin settings (before loading):
call s:source_plugins()

"                                                                          }}}
"=============================================================================
" Plugins                                                                  {{{
call plug#begin($vim . '/bundle')

" Editing                                                                    {{{
Plug 'AndrewRadev/sideways.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'bkad/CamelCaseMotion'
Plug 'coderifous/textobj-word-column.vim'
Plug 'jiangmiao/auto-pairs'
" Plug 'justinmk/vim-sneak'
Plug 'romgrk/vim-sneak'
Plug 'kana/vim-niceblock'
Plug 'Konfekt/vim-ctrlxa'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neoclide/coc.nvim', { 'do': 'yarn install' }
Plug 'neomake/neomake'
Plug 'scrooloose/nerdcommenter'
Plug 'sirver/UltiSnips'
Plug 'terryma/vim-multiple-cursors'
Plug 'tommcdo/vim-ninja-feet'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'wellle/line-targets.vim'
Plug 'wellle/targets.vim'
" }}}
" General                                                                    {{{
" @plugins
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'wellle/visual-split.vim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'aperezdc/vim-template'
Plug 'bfredl/nvim-miniyank'
Plug 'fidian/hexmode'
Plug 'haya14busa/incsearch.vim'
Plug 'honza/vim-snippets'
Plug 'itchyny/vim-gitbranch'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf'                                      , { 'dir': '~/.local/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'liuchengxu/vim-clap'
Plug 'liuchengxu/vista.vim'
Plug 'MarcWeber/vim-addon-local-vimrc'
Plug 'neovim/nvim-lsp'
" Plug 'puremourning/vimspector'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'
Plug 'vim-scripts/loremipsum'
Plug 'wbthomason/lsp-status.nvim'
Plug 'wsdjeg/vim-fetch'
Plug 'wsdjeg/vim-todo'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
" Plug 'xolox/vim-session'
Plug 'romgrk/vim-session'
Plug 'xolox/vim-shell'
" }}}
" Language                                                                   {{{
Plug 'AndrewRadev/tagalong.vim'
Plug 'neoclide/jsonc.vim'
Plug 'justinmk/vim-syntax-extra'
Plug 'tbastos/vim-lua'                                   , { 'for': 'lua' }
Plug 'thyrgle/vim-dyon'                                  , { 'for': 'dyon' }
Plug 'keith/swift.vim'                                   , { 'for': 'swift' }
Plug 'jordwalke/vim-reasonml'                            , { 'for': 'reason' }
Plug 'rhysd/vim-crystal'                                 , { 'for': 'crystal' }
Plug 'vim-python/python-syntax'                          , { 'for': 'python' }
Plug 'tmhedberg/SimpylFold'                              , { 'for': 'python' }
Plug 'mattboehm/vim-unstack'                             , { 'for': 'python' }
Plug 'othree/xml.vim'
Plug 'pangloss/vim-javascript'                           , { 'for': 'javascript' }
Plug 'leafgarland/typescript-vim'                        , { 'for': 'typescript' }
Plug 'neoclide/vim-jsx-improve'                          , { 'for': 'javascript.jsx' }
Plug 'ianks/vim-tsx'                                     , { 'for': 'typescript.tsx' }
Plug 'moll/vim-node'                                     , { 'for': 'javascript.node' }
Plug 'Quramy/tsuquyomi'                                  , { 'on': 'TsuServerInfo' } " { 'for': 'typescript' }
Plug 'kchmck/vim-coffee-script'                          , { 'for': 'coffee' }
Plug 'plasticboy/vim-markdown'                           , { 'for': 'markdown' }
Plug 'tpope/vim-haml'                                    , { 'for': ['sass', 'scss', 'haml'] }
Plug 'hail2u/vim-css3-syntax'                            , { 'for': ['css', 'sass', 'scss', 'less'] }
Plug 'groenewege/vim-less'                               , { 'for': 'less' }
Plug 'digitaltoad/vim-pug'                               , { 'for': ['jade', 'pug'] }
Plug 'valloric/MatchTagAlways'                           , { 'for': 'html' }
Plug 'othree/html5.vim'                                  , { 'for': 'html' }
Plug 'othree/html5-syntax.vim'                           , { 'for': 'html' }
Plug 'tpope/vim-liquid'                                  , { 'for': 'html' }
Plug 'rstacruz/sparkup'                                  , { 'for': 'html', 'rtp': 'vim'}
Plug 'kelan/gyp.vim'                                     , { 'for': 'gyp' }
Plug 'rust-lang/rust.vim'                                , { 'for': 'rust' }
Plug 'cespare/vim-toml'                                  , { 'for': 'toml' }
Plug 'elixir-lang/vim-elixir'                            , { 'for': 'elixir' }
Plug 'dzeban/vim-log-syntax'                             , { 'for': 'log' }

if exists('$VIFM')
    set runtimepath+=/usr/share/vifm/vim-doc
end

" }}}
" UI                                                                         {{{
" Plug 'TaDaa/vimade'
" Plug 'wellle/context.vim'   " mappings disabled
Plug 'junegunn/goyo.vim'
Plug 'rhysd/git-messenger.vim'
Plug 'KabbAmine/vCoolor.vim'
Plug 'Yggdroot/hiPairs'                                  , {'on': [ 'HiPairsEnable', 'HiPairsToggle' ] }
Plug 'Yggdroot/indentLine'
Plug 'machakann/vim-highlightedyank'
Plug 'guns/xterm-color-table.vim'                        , {'on': 'XtermColorTable'}
Plug 'RRethy/vim-hexokinase'                             , { 'do': 'make hexokinase' }
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
" }}}
" Local (~/github/vim)                                                       {{{
Plug 'romgrk/equal.operator'
Plug 'romgrk/columnMove.vim'
Plug 'romgrk/lib.kom'
Plug 'romgrk/pp.vim'
Plug 'romgrk/replace.vim'
Plug 'romgrk/vim-exeline'
Plug 'romgrk/winteract.vim'                              , {'on': 'InteractiveWindow'}
Plug 'romgrk/searchReplace.vim'
Plug 'romgrk/todoist.nvim'                               , {'do': ':TodoistInstall'}
Plug 'romgrk/github-light.vim'
" }}}

call plug#end() " }}}
"=============================================================================
" RC files                                                                 {{{

" Scripts:
call s:source_rc('function.vim')
call s:source_rc('events.vim')
call s:source_rc('autocmd.vim')
call s:source_rc('commands.vim')
call s:source_rc('colors.vim')
call s:source_rc('highlight.vim')
call s:source_rc('keymap.vim')
call s:source_rc('abbrev.vim')

" Plugin settings (after loading):
doautocmd User PluginsLoaded

" Local settings:
if filereadable($vim . '/local.vim')
    exe 'source ' . $vim . '/local.vim'
end

if argc() == 2 && argv(0) == 's'
    exe 'au VimEnter * OpenSession! ' . argv(1)
    call ClearArgs()
end

augroup RC_SETUP
au!
au VimEnter * colorscheme github-light
au VimEnter * call s:source_rc('colors.vim')
au VimEnter * call s:source_rc('highlight.vim')
augroup END

" }}}
"=============================================================================
" end-of-RC
