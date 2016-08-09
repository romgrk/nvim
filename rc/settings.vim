" File: settings.vim
" Author: romgrk
" Description: vim settings
" Date: 15 Oct 2015
" !::exe [So]
"
" TODO errorformat for ts

"===============================================================================
" Initial setup {{{
if has('vim_starting')

" Has to be set first and once
set encoding=utf8

if exists('&termguicolors')
set termguicolors
end

filetype on
filetype plugin on
filetype indent on

end "}}}
"===============================================================================
" General behavior {{{

set timeout
set timeoutlen=1000

" set textwidth=80
set whichwrap=b,s,<,>,[,]
set backspace=indent,eol,start
set virtualedit=onemore,block

set modeline
set modelines=3

set hidden switchbuf=useopen

" System clipboard
set clipboard=unnamedplus
"set clipboard=autoselect



" }}}
"===============================================================================
" Paths, session files & backups {{{

set tags=./.tags,.tags
"set sessionoptions-=help

set wildignore=node_modules,bower_components
set wildignorecase " aka wic


set history=500
set undolevels=500

set directory=$HOME/tmp

set cdpath=.,,
set cdpath+=$HOME
set cdpath+=$HOME/github
set cdpath+=$HOME/projects

set undofile
set undodir=$XDG_CACHE_HOME/vim_undo
set viewdir=$XDG_CACHE_HOME/vim_views

" IO & backups behavior
set noswapfile
set nobackup

set writeany
set writebackup

set autoread
set autowrite
set autowriteall

"}}}
"===============================================================================
" Search {{{

set hlsearch  incsearch
set smartcase ignorecase
set infercase
set gdefault

"}}}
"===============================================================================
" UI {{{

set cursorline

set  laststatus=2
set showtabline=2 " TODO set according to editor-mode (single vs multiEdit)

set number numberwidth=4
set colorcolumn=


set noshowcmd noshowmatch noshowmode
set novisualbell noerrorbells

set lazyredraw
set shortmess=aostWAc " set terse

" Mouse
set mouse=ah mousemodel=popup
set selectmode=mouse

" Scroll-aside
set scrolloff=2
set sidescroll=1
set sidescrolloff=5

" }}}
"===============================================================================
" Display, Special characters & Concealing {{{

" Wrapping {{{
set wrapmargin=0
set nowrap

set linebreak
set showbreak=…\                " NonText

" }}}

set list listchars=
"set lcs+=conceal:
set lcs+=eol:¬                 " EOL character
set lcs+=tab:\  "\              " Tab character replacement
set lcs+=nbsp:―,trail:·         " hl group: SpecialKey
set lcs+=precedes:,extends:   " Horizontal ellipsis

set fillchars=
set fcs+=vert:│                 " ▎VertSplit
"set fcs+=stl:\ ,stlnc:-        " StatusLine & StatusLineNC
"set fcs+=fold:-                " Folded
set fcs+=diff:\                 " DiffDelete

let chars = { }
let chars['indent']  = '│'
let chars['leading'] = '·'

set concealcursor=nc conceallevel=1

"}}}
"===============================================================================
" Windows {{{

set                    cmdheight=2
set winminwidth=0   winminheight=0
set    winwidth=1      winheight=1
set                previewheight=5

set nosplitbelow splitright
set noequalalways

" }}}
"===============================================================================
" Completion {{{

set showfulltag

set completeopt=menu,menuone
set completeopt+=longest,noselect
set completeopt+=preview

set wildmenu
set wildmode=longest:full,list:full
set wildoptions=tagfile

" }}}
"===============================================================================
" Indentation & <Tab>s {{{

set     tabstop=4
set softtabstop=4
set  shiftwidth=4

set expandtab  smarttab

set autoindent smartindent
"set copyindent

set shiftround

"}}}
"===============================================================================
" Folding rules {{{

set foldenable
set foldcolumn=0
set foldminlines=0
set foldlevelstart=99
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
set foldmethod=marker foldmarker={{{,}}}
set foldtext=FoldText()

" }}}
"===============================================================================
" Views options {{{

set viewoptions=         " Ensure no other options are set
set viewoptions+=cursor  " Cursor position in file
set viewoptions+=folds   " All local fold options (ie. opened/closed/manual folds)
set viewoptions+=slash   " Backslashes in filenames are replaced with foward slashes
set viewoptions+=unix    " Use Unix EOL

" }}}
"===============================================================================
" vim: fdm=marker
