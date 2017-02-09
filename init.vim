" File: init.vim
" Author: romgrk
" Description: neovim init file

"=============================================================================
" Vim setup                                                                {{{

set path=,,./*;,**2;,/usr/include

let $vimrc  = $MYVIMRC
let $vim    = fnamemodify($vimrc, ':h')
let $bundle = $vim . '/bundle'
let $rc     = $vim . '/rc'

" Load one file from ./rc/
function! s:source_rc(file)
    execute 'source ' . fnameescape($vim . '/rc/' . a:file)
endfu

" Load all files from ./rc/plugins/
function! s:source_plugins()
    for file in split(glob($vim . '/rc/plugins/*'), "\n")
        exe 'source ' . file
    endfor
endfunc

" Neovim setup
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let $NVIM_LISTEN_ADDRESS='127.0.0.1:6666'

" }}}
"=============================================================================
" Settings                                                                 {{{

call s:source_rc('settings.vim')
call s:source_rc('plugins.vim')
"                                                                          }}}
"=============================================================================
" Plugins                                                                  {{{
call plug#begin($vim . '/bundle')


" WATCHME
" Plug 'tpope/vim-projectionist'

" Essential                                                                  {{{
Plug 'neomake/neomake'
Plug 'sirver/UltiSnips'
Plug 'Valloric/YouCompleteMe'                   "        , {'on': 'YcmCompleter'}
"Plug 'scrooloose/syntastic'                             , {'on': 'SyntasticCheck'}
" }}}
" Editing                                                                    {{{
Plug 'wellle/targets.vim'
"Plug 'vim-scripts/argwrap.vim'
Plug 'coderifous/textobj-word-column.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'bkad/CamelCaseMotion'
Plug 'justinmk/vim-sneak'
Plug 'kana/vim-niceblock'
Plug 'michaeljsmith/vim-indent-object'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
"Plug 'tpope/vim-endwise'                                 , {'for': 'vim'}
"Plug 'Townk/vim-autoclose'
"Plug 'Raimondi/delimitMate'
"Plug 'cohama/lexima.vim'
"Plug 'easymotion/vim-easymotion'
" }}}
" General                                                                    {{{
" @plugins
Plug 'bfredl/nvim-miniyank'
Plug 'justinmk/vim-syntax-extra'
Plug 'honza/vim-snippets'
Plug 'aperezdc/vim-template'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'MarcWeber/vim-addon-local-vimrc'
Plug 'haya14busa/incsearch.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf'                                      , {'dir': '~/.local/fzf'}
Plug 'junegunn/fzf.vim'
Plug 'Konfekt/FastFold'
"Plug 'majutsushi/tagbar'                       "         , {'on': ['Tagbar', 'TagbarToggle'] }
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'
"Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-session'
"Plug 'KabbAmine/zeavim.vim'                              , {'on': ['Zeavim', 'ZHelp']}
"Plug 'cohama/agit.vim'                                   , {'on': 'Agit'}
"Plug 'jreybert/vimagit'                                  , {'on': 'Magit'}
" }}}
" Language                                                                   {{{
Plug 'othree/xml.vim'
"Plug 'tpope/vim-jdaddy'
"Plug 'Quramy/vison'                                    , { 'for': 'json', 'on': 'Vison' }
"Plug 'moll/vim-node'                                   , { 'for': 'javascript' }
"Plug 'othree/javascript-libraries-syntax.vim'            , { 'for': 'javascript' }
"Plug 'othree/yajs.vim'                                   , { 'for': 'javascript' }
Plug 'pangloss/vim-javascript'                           , { 'for': 'javascript', 'branch': 'develop' }
"Plug 'jelera/vim-javascript-syntax'                      , { 'for': 'javascript' }
"Plug 'bigfish/vim-js-context-coloring'                   , { 'for': 'javascript' }
Plug 'leafgarland/typescript-vim'                        , { 'for': 'typescript' }
Plug 'mxw/vim-jsx'                                       , { 'on': 'JSX', 'for': 'javascript.jsx' }
Plug 'ianks/vim-tsx'                                     , { 'for': 'typescript.tsx' }
Plug 'Quramy/tsuquyomi'                                  , { 'on': 'TsuServerInfo' } " { 'for': 'typescript' }
"Plug 'HerringtonDarkholme/yats.vim'                    , { 'for': 'typescript' }
Plug 'kchmck/vim-coffee-script'                          , { 'for': 'coffee' }
Plug 'plasticboy/vim-markdown'                           , { 'for': 'markdown' }
Plug 'tpope/vim-haml'                                    , { 'for': ['sass', 'scss', 'haml'] }
Plug 'hail2u/vim-css3-syntax'                 "          , { 'for': 'sass' }
Plug 'groenewege/vim-less'                               , { 'for': 'less' }
Plug 'digitaltoad/vim-pug'                               , { 'for': ['jade', 'pug'] }
Plug 'othree/html5.vim'                                  , { 'for': 'html' }
Plug 'othree/html5-syntax.vim'                           , { 'for': 'html' }
Plug 'tpope/vim-liquid'                                  , { 'for': 'html' }
Plug 'rstacruz/sparkup'                                  , { 'for': 'html', 'rtp': 'vim'}
Plug 'mattn/emmet-vim'                                   , { 'for': ['html', 'css', 'less', 'sass', 'scss'] }
Plug 'mattn/webapi-vim'                                  , { 'for': ['html', 'css', 'less', 'sass', 'scss'] }
"Plug 'leafo/moonscript-vim'                              , { 'for': 'moonscript' }
"Plug 'lukerandall/haskellmode-vim'                       , { 'for': 'haskell' }
"Plug 'eagletmt/neco-ghc'                                 , { 'for': 'haskell' }
"Plug 'eagletmt/ghcmod-vim'                               , { 'for': 'haskell' }
"Plug 'kelan/gyp.vim'                                     , { 'for': 'gyp' }
Plug 'rust-lang/rust.vim'                                , { 'for': 'rust' }
Plug 'cespare/vim-toml'                                  , { 'for': 'toml' }
Plug 'dzeban/vim-log-syntax'

if exists('$VIFM')
    set runtimepath+=/usr/share/vifm/vim-doc
end

" }}}
" UI                                                                         {{{
Plug 'scrooloose/nerdtree'
"Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'kshenoy/vim-signature'                             , {'on': 'SignatureToggleSigns'}
Plug 'nathanaelkane/vim-indent-guides'                   , {'on': 'IndentGuidesToggle'}
Plug 'Yggdroot/hiPairs'                                  , {'on': [ 'HiPairsEnable', 'HiPairsToggle' ] }
"Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'                           , {'on': 'AirlineToggle' }
Plug 'vim-airline/vim-airline-themes'                    , {'on': 'AirlineToggle' }
" }}}
" Colors/Colorscheme                                                         {{{
Plug 'guns/xterm-color-table.vim'                        , {'on': 'XtermColorTable'}
Plug 'lilydjwg/colorizer'
Plug 'flazz/vim-colorschemes'
Plug 'adelarsq/vim-grimmjow'
Plug 'airblade/vim-gitgutter'
" }}}
" Local (~/github/vim)                                                       {{{
Plug '~/github/vim/equal-op'
Plug '~/github/vim/columnMove.vim'
Plug '~/github/vim/lib.kom'
Plug '~/github/vim/pp.vim'
Plug '~/github/vim/replace.vim'
Plug '~/github/vim/vim-exeline'
Plug '~/github/vim/winteract.vim'                        , {'on': 'InteractiveWindow'}
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

" Settings (after plugins):
call s:source_plugins()

" Local settings:
if filereadable($vim . '/local.vim')
    exe 'source ' . $vim . '/local.vim'
end

if argc() == 2 && argv(0) == 's'
    exe 'au VimEnter * OpenSession! ' . argv(1)
    argdel *
end

augroup RC_SETUP
au!
au VimEnter * colorscheme darker
au VimEnter * call s:source_rc('colors.vim')
au VimEnter * call s:source_rc('highlight.vim')
augroup END

" }}}
"=============================================================================
" end-of-RC
