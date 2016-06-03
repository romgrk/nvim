" File: settings.vim
" Author: romgrk
" Description: vim settings
" Date: 15 Oct 2015
" !::exe [so %]

if has('vim_starting') " {{{
    set encoding=utf8
    filetype on
    filetype plugin on
    filetype indent on
    "syntax enable
    set termguicolors
end "}}}

" TODO errorformat for ts

"===============================================================================
" General behavior {{{

set timeout
set timeoutlen=1000

set textwidth=80
set whichwrap=b,s,<,>,[,]
set backspace=indent,eol,start
set virtualedit=onemore,block

set modeline
set modelines=3

set hidden switchbuf=useopen

" System clipboard
set clipboard+=unnamedplus

" }}}
"===============================================================================
" Project & Session settings {{{

"set sessionoptions-=help
set tags=./.tags,.tags

" }}}
"===============================================================================
" Backups & writes {{{

set undofile
set undodir=$XDG_CACHE_HOME/nvim

set directory=$HOME/tmp

set history=500
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

set nohlsearch
set incsearch
set smartcase ignorecase

" IMPORTANT: 'g' flag is set by default; 'g' has inverse effect.
set gdefault

"}}}
"===============================================================================
" UI {{{

set title
set  laststatus=2
set showtabline=2 " TODO set according to editor-mode (single vs multiEdit)
set numberwidth=4 number
set colorcolumn=
set foldcolumn=0

set noshowcmd
set noshowmatch
set noshowmode
set novisualbell noerrorbells
set lazyredraw
set terse
"set shortmess=aostWAc

set completeopt=menu,menuone,preview


set showfulltag

" }}}
"===============================================================================
" Windows {{{

set                    cmdheight=2
set    winwidth=1      winheight=1
set winminwidth=0   winminheight=0
set                previewheight=5

set nosplitbelow splitright

set wildmenu
set wildmode=longest:full,list:full
set wildignorecase " aka wic
set wildoptions=tagfile

set list
set listchars=tab:▏\            " Tab character replacement
set lcs+=nbsp:―,trail:·         " hl group: SpecialKey
set lcs+=precedes:,extends:   " Horizontal ellipsis
" set lcs+=eol:¬                " EOL character
   "conceal:,

set fillchars=vert:▕            " ▎VertSplit
"set fcs+=stl:\ ,stlnc:-        " StatusLine & StatusLineNC
"set fcs+=fold:-,diff:-         " Folded & DiffDelete

set showbreak=…\                " NonText

set concealcursor=nc conceallevel=1



set mouse=ah mousemodel=popup_setpos
set selectmode=mouse

"}}}
"===============================================================================
" Indentation & <Tab>s {{{

set     tabstop=4
set softtabstop=4
set  shiftwidth=4
set expandtab smarttab
set autoindent
set smartindent
"set copyindent
set shiftround

"}}}
"===============================================================================
" Wrapping {{{

set nowrap
set wrapmargin=0
set linebreak

set scrolloff=2
set sidescroll=1
set sidescrolloff=5

" }}}
"===============================================================================
" Folding rules {{{

" set foldcolumn=0
set foldenable
set foldminlines=1
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
set foldmethod=marker           " detect triple-{ style fold markers
set foldmarker={{{,}}}
set foldtext=FoldText()

" }}}
"===============================================================================
" End of the file.
