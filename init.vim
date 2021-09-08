" File: init.vim
" Author: romgrk
" Description: neovim init file

" TODO https://github.com/rockerBOO/awesome-neovim#comment
" TODO instal Plug 'neomake/neomake'
" TODO install https://github.com/abecodes/tabout.nvim
" TODO install https://github.com/pwntester/octo.nvim when working
" TODO install https://github.com/tanvirtin/vgit.nvim
" TODO install https://github.com/kevinhwang91/nvim-bqf
" TODO install https://github.com/stevearc/qf_helper.nvim
" TODO install https://github.com/ms-jpq/chadtree
" TODO install https://github.com/machakann/vim-sandwich
" TODO install https://github.com/rhysd/vim-operator-surround
" TODO install https://github.com/fannheyward/coc-react-refactor
" TODO install https://github.com/nvim-treesitter/nvim-treesitter-refactor
" TODO install https://github.com/nvim-treesitter/nvim-treesitter-textobjects
" TODO install https://github.com/JoosepAlviste/nvim-ts-context-commentstring
" TODO install https://github.com/phaazon/hop.nvim
" TODO install https://github.com/folke/todo-comments.nvim
" TODO install https://github.com/folke/twilight.nvim
" TODO inline comments when available (eg javascript)

"=============================================================================
" Vim setup                                                                {{{

let $vim = stdpath('config')

" Source file
function! s:load(file)
    let file = a:file[0] == '/' ? a:file : path#Join([$vim, a:file])
    execute (a:file =~# '.lua$' ? 'luafile' : 'source') fnameescape(file)
endfu

" }}}
"=============================================================================
" Settings                                                                 {{{

call s:load('./rc/settings.vim')
call s:load('./rc/plugins.vim')

" Plugin settings (before loading):
for file in split(glob($vim . '/rc/plugins/*'), '\n')
    if file !~ '.after.'
        call s:load(file)
    end
endfor

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
" XXX use lightspeed asap
" Plug 'ggandor/lightspeed.nvim'
" Plug 'justinmk/vim-sneak'
Plug 'romgrk/vim-sneak'
Plug 'kana/vim-niceblock'
Plug 'Konfekt/vim-ctrlxa'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neoclide/coc.nvim', { 'do': 'yarn install' }
" Plug 'neoclide/coc-tabnine'
Plug 'scrooloose/nerdcommenter'
Plug 'sirver/UltiSnips'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'wellle/line-targets.vim'
Plug 'wellle/targets.vim'
" }}}
" General                                                                    {{{
" @plugins
Plug 'DanilaMihailov/beacon.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'code-biscuits/nvim-biscuits'
Plug 'dstein64/nvim-scrollview'
Plug 'vuki656/package-info.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'jbyuki/one-small-step-for-vimkind'
Plug 'jbyuki/venn.nvim'
Plug 'preservim/nerdtree'
Plug 'k0kubun/vim-open-github'
Plug 'ruanyl/vim-gh-line'
Plug 'akinsho/nvim-toggleterm.lua'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'wellle/visual-split.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'aperezdc/vim-template'
Plug 'bfredl/nvim-miniyank'
Plug 'fidian/hexmode'
Plug 'haya14busa/incsearch.vim'
Plug 'honza/vim-snippets'
Plug 'itchyny/vim-gitbranch'
Plug 'junegunn/vim-easy-align'
Plug 'liuchengxu/vim-clap'
Plug 'liuchengxu/vista.vim'
Plug 'MarcWeber/vim-addon-local-vimrc'
Plug 'neoclide/npm.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'
" Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'romgrk/nvim-treesitter-context'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'
Plug 'vim-scripts/loremipsum'
Plug 'vn-ki/coc-clap'
Plug 'wsdjeg/vim-fetch'
Plug 'wsdjeg/vim-todo'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-shell'
Plug 'romgrk/vim-session'
" }}}
" Language                                                                   {{{
Plug 'JuliaEditorSupport/julia-vim'                      , { 'for': 'julia' }
Plug 'AndrewRadev/tagalong.vim'
Plug 'neoclide/jsonc.vim'
Plug 'justinmk/vim-syntax-extra'
Plug 'thyrgle/vim-dyon'                                  , { 'for': 'dyon' }
Plug 'keith/swift.vim'                                   , { 'for': 'swift' }
Plug 'jordwalke/vim-reasonml'                            , { 'for': 'reason' }
Plug 'rhysd/vim-crystal'                                 , { 'for': 'crystal' }
Plug 'vim-python/python-syntax'                          , { 'for': 'python' }
Plug 'tmhedberg/SimpylFold'                              , { 'for': 'python' }
Plug 'othree/xml.vim'
Plug 'pangloss/vim-javascript'                           , { 'for': 'javascript' }
Plug 'kristijanhusak/vim-js-file-import'                 , { 'for': 'javascript' }
Plug 'neoclide/vim-jsx-improve'                          , { 'for': 'javascript.jsx' }
Plug 'moll/vim-node'                                     , { 'for': 'javascript.node' }
Plug 'leafgarland/typescript-vim'                        , { 'for': 'typescript' }
Plug 'ianks/vim-tsx'                                     , { 'for': 'typescript.tsx' }
Plug 'kchmck/vim-coffee-script'                          , { 'for': 'coffee' }
Plug 'plasticboy/vim-markdown'                           , { 'for': 'markdown' }
Plug 'iamcco/markdown-preview.nvim'                      , { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
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
Plug 'ionide/Ionide-vim'                                 , { 'for': 'fsharp' }

" }}}
" UI                                                                         {{{
Plug 'junegunn/goyo.vim'
Plug 'rhysd/git-messenger.vim'
Plug 'KabbAmine/vCoolor.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'guns/xterm-color-table.vim'                        , {'on': 'XtermColorTable'}
Plug 'RRethy/vim-hexokinase'                             , { 'do': 'make hexokinase' }
Plug 'airblade/vim-gitgutter'
" }}}
" Personal                                                                   {{{
Plug 'romgrk/barbar.nvim'
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
Plug 'romgrk/doom-one.vim'
" }}}

packadd termdebug

call plug#end() " }}}
"=============================================================================
" RC files                                                                 {{{

" Scripts:
call s:load('./rc/function.vim')
call s:load('./rc/events.vim')
call s:load('./rc/autocmd.vim')
call s:load('./rc/commands.vim')
call s:load('./rc/colors.vim')
call s:load('./rc/abbrev.vim')

" Plugin settings (after loading):
" ...either use autocmd
doautocmd User PluginsLoaded
" ...or be named *.after.vim
for file in split(glob($vim . '/rc/plugins/*'), '\n')
    if file =~ '.after.'
        call s:load(file) | end
endfor

" Local settings:
if filereadable($vim . '/local.vim')
    call s:load('./local.vim')
end

augroup RC_SETUP
au!
au VimEnter * colorscheme doom-one
" au VimEnter * call s:load('./rc/colors.vim')
au VimEnter * call s:load('./rc/highlight.vim')
au VimEnter * call s:load('./rc/keymap.vim')
augroup END

" }}}
"=============================================================================
" end-of-RC
