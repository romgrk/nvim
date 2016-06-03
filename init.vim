" File: init.vim
" Author: romgrk
" Description: neovim init file

" TODO  check: Plug 'tomtom/tinykeymap_vim'
" FIXME errorformat option

"=============================================================================
" Vim setup                                                                  {{{

set        path=,,./*;,**2;,/usr/include
set runtimepath+=~/.local/fzf
"set runtimepath+=~/github/coffeelib

let $vimrc  = $MYVIMRC
let $vim    = fnamemodify($vimrc, ':h')
let $bundle = $vim . '/bundle'
let $rc     = $vim . '/rc'

fu! s:source_rc (file)
    exe "source " . fnameescape($vim . '/rc/' . a:file)
endfu
fu! s:source_config () abort
    let plugin_files = split(glob($vim . '/rc/plugins/*'), "\n")
    for file in plugin_files
        exe 'source ' . file
    endfor
endfu "                                                                      }}}
" Neovim setup                                                               {{{

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let $NVIM_LISTEN_ADDRESS='127.0.0.1:6666'

"                                                                            }}}
"=============================================================================
" Settings                                                                   {{{

call s:source_rc('settings.vim')
call s:source_rc('plugins.vim')

"                                                                            }}}
"=============================================================================
" Plugins                                                                    {{{
call plug#begin($vim . '/bundle')

Plug 'Valloric/YouCompleteMe'           , {'on': 'YcmCompleter'}
Plug 'scrooloose/syntastic'             , {'on': 'SyntasticCheck'}

" Editing                                                                    {{{
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Raimondi/delimitMate'
Plug 'bkad/CamelCaseMotion'
Plug 'easymotion/vim-easymotion'
Plug 'justinmk/vim-sneak'
Plug 'kana/vim-niceblock'
Plug 'michaeljsmith/vim-indent-object'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-endwise',                       {'for': 'vim'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
" Plug 'spiiph/vim-space' " linked in $vim/plugin
"                                                                            }}}
" General                                                                    {{{

" @plugins
Plug 'justinmk/vim-dirvish'
Plug 'sjl/gundo.vim'
Plug 'Valloric/ListToggle'
Plug 'tpope/vim-eunuch'
Plug 'justinmk/vim-syntax-extra'
Plug 'KabbAmine/zeavim.vim'                    , {'on': ['Zeavim', 'ZHelp']}
Plug 'honza/vim-snippets'
Plug 'aperezdc/vim-template'
Plug 'jreybert/vimagit'                        , {'on': 'Magit'}
Plug 'sirver/UltiSnips'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'iago-lito/vim-visualMarks'
Plug 'MarcWeber/vim-addon-local-vimrc'
Plug 'haya14busa/incsearch.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf',                        {'dir': '~/.local/fzf'}
Plug 'junegunn/fzf.vim'
Plug 'Konfekt/FastFold'
Plug 'majutsushi/tagbar'   ,                {'on': ['Tagbar', 'TagbarToggle'] }
Plug 'mileszs/ack.vim'
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'         ,       {'on': 'VimFiler'}
Plug 'Shougo/vimproc.vim'
Plug 'tsukkee/unite-tag'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-session' "                                                   }}}
" Language                                                                   {{{
Plug 'Quramy/vison'                             , { 'for': 'json', 'on': 'Vison' }
" Plug 'ahayman/vim-nodejs-complete'              , { 'for': 'javascript' }
" Plug 'moll/vim-node'                            , { 'for': 'javascript' }
Plug 'pangloss/vim-javascript'                  , { 'for': 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim'   , { 'for': 'javascript' }
Plug 'Quramy/tsuquyomi'                         , { 'on': 'TsuEnable' } ", { 'for': 'typescript' }
Plug 'HerringtonDarkholme/yats.vim'             , { 'for': 'typescript' }
" Plug 'leafgarland/typescript-vim'               , { 'for': 'typescript' }
Plug 'ianks/vim-tsx'                            , { 'for': 'typescript.tsx' }
Plug 'kchmck/vim-coffee-script'                 , { 'for': 'coffee' }
Plug 'plasticboy/vim-markdown'                  , { 'for': 'markdown' }
Plug 'tpope/vim-haml'                           , { 'for': ['sass', 'scss', 'haml'] }
Plug 'hail2u/vim-css3-syntax'                 " , { 'for': 'sass' }
Plug 'groenewege/vim-less'                      , { 'for': 'less' }
Plug 'digitaltoad/vim-pug'                      , { 'for': 'jade' }
Plug 'othree/html5.vim'                         , { 'for': 'html' }
Plug 'othree/html5-syntax.vim'                  , { 'for': 'html' }
Plug 'tpope/vim-liquid'                         , { 'for': 'html' }
Plug 'rstacruz/sparkup'                         , { 'for': 'html', 'rtp': 'vim'}
Plug 'mattn/emmet-vim'                          , { 'for': ['html', 'css', 'less', 'sass', 'scss'] }
Plug 'mattn/webapi-vim'                         , { 'for': ['html', 'css', 'less', 'sass', 'scss'] }
Plug 'leafo/moonscript-vim'                     , { 'for': 'moonscript' }
Plug 'lukerandall/haskellmode-vim'              , { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc'                        , { 'for': 'haskell' }
Plug 'eagletmt/ghcmod-vim'                      , { 'for': 'haskell' }
Plug 'kelan/gyp.vim'                            , { 'for': 'gyp' }
Plug 'octol/vim-cpp-enhanced-highlight'         , { 'on':  'CppHL' }
"Plug 'https://bitbucket.org/JohnKaul/cpp-devel-vim.git' , { 'for': 'cpp' }
Plug 'rust-lang/rust.vim'                       , { 'for': 'rust' }
Plug 'cespare/vim-toml'                         , { 'for': 'toml' }

if exists('$VIFM')
    set runtimepath+=/usr/share/vifm/vim-doc
end

" }}}
" Colors/Colorscheme/UI                                                      {{{
Plug 'AlessandroYorba/Sierra'
Plug 'lilydjwg/colorizer'
Plug 'flazz/vim-colorschemes'
Plug 'adelarsq/vim-grimmjow'
Plug 'guns/xterm-color-table.vim',        {'on': 'XtermColorTable'}
Plug 'airblade/vim-gitgutter' ",          {'on': 'LightLineEnable'}
Plug 'ryanoasis/vim-devicons' ",          {'on': 'LightLineEnable'}
Plug 'itchyny/lightline.vim'  ",          {'on': 'LightLineEnable'}
Plug 'Yggdroot/hiPairs',                  {'on': 'HiPairsEnable'}
"Plug 'kshenoy/vim-signature',            {'on': 'SignatureToggleSigns'}
"Plug 'ap/vim-buftabline'
"Plug 'godlygeek/csapprox'
"Plug 'inside/vim-search-pulse'
" }}}
" Local (~/github/vim)                                                       {{{
Plug '~/github/vim/equal-op'
Plug '~/github/vim/lib.kom'
Plug '~/github/vim/pp.vim'
Plug '~/github/vim/replace.vim'
Plug '~/github/vim/vim-exeline'
Plug '~/github/vim/vimfiler-prompt'     , {'on': 'VimFiler'}
Plug '~/github/vim/winteract.vim'
" }}}
" Unused                                                                     {{{
"Plug 'scrooloose/nerdtree'
" }}}
" Nyaovim plugins {{{
if exists('g:nyaovim_version')
Plug 'rhysd/nyaovim-popup-tooltip'
"Plug 'rhysd/nyaovim-mini-browser'
end
" }}}

call plug#end()
"                                                                            }}}
"=============================================================================
" RC files                                                                   {{{

" Colorscheme + UI elements FIXME watch
call s:source_rc('function.vim')
call s:source_rc('commands.vim')
call s:source_rc('autocmd.vim')
call s:source_rc('colors.vim')
call s:source_rc('highlight.vim')
call s:source_rc('keymap.vim')
"call s:source_rc('session.vim')

" Settings (after plugins) - loads all files in $vim/rc/plugins/
" call s:source_rc('plugins/ctrlp.vim')
" call s:source_rc('plugins/commenter.vim')
" "call s:source_rc('plugins/deoplete.vim')
" call s:source_rc('plugins/dirvish.vim')
" call s:source_rc('plugins/easyalign.vim')
" "call s:source_rc('plugins/emmet.vim')
" call s:source_rc('plugins/gitgutter.vim')
" call s:source_rc('plugins/hiPairs.vim')
" call s:source_rc('plugins/lightline.vim')
" call s:source_rc('plugins/multiple-cursors.vim')
" "call s:source_rc('plugins/neomake.vim')
" call s:source_rc('plugins/notes.vim')
" call s:source_rc('plugins/space.vim')
" "call s:source_rc('plugins/syntastic.vim')
" "call s:source_rc('plugins/tern.vim')
" call s:source_rc('plugins/unite.vim')
" call s:source_rc('plugins/vimfiler.vim')
" call s:source_rc('plugins/ycm.vim')
" call s:source_rc('plugins/zeavim.vim')
call s:source_config()

au VimEnter * call s:source_rc('colors.vim')
au VimEnter * call s:source_rc('highlight.vim')
au VimEnter * if !exists('g:colors_name') | colorscheme darker | end

" }}}
"=============================================================================
" end-of-RC
