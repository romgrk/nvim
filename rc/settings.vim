" File: settings.vim
" Author: romgrk
" Description: vim settings
" Date: 15 Oct 2015
" !::exe [so %]

if has('vim_starting')
    set encoding=utf8

    filetype on
    filetype plugin on
    filetype indent on
    syntax enable
    "syntax on
end

set timeout
set timeoutlen=1000

set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]
set virtualedit=onemore,block

set tags=./.tags
set cpoptions+=d " tag file is relative to CWD
"set sessionoptions-=help
set clipboard+=unnamedplus
set history=500

" Backups & writes

set hidden
set nobackup
set noswapfile
set writebackup
set switchbuf=usetab,newtab

set writeany

" UI

set title
set numberwidth=4 number
set  laststatus=2
set showtabline=2 " TODO set according to editor-mode (single vs multiEdit)

set                    cmdheight=2
set    winwidth=1      winheight=1
set winminwidth=0   winminheight=0
set                previewheight=5

set splitbelow splitright

set wildmode=longest,full
set wildmenu

set list
set listchars=tab:»\ ,trail:―,nbsp:.
set fillchars=vert:▎    " fillchars=vert:
set showbreak=…\        showbreak=>\    "

set conceallevel=0
set concealcursor=i

set noshowcmd
set noshowmatch
set noshowmode

set lazyredraw

set shortmess=aostwAc
set novisualbell noerrorbells
set mousemodel=popup

" Search

set   smartcase ignorecase
set   incsearch   hlsearch

" Indentation, folds, wrap

set     tabstop=4
set softtabstop=4
set  shiftwidth=4
set expandtab smarttab

set autoindent
set smartindent
set shiftround

set scrolloff=3

set foldenable
set foldopen=block,hor,insert,mark,percent,quickfix,search,tag,undo,jump
"set foldlevel=0
"set foldcolumn=0
set foldminlines=0
"set foldmethod=expr
"set foldlevelstart=2
"set foldexpr=SF_SetFolds()
"set foldtext=SFT_SetFoldText()

set nowrap wrapmargin=0
set textwidth=80

set modeline modelines=3
