" File: init.vim
" Author: romgrk
" Description: neovim init file

" FIXME lightline [/home/romgrk/.config/nvim/rc/colors.vim:233]
" FIXME setup git env (see ./rc/git.vim)
" TODO  check: Plug 'tomtom/tinykeymap_vim'

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
fu! s:plugin_setup () abort
    let plugin_files = split(glob($vim . '/rc/plugins/*'), "\n")
    for file in plugin_files
        exe 'source ' . file
    endfor
endfu " }}}
" Neovim setup                                                               {{{

let $NVIM_RUNNING='true'
"let $NVIM_LISTEN_ADDRESS='127.0.0.1:6666'
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

"                                                                            }}}
"=============================================================================
" Settings                                                                   {{{

call s:source_rc('settings.vim')
call s:source_rc('plugins.vim')

"                                                                            }}}
"=============================================================================
" Plugins                                                                    {{{
call plug#begin($vim . '/bundle')

Plug 'Valloric/YouCompleteMe'
"Plug 'scrooloose/syntastic'  " , {'on': 'SyntasticCheck'}
"Plug 'benekastah/neomake'    " , {'on': '' }
"Plug 'Shougo/deoplete.nvim'  " , {on': 'DeopleteEnable',}

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
"let space_debug = 1
Plug 'spiiph/vim-space'
"                                                                            }}}
" General                                                                    {{{

" @plugins
Plug 'flazz/vim-colorschemes'
Plug 'kelan/gyp.vim'
Plug 'tpope/vim-eunuch'
Plug 'justinmk/vim-syntax-extra'
Plug 'KabbAmine/zeavim.vim'
Plug 'justinmk/vim-dirvish'
"Plug 'tpope/vim-rsi'
Plug 'honza/vim-snippets'
Plug 'aperezdc/vim-template'
"Plug 'mhinz/vim-startify'
"Plug 'jreybert/vimagit'                       , {'on': 'Magit'}
Plug 'sirver/UltiSnips'
Plug 'ctrlpvim/ctrlp.vim'               " , {'on': 'CtrlP'}
Plug 'tacahiroy/ctrlp-funky'
"Plug 'google/vim-maktaba'
Plug 'iago-lito/vim-visualMarks'
Plug 'MarcWeber/vim-addon-local-vimrc'
Plug 'haya14busa/incsearch.vim'
Plug 'junegunn/vim-easy-align'
"Plug 'junegunn/fzf',                        {'dir': '~/.local/fzf'} " , 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'   ,                {'on': ['Tagbar', 'TagbarToggle'] }
"Plug 'mileszs/ack.vim'     ,                {'on': 'Ack' }
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/unite.vim'            ",       {'on': 'Unite'}
Plug 'Shougo/vimfiler.vim'         ,       {'on': 'VimFiler'}
Plug 'Shougo/vimproc.vim'
Plug 'tsukkee/unite-tag'
Plug 'vim-scripts/AutoFold.vim'
"Plug 'vim-scripts/YankRing.vim'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'  " ,                 { 'on': 'Note' }
Plug 'xolox/vim-session' "                                                   }}}
" Language                                                                   {{{
Plug 'Quramy/vison'                             , { 'for': 'json', 'on': 'Vison' }
"Plug 'Shutnik/jshint2.vim'                      , { 'for': 'javascript' }
Plug 'othree/yajs.vim'                          , { 'for': 'javascript' }
"Plug 'ternjs/tern_for_vim'                      , { 'for': 'javascript' }
Plug 'kchmck/vim-coffee-script'               " , { 'for': 'coffee' }
Plug 'leafgarland/typescript-vim'              , { 'for': 'typescript' }
"Plug 'Quramy/tsuquyomi'                         , { 'for': 'typescript' }
Plug 'ianks/vim-tsx'                            , { 'for': 'typescript' }
Plug 'plasticboy/vim-markdown'                  , { 'for': 'markdown' }
Plug 'tpope/vim-haml'                           , { 'for': ['sass', 'haml'] }
Plug 'hail2u/vim-css3-syntax'                 " , { 'for': 'sass' }
"Plug 'mattn/livestyle-vim'                      , { 'for': ['less', 'sass', 'scss'] }
Plug 'groenewege/vim-less'                      , { 'for': 'less' }
Plug 'digitaltoad/vim-pug'                      , { 'for': 'jade' }
Plug 'tpope/vim-liquid'                         , { 'for': 'html' }
Plug 'rstacruz/sparkup'                         , { 'for': 'html', 'rtp': 'vim'}
Plug 'mattn/emmet-vim'                          , { 'for': ['html', 'css', 'less', 'sass', 'scss'] }
"Plug 'mattn/webapi-vim'                         , { 'for': ['html', 'css', 'less', 'sass', 'scss'] }
Plug 'leafo/moonscript-vim'                     , { 'for': 'moonscript' }
Plug 'lukerandall/haskellmode-vim'              , { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc'                        , { 'for': 'haskell' }
Plug 'eagletmt/ghcmod-vim'                      , { 'for': 'haskell' }
"Plug 'sdiehl/haskell-vim-proto'                 , { 'for': 'haskell', 'rtp': 'vim' }
Plug 'octol/vim-cpp-enhanced-highlight'         , { 'for': 'cpp' } "         }}}

" Colors/Colorscheme/UI                                                      {{{
"Plug 'godlygeek/csapprox'
"Plug 'Yggdroot/hiPairs'
Plug 'lilydjwg/colorizer'
Plug 'inside/vim-search-pulse'
"Plug 'kshenoy/vim-signature'
Plug 'guns/xterm-color-table.vim',        {'on': 'XtermColorTable'}
Plug 'airblade/vim-gitgutter' ",          {'on': 'LightLineEnable'}
Plug 'ryanoasis/vim-devicons' ",          {'on': 'LightLineEnable'}
Plug 'itchyny/lightline.vim'  ",          {'on': 'LightLineEnable'}
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

call plug#end()

"                                                                            }}}
"=============================================================================
" RC files                                                                   {{{

colorscheme darker

" Colorscheme + UI elements FIXME watch
"call s:source_rc('colors.vim')
call s:source_rc('function.vim')
call s:source_rc('commands.vim')
call s:source_rc('autocmd.vim')
call s:source_rc('highlight.vim')
call s:source_rc('keymap.vim')
"call s:source_rc('session.vim')

" Settings (after plugins) - loads all files in $vim/rc/plugins/
"call s:plugin_setup()
call s:source_rc('plugins/ctrlp.vim')
"call s:source_rc('plugins/deoplete.vim')
call s:source_rc('plugins/dirvish.vim')
call s:source_rc('plugins/easyalign.vim')
"call s:source_rc('plugins/emmet.vim')
call s:source_rc('plugins/gitgutter.vim')
"call s:source_rc('plugins/hiPairs.vim')
call s:source_rc('plugins/lightline.vim')
call s:source_rc('plugins/multiple-cursors.vim')
"call s:source_rc('plugins/neomake.vim')
call s:source_rc('plugins/notes.vim')
call s:source_rc('plugins/space.vim')
call s:source_rc('plugins/syntastic.vim')
call s:source_rc('plugins/tern.vim')
call s:source_rc('plugins/unite.vim')
call s:source_rc('plugins/vimfiler.vim')
call s:source_rc('plugins/ycm.vim')
call s:source_rc('plugins/zeavim.vim')

"au VimEnter * call s:source_rc('colors.vim')
au VimEnter * call s:source_rc('highlight.vim')

syntax enable

" }}}
"=============================================================================
" end-of-RC
