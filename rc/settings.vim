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
set ttimeoutlen=8

" set textwidth=80
set whichwrap=b,s,<,>,[,]
set backspace=indent,eol,start
set virtualedit=onemore,block

set modeline
set modelines=3

set hidden switchbuf=useopen

" System clipboard
if has('win32')
  set clipboard=unnamedplus
else
  set clipboard=unnamedplus
end

set updatetime=300

set title
set titlestring=%(%{GetCurrentSession()}%)%(\ %a%)

" }}}
"===============================================================================
" Paths, session files & backups {{{

" set path=,,./*;,**2;,/usr/include

if exists('$VIFM')
  set runtimepath+=/usr/share/vifm/vim-doc
end

set wildignore=node_modules,bower_components,package-lock.json,tags,*.pyc,crates
set wildignorecase

set history=500
set undolevels=500

set cdpath=.,,
set cdpath+=$HOME
set cdpath+=$HOME/github
set cdpath+=$HOME/projects

set undofile
if !has('win32')
if !exists('$XDG_CACHE_HOME')
  let $XDG_CACHE_HOME = $HOME . '/.cache'
end
set undodir=$XDG_CACHE_HOME/vim_undo
set viewdir=$XDG_CACHE_HOME/vim_views
else
set undodir=$HOME/AppData/Local/nvim-data/undo
set viewdir=$HOME/AppData/Local/nvim-data/views
end

set sessionoptions-=folds

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

set inccommand=nosplit

"}}}
"===============================================================================
" UI {{{

set cursorline

set  laststatus=2
set showtabline=2

set number numberwidth=4
set colorcolumn=
set signcolumn=yes


set noshowcmd noshowmatch noshowmode
set novisualbell noerrorbells

set lazyredraw
set shortmess=aostWAc " set terse
if exists('&splitkeep')
set splitkeep=topline
end

" Mouse
set mouse=ah mousemodel=popup
"set selectmode=mouse

" Scroll-aside
set scrolloff=2
set sidescroll=1
set sidescrolloff=5

" GUI
" set guifont=SauceCodePro\ Nerd\ Font:h16
let &guifont='JetBrainsMono Nerd Font Mono:h11'
" let &guifont='FantasqueSansMono Nerd Font Mono:h10'

" }}}
"===============================================================================
" Display, Special characters & Concealing {{{

" Wrapping {{{
set wrapmargin=0
set nowrap

set linebreak
" set showbreak=…\                " NonText
set showbreak=                    " NonText
set breakindent

" }}}

set list listchars=
"set lcs+=conceal:
if has('win32')
  "set lcs+=eol:¬                 " EOL character
  set lcs+=tab:>\  "\              " Tab character replacement
else
  "set lcs+=eol:¬                 " EOL character
  set lcs+=tab:\  "\              " Tab character replacement
end
set lcs+=nbsp:―,trail:·         " hl group: SpecialKey
set lcs+=precedes:<,extends:>   " Horizontal ellipsis

set fillchars=
set fcs+=vert:▎               " ▎VertSplit
"set fcs+=stl:\ ,stlnc:-        " StatusLine & StatusLineNC
"set fcs+=fold:-                " Folded
set fcs+=diff:╱                 " DiffDelete
set fcs+=eob:\                  " EndOfBuffer chars

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
"set completeopt+=preview

set wildmenu
set wildmode=longest:full,list:full
set wildoptions=tagfile
set wildoptions+=pum

" }}}
"===============================================================================
" Indentation & <Tab>s {{{

set     tabstop=4
set softtabstop=4
set  shiftwidth=4

set expandtab  smarttab

set autoindent
"set smartindent
"set copyindent

set shiftround

"}}}
"===============================================================================
" Folding rules {{{

set foldenable
set foldcolumn=0
set foldminlines=1
set foldlevel=999
set foldlevelstart=999
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
set foldmarker={{{,}}}
set foldtext=FoldText()

" set foldmethod=marker
set foldmethod=expr
set foldexpr=v:lua.vim.treesitter.foldexpr()


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
