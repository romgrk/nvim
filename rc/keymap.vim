> LICENSE.md
" Description: vim keymap
" Last Modified: 27 April 2016
" !::exe [So]


" Recent mappings:

nnoremap <C-X>h  :SidewaysLeft<CR>
nnoremap <C-X>l  :SidewaysRight<CR>

nnoremap gg ggzz

"===============================================================================
" Major maps                                                                {{{1

let mapleader = "\<space>"

" <Esc>
nnoremap <silent><expr> <Esc> (
            \   exists('b:esc') ? b:esc
            \ : ":nohl<CR>" )

" <CR>
"cnoremap <expr> <CR> g:space.parse_cmd_line()


" V cycles visual modes
nnoremap       v v
xnoremap <expr>v
            \ (mode() ==# 'v' ? "\<C-V>"
            \ : mode() ==# 'V' ? 'v' : 'V')


nnoremap Y  y$

nnoremap u u
nnoremap U <C-R>
"nmap    u <Plug>(RepeatUndo)

" YankRing
"if exists('*miniyank#on_yank')
nmap     p <Plug>(miniyank-autoput)
nmap     P <Plug>(miniyank-autoPut)
nmap <A-p> <Plug>(miniyank-cycle)
"end

" G-commands:

"nnoremap gp   P`[
"nnoremap gp  m`p``
"nnoremap gP   m`P``

" Re-select last pasted text
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

nnoremap ge gel
onoremap ge :<C-U>normal! hvgel<CR>

" go-lower/go-upper
nnoremap gl  gu
nnoremap gu  gU
nnoremap gU  ~
xnoremap gl  gu
xnoremap gu  gU
xnoremap gU  ~

" go-replace
nnoremap gr      gR
xnoremap gr      r<space>gR

" go-winmode
nnoremap gw      :InteractiveWindow<CR>

" Next/Previous Tab
nnoremap g[ gT
nnoremap g] gt

" Open
nnoremap <silent> go  :<C-U>OpenURLOrSearch<CR>
xnoremap <silent> go y:<C-U>OpenURLOrSearch <C-R>"<CR>

" Search
nnoremap g/ *zvzz
nnoremap g? #zvzz


" Insert newline
nnoremap <CR>   o<Esc>
nnoremap <A-CR> O<Esc>
nnoremap g<CR>  o<Esc>cc<Esc>


" Don't leave spaces when doing i, then <esc>
nnoremap <expr>i empty(substitute(getline('.'), '^\s\+', '', '')) ? 'cc' : 'i'


" Split line (as opposed to J)
nnoremap <silent><C-J>  i<CR><Esc>:silent -DeleteTrailingWS<CR>


" Alt-M start MultiCursor-mode
nnoremap <A-m> viw:MultipleCursorsFind <C-R><C-W><CR>
vnoremap <A-m> :<C-U>call multiple_cursors#new('v', 0)<CR>
"vnoremap <expr> <A-m>
            "\ visualmode() ==# 'V'
            "\ ?  ":'<,'>MultipleCursorsFind \\S\\+"
            "\ : ":call multiple_cursors#new('v', 0)"

" }}}1
"===============================================================================
" Semicolon Quickmap                                                        {{{1

" Semicolon key
nmap <expr>   ;     CmdJump()

let g:quickmap = {
\ 'w':      ":w\<CR>",
\ '<':      ':messages',
\ ';':      ":\<Up>",
\ "\<C-F>": ':Files',
\ "\<A-;>": 'q:":P',
\ "\<A-s>": ":set ?\<Left>",
\}

function! CmdJump ()
    if sneak#is_sneaking() " return maparg('<Plug>SneakNext', 'n')
        return ":call sneak#rpt('', 0)\<CR>"
    end
    echo ''
    let char = GetChar('Info', ':')
    let qmap = get(g:quickmap, char, ':' . char)
    if !empty(qmap)
        return qmap
    else
        return ':' . char
    end
endfunc

" }}}1
"===============================================================================
" RC & Setup quick access                                                   {{{1
" @configuration

" Local config
nmap gslc           :Edit .vimrc<CR>

" Files
nnoremap gsrc       :Edit $MYVIMRC<CR>
nnoremap gsm        :Edit $vim/rc/keymap.vim<CR>
nnoremap gsko       :Edit $vim/plugin/options.vim<CR>
nnoremap gsa        :Edit $vim/rc/autocmd.vim<CR>
nnoremap gse        :Edit $vim/rc/events.vim<CR>
nnoremap gsf        :Edit $vim/rc/function.vim<CR>
nnoremap gsd        :Edit $vim/rc/commands.vim<CR>
nnoremap gsc        :Edit $vim/rc/colors.vim<CR>
nnoremap gsh        :Edit $vim/rc/highlight.vim<CR>
nnoremap gso        :Edit $vim/rc/settings.vim<CR>
nnoremap gsj        :Edit $vim/colors/darker.vim<CR>
nnoremap gsp        :Edit $vim/rc/plugins.vim<CR>
nnoremap gsP        :Edit $vim/rc/plugins/
nnoremap gs<A-p>    :Edit $vim/plugin/

nnoremap <C-n>      :Edit <C-R>=escape(expand("%:p:h"), ' ')<CR>/<C-D>

" New...
nnoremap <A-n><A-s> :UltiSnipsEdit<CR>
nnoremap <A-n><A-m> :EditFtplugin<CR>
nnoremap <A-n><A-a> :EditFtsyntax<CR>
" Edit runtime syntax file
nnoremap <A-n><A-f> :EditSyntax<CR>

" Notefile
nnoremap <A-n><A-n> :Edit $vim/plugin/notes.vim<CR>
nnoremap <A-n><A-o> :Note vim<CR>

" }}}1
"===============================================================================
" Jumps & cursor movement                                                   {{{1

" j/k screen rows
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk

" SoL-EoL motion
noremap       <A-l> $l
noremap <expr><A-h>
            \ (col('.') - 1) &&  match(getline('.'),'\S') >= col('.') - 1
            \ ? '0' : '^'

xnoremap <expr><A-l> <SID>endOfLine()

fu! s:endOfLine()
  if (visualmode() ==# "\<C-v>")
    return '$'
  end
  if (&ve=~#'onemore' || &ve==#'all')
    return '$h'
  end
  return '$'
endfu


" wide move
noremap <A-j> 5<Down>
noremap <A-k> 5<Up>
nnoremap <A-j> 5gj
nnoremap <A-k> 5gk
vnoremap <A-j> 5gj
vnoremap <A-k> 5gk

" scroll up/down
nnoremap <A-u> 10<C-Y>
nnoremap <A-d> 10<C-E>
vnoremap <A-u> 12<Up>
vnoremap <A-d> 12<Down>

nnoremap <A-b> B
nnoremap <A-e> El
onoremap <A-b> B
onoremap <A-e> E
xnoremap <A-b> B
xnoremap <A-e> E


" Column-edge
nmap  <C-A-J>       <Plug>ColumnMoveDown
nmap  <C-A-K>       <Plug>ColumnMoveUp
vmap  <C-A-J>       <Plug>ColumnMoveDown
vmap  <C-A-K>       <Plug>ColumnMoveUp

nmap  <A-S-J>  <C-V><Plug>ColumnMoveDown
nmap  <A-S-K>  <C-V><Plug>ColumnMoveUp
vmap  <A-S-J>       <Plug>ColumnMoveDown
vmap  <A-S-K>       <Plug>ColumnMoveUp


" Jumps:
nnoremap H <C-O>
nnoremap L <C-I>


" no noremap: remapped to matchit
nmap <Tab> %
vmap <Tab> %
omap <Tab> %

" Character-wise jumps
nnoremap '   `
vnoremap '   `
nnoremap ''  `'
vnoremap ''  `'

nnoremap <nowait> } }
nnoremap <nowait> { {


" Close any preview window then jump
nnoremap <C-]> <C-W>z<C-]>


" CamelCase motion
" map: w, b,        nmap: e, ge  {{{

nmap <silent> w     <Plug>CamelCaseMotion_w
nmap <silent> b     <Plug>CamelCaseMotion_b
nmap <silent> e     <Plug>CamelCaseMotion_e

xmap <silent> w     <Plug>CamelCaseMotion_w
xmap <silent> b     <Plug>CamelCaseMotion_b
xmap <silent> e     <Plug>CamelCaseMotion_e
xmap <silent> ge    <Plug>CamelCaseMotion_ge

omap <expr>   w     searchpos('\%#\s', '')[1] ?
                    \ '<Plug>CamelCaseMotion_w' : '<Plug>CamelCaseMotion_e'
omap <silent> <A-w> <Plug>CamelCaseMotion_e

xmap <silent> b     <Plug>CamelCaseMotion_b

xnoremap iw iw

" }}}

" ALE
nnoremap <silent>]a  :ALENext<CR>zvzz
nnoremap <silent>[a  :ALEPrevious<CR>zvzz

" GitGutter hunks
nnoremap <silent>[h  :GitGutterPrevHunk<CR>zvzz
nnoremap <silent>]h  :GitGutterNextHunk<CR>zvzz

" 1}}}
"===============================================================================
" Sneak                                                                     {{{1

nmap <PageUp>   <Plug>Sneak_S
nmap <PageDown> <Plug>Sneak_s

nmap gk         <Plug>Sneak_S
nmap gj         <Plug>Sneak_s

xmap <silent>    ;  <Plug>SneakNext
xmap <silent> <A-;> <Plug>SneakPrevious

nmap <expr> <a-;> sneak#is_sneaking() ? (sneak#state().reverse==1
                        \ ? "<Plug>Sneak_s<CR>"
                        \ : "<Plug>Sneak_S<CR>")
                \ : "<Plug>SneakNext"

" find operator
nmap f     <Plug>Sneak_f
xmap f     <Plug>Sneak_f
omap f     <Plug>Sneak_f
nmap <M-f> <Plug>Sneak_F
xmap <M-f> <Plug>Sneak_F
omap <M-f> <Plug>Sneak_F
nmap F     <Plug>Sneak_F
xmap F     <Plug>Sneak_F
omap F     <Plug>Sneak_F

" until operator
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap u <Plug>Sneak_t
xmap U <Plug>Sneak_T
omap u <Plug>Sneak_t
omap U <Plug>Sneak_T

" 1}}}
"===============================================================================
" Intellisense (coc.nvim)                                                   {{{1


nmap <silent> <F2> :call CocAction('rename')<CR>
nmap <silent> <leader>K :call CocAction('doHover')<CR>


" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)zz
nmap <silent> gy <Plug>(coc-type-definition)zz
nmap <silent> gD <Plug>(coc-implementation)zz
nmap <silent> gR <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
vmap gq         <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup CocEvents
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)


" 1}}}
"===============================================================================
" Commands & Space maps                                              @space {{{1

nnoremap <C-A-B>           :NeomakeSh make build<CR>

nmap     <leader>j         <Plug>Sneak_s
nmap     <leader>k         <Plug>Sneak_S

" OptionsWidget:
nnoremap <leader>co        :OptionsWidget<CR>

" CoC:
xmap <silent> gme    :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> gme    :<C-u>CocCommand actions.open<CR>

nunmap <leader>ac
nunmap <leader>a


" ALE:
nnoremap <leader>al         :ALEToggle<CR>
nnoremap <leader>a<a-l>     :ALEToggleBuffer<CR>
nnoremap <leader>af         :ALEFix<CR>


" YCM:
" nnoremap <leader>yr         :YcmRestartServer<CR>
" nnoremap <leader>yi         :YcmDebugInfo<CR>
" nnoremap <leader>yd         :YcmDiags<CR>
" nnoremap <leader>yy         :YcmForceCompileAndDiagnostics<CR>
" nnoremap <leader>yf         :YcmCompleter GoToReferences <Bar> copen<CR>
" nnoremap <leader>yk         :YcmCompleter GetDoc<CR>
" nnoremap <leader>ygo        :YcmCompleter GoTo<CR>
" nnoremap <leader>ygt        :YcmCompleter GoToType<CR>
" nnoremap <leader>ygd        :YcmCompleter GoToDefinition<CR>
" nnoremap <leader>ygD        :YcmCompleter GoToDeclaration<CR>
" nnoremap <leader>ygi        :YcmCompleter GoToInclude<CR>
" nnoremap <leader>ygr        :YcmCompleter RefactorRename<space>
" nnoremap        <F2>       :YcmCompleter RefactorRename<space>

" Tern:
nnoremap <leader>tt         :TernType<CR>
nnoremap <leader>td         :TernDef<CR>
nnoremap <leader>tp         :TernDefPreview<CR>

"===============================================================================

" Session management:
nnoremap <expr><leader>ss     xolox#session#find_current_session() != 'default' ?
                              \ ":wall! \<Bar> SaveSession\<CR>\<Esc>" : ":wall! \<Bar> SaveSession\<space>"
nnoremap       <leader>sS     :SaveSession!<space>
nnoremap       <leader>so     :call feedkeys(":OpenSession! \<C-D>", 't')<CR>
nnoremap       <leader>sd     :OpenSession! default<CR>
nnoremap       <leader>sc     :wall! <Bar> CloseSession<CR>
nnoremap       <leader>si     :wall! <Bar> CloseSession <Bar> OpenSession! <C-D>

nnoremap       <leader>sl     :SourceLocalVimrc<CR>
nnoremap       <leader>sn     :Note <C-R>=xolox#session#find_current_session()<CR><CR>


nnoremap       <leader>np     :NewProject<space>


" Git:

nnoremap       <leader>ma     :Magit<CR>

nnoremap       <leader>gaa    :!git add --all<CR>
nnoremap       <leader>ga.    :!git add %<CR>
nnoremap       <leader>gcm    :Gcommit -m ""<Left>
nnoremap       <leader>gcam   :Gcommit -am ""<Left>
nnoremap       <leader>g.     :Gcommit % -m ""<Left>
nnoremap       <leader>gk     :Git checkout<space>
nnoremap       <leader>gK     :Git checkout -b<space>
nnoremap       <leader>gl     :Gpull<CR>
nnoremap       <leader>gp     :Gpush<CR>
nnoremap       <leader>gs     :Gstatus<CR>
nnoremap       <leader>gu     :GitOpenUnmergedFiles<CR>
nnoremap       <leader>gd     :GitDiff<space>
nnoremap       <leader>gdd    :GitDiff<CR>
nnoremap       <leader>gd.    :GitDiff %<CR>

" GitMessenger:
nnoremap       <leader>gm     :GitMessenger<CR>

" GitGutter:
nnoremap       <leader>hh     :GitGutter
nnoremap       <leader>hs     :GitGutterStageHunk<CR>
nnoremap       <leader>hv     :GitGutterPreviewHunk<CR>
nnoremap       <leader>hu     :GitGutterUndoHunk<CR>

"===============================================================================
" Ack, Ag, Grep & File Searching

" Files:
nnoremap       <leader>md     :Mkdir! <C-D>
nnoremap       <leader>mv     :Move <C-D>
nnoremap       <leader>rn     :Rename<space>

" Search:
nnoremap       <leader>ag     :FzfRg<CR>
nnoremap       <leader>aa     :FzfRg <C-r><C-w><CR>

"===============================================================================

" Windows-things:
nnoremap       <leader>w-   :call SizeDown()<CR>
nnoremap       <leader>w+   :call SizeUp()<CR>

"===============================================================================

" Various:

nnoremap       <leader>p    :VCoolor<CR>

nnoremap       <leader>gf   :NERDTreeFind<CR>

nnoremap       <leader>ret  :set et <Bar> ret<CR>
nnoremap       <leader>ap   vip:EasyAlign<CR>
nnoremap       <leader>dws  :%DeleteTrailingWS<CR>

nnoremap       <leader>how  :r !howdoi<space>



" Multi-Cursors:
" (see: ./plugins/multiple-cursors.vim)
nnoremap      <leader>mw :.,.MultipleCursorsFind \S\+<CR>o<Esc>
nnoremap      <leader>mW :.,.MultipleCursorsFind \w\+<CR>

" }}}1
"===============================================================================
" Panels, File navigation, FZF & Clap                                       {{{1


nnoremap <silent><A-\>   :NERDTreeFocus<CR>
nnoremap <silent><C-\>   :NERDTreeToggle<CR>
nnoremap <silent><C-A-\> :NERDTreeFind<CR>
nnoremap <silent><C-A-T> :TagbarToggle<CR>
nnoremap <silent><C-A-L> :call ToggleWindows()<CR>

nnoremap <leader>o         :Clap files<CR>
nnoremap <leader><space>   :Clap files<CR>

nnoremap <silent> <A-o>    :Clap files<CR>
nnoremap <silent> <C-A-o>  :Clap files <C-R>=expand('%:h:~')<CR><CR>
" nnoremap <silent> <A-o>    :Files<CR>
nnoremap <silent> <A-O>    :Clap history<CR>
nnoremap <silent> <C-S>    :Clap buffers<CR>
" nnoremap <silent> <C-A-o>  :GitFiles<CR>

nnoremap <silent> <A-i>    :Clap tags<CR>
nnoremap <silent> <A-S-I>  :Tags<CR>

" Clap input

" see ../syntax/clap_input.vim

" }}}1
"===============================================================================
" Window & Tabs navigation                                                  {{{1
" @windows

" Cycle between editor Windows
nnoremap <silent> <A-w>      :GoNextListedWindow<CR>

" Windows actions
nnoremap <C-w>v     <C-w>v<C-w>l
nnoremap <C-w>s     <C-w>s<C-w>j
nnoremap <C-w>;     :split  <Bar> terminal<CR>
nnoremap <C-w>:     :vsplit <Bar> terminal<CR>
nnoremap <C-w><A-;> :tabedit term://bin/zsh<CR>
nnoremap <C-w>y     :WindowYank<CR>
nnoremap <C-w>g     :WindowPaste<CR>
nnoremap <C-w><C-Y> :WindowCopyView<CR>
nnoremap <C-w>\     :WindowFitText<CR>
nnoremap <C-w>q     :BufferClose <Bar> wincmd c<CR>

nnoremap <C-w><Tab> :tabedit <C-r>=bufname(buf#filter('&buflisted')[-1])<CR><CR>
nnoremap <C-w>t     :tab split<CR>

" Terminal navigation mappings down here. }}}1
"===============================================================================
" Terminal                                                            @term {{{1
if has('nvim')

" Panels/Navigation
nnoremap g:             :OpenTerminal<CR>
nnoremap g<A-;>         :OpenTerminalHere<CR>
" nnoremap g<space>       :GoFirstTerminalWindow<CR>
nnoremap <C-W><space>   :ToggleTerminalWindow<CR>
nnoremap <C-W><M-Space> :wincmd s \| NextTerminalBuffer<CR>


tmap <A-,>          <C-\><C-n>:PreviousTerminalBuffer<CR>
tmap <A-.>          <C-\><C-n>:NextTerminalBuffer<CR>
tmap <C-A-,>        <C-\><C-n>:bp<CR>
tmap <C-A-.>        <C-\><C-n>:bn<CR>

" Paste
tnoremap <A-p>      <C-\><C-n>pi

" Close
tnoremap <A-c>      <C-\><C-n>:bd!<CR>

tnoremap <A-e>      <C-\><C-n>
tnoremap <A-Tab>    <C-\><C-n>gt
tnoremap <F12>      <C-\><C-n>

" Navigation
tnoremap ;         <C-\><C-n>:
tnoremap <A-;>     <Esc>;
tnoremap <A-w>     <C-\><C-n><A-w>
tnoremap <A-2>     <C-\><C-n><C-n>w
tmap     <A-u>     <C-\><C-n><A-u>

" Arrows
tnoremap <A-j>     <Esc>j
tnoremap <A-k>     <Esc>k
tnoremap <A-h>     <Esc>h
tnoremap <A-l>     <Esc>l

end "of has('nvim') }}}1
"===============================================================================
" Buffer navigation                                                         {{{1

nnoremap <silent> <A-,> :BufferPrevious<CR>
nnoremap <silent> <A-.> :BufferNext<CR>
nnoremap <silent> <A-<> :BufferMovePrevious<CR>
nnoremap <silent> <A->> :BufferMoveNext<CR>

nnoremap <silent> <A-1> :BufferJump 1<CR>
nnoremap <silent> <A-2> :BufferJump 2<CR>
nnoremap <silent> <A-3> :BufferJump 3<CR>
nnoremap <silent> <A-4> :BufferJump 4<CR>
nnoremap <silent> <A-5> :BufferJump 5<CR>
nnoremap <silent> <A-6> :BufferJump 6<CR>
nnoremap <silent> <A-7> :BufferJump 7<CR>
nnoremap <silent> <A-8> :BufferJump 8<CR>
nnoremap <silent> <A-9> :BufferLast<CR>

nnoremap <A-c>      :BufferClose<CR>
nnoremap <A-C>      :BufferReopen<CR>
nnoremap <C-A-c>    :BufferClose<CR><C-w>c
nnoremap <C-A-q>    :BufferWipeReopen<CR>

if exists('g:gui_oni')
nnoremap <silent> <A-,> :tabprev<CR>
nnoremap <silent> <A-.> :tabnext<CR>
nnoremap <silent> <A-c> :tabclose<CR>
end

" }}}1
"===============================================================================
" Text manipulation                                                         {{{1

" Exchange line x-up/down
nnoremap <expr>Xj     'ddp'  . col('.') . '<Bar>'
nnoremap <expr>Xk     'ddkP' . col('.') . '<Bar>'

" Yank & Paste * (yank-up, yank-down)
nnoremap yu yyP
nnoremap yd yyp

" Indent
nnoremap <nowait> > V><Esc>
nnoremap <nowait> < V<<Esc>
vnoremap <nowait> > >gv
vnoremap <nowait> < <gv


" Targets:
" b(), k{}, r[]                                                              {{{
let pairs              = 'b()k{}r[]a<>' " self-added to local surround/
let targets_pairs      = '()b {}k []r <>'

let targets_quotes     = '"d ''q `'
let targets_separators = ', . ; : + - = ~ _ * # / | \ & $'

let targets_tagTrigger   = 't'

let targets_argTrigger   = 'a'
let targets_argSeparator = ','
let targets_argOpening   = '[({[]'
let targets_argClosing   = '[]})]'

let targets_aiAI       = 'aIAi'
let targets_nlNL       = 'npNF'

let targets_seekRanges =
        \ 'cr cb cB lc ac Ac lr lb rr rb bb ll al aa ar ab'
" Default "cr cb cB lc ac Ac lr rr ll lb ar ab lB Ar aB Ab"
"                                          "AB rb al rB Al bb aa bB Aa BB AA"
"}}}

" Surround: operator
" + ysf, csf, dsf, cs', ds'                                                  {{{
" hack
nmap csk csB
nmap dsk dsB

nmap dsq ds'
nmap dsd ds"

nmap <A-s> <Plug>Ysurround
vmap <A-s> <Plug>VSurround

" delete/change/surround func-call: (ysf)
let surround_{char2nr("f")} = "\1func: \1(\r)"

" }}}

" Functioncall: Text-Object                                                  {{{
" change inside/all current/last/next fcall
" function definitions & search patterns TODO move to autoload

" function-call patterns
let name_pattern = '\(\k\|\i\|\f\|<\|>\|:\|\\\)\+'
let args_pattern = '\(\\)\|[^)]\)*'
let fcall_pattern = name_pattern . '\s*\ze('
let fargs_pattern = name_pattern . '\s*(\zs' . args_pattern . '\ze\s*)'
let func_pattern  = name_pattern . '\s*(' . args_pattern . '\s*)'


" Param {String} flags - same as search() (see vim help),
"                       plus 'v' - visually select the function
" Returns the [lnum, col] of the nearest function
function! s:findFunc (flags, ...)
    let fc = a:flags =~# 'c' ? 'c' : ''
    let fb = a:flags =~# 'b' ? 'b' : ''
    let fn = a:flags =~# 'n' ? 'n' : ''
    let visual = a:flags =~# 'v' ? 1 : 0

    let pattern = '\(\k\|\i\|\f\|<\|>\|:\|\\\)\+\s*\ze('
    if (len(a:000) == 1)
        let pattern = a:000[0] | end

    if (visual)
        let start = searchpos(pattern, fc . fb)
        normal! v
        let end   = searchpos(pattern, 'ce')
        return [ start, end ]
    else
        return searchpos(pattern, fc . fb . fn)
    end
endfu
fu! s:visualFunc(...)
    let which = get(a:, 1, 'c')
    let pattern = g:fcall_pattern

    " inside ...
    if which =~ 'i'
        let pattern = g:fargs_pattern | end

    " all ...
    if which =~ 'a'
        let pattern = g:func_pattern | end

    " Current
    if which =~ 'c'
        call s:findFunc ('vbc', pattern) | end

    " Next
    if which =~ 'n'
        call s:findFunc ('v', pattern) | end

    " Last
    if which =~ 'l'
        call s:findFunc ('vb', pattern) | end

    return
endfu
fu! s:changeFunc(...)
    let which = get(a:, 1, 'c')

    let pattern = g:fcall_pattern

    " inside ...
    if which =~ 'i'
        let pattern = g:fargs_pattern | end

    " all ...
    if which =~ 'a'
        let pattern = g:func_pattern | end

    " Current
    if which =~ 'c'
        call s:findFunc ('vbc', pattern)
        call feedkeys('c', '') | end

    " Next
    if which =~ 'n'
        call s:findFunc ('v', pattern)
        call feedkeys('c', '') | end

    " Last
    if which =~ 'l'
        call s:findFunc ('vb', pattern)
        call feedkeys('c', '') | end

    return ''
endfu

fu! s:deleteSurroundingFunc(flags)
    call s:findFunc(a:flags)
    normal ddsb
endfu
fu! s:changeSurroundingFunc ()
    let saved_cursor = getcurpos()
    call s:findFunc ('vbc') | redraw
    let char = GetChar('Question', 'Change surrounding func with: ')
    if char != "\<Esc>"
        call feedkeys('dcsb' . char, '')
    else
        Reset saved_cursor
    end
endfu

nmap <silent>cif    :call <SID>changeFunc('c')<CR>
nmap <silent>cIf    :call <SID>changeFunc('ic')<CR>
nmap <silent>caf    :call <SID>changeFunc('ac')<CR>
nmap <silent>cnf    :call <SID>changeFunc('n')<CR>
nmap <silent>cpf    :call <SID>changeFunc('l')<CR>
" nmap <silent>cinf   :call <SID>changeFunc('in')<CR>
" nmap <silent>cilf   :call <SID>changeFunc('il')<CR>
" nmap <silent>canf   :call <SID>changeFunc('an')<CR>
" nmap <silent>calf   :call <SID>changeFunc('al')<CR>

nmap <silent>dsf     :call <SID>deleteSurroundingFunc('vbc')<CR>
nmap <silent>dsF     :call <SID>deleteSurroundingFunc('vb')<CR>
nmap <silent>ds<A-f> :call <SID>deleteSurroundingFunc('vb')<CR>
nmap <silent>csf     :call <SID>changeSurroundingFunc()<CR>
" }}}

" FindQuote:
" mappings:                                                                  {{{
" cs''  toggles surrounding quotes
" ds'   deletes surrounding quotes
" f'    is equivalent to f' and/or f"

fu! s:findQuote(...) " ( forward=1, action='m' )
    " action:       m -> move cursor
    "               p -> returns the character position [line, col]
    "               c -> returns the matched character (' or ")

    if (a:0 > 0) && (a:1==1 || a:1==0)
        let dir   = a:1
        let which = (a:0 > 1 ? a:2 : 'm')
        let fb = (dir) ? '' : 'b'

        if which =~ 'm'
            call searchpos('\v["'']', fb)
            return | end

        if  which =~ 'p'
            let pos = searchpos('\v["'']', fb . 'n')
            return pos | end

        if  which =~ 'c'
            let pos = searchpos('\v["'']', fb . 'nc')
            let ch = CharAt( [pos[0], pos[1]-1] )
            return ch | end

        return
    end

    let flags = a:0 ? a:1 : 'nc'
    let cw = getcurpos()[1:2]
    let fw = searchpos('\v["'']', flags)
    let fw[1] -= 1
    let bw = searchpos('\v["'']', 'b' . flags)
    let bw[1] -= 1
    if fw == cw
        let pos = fw
    else
        let df = (fw[0] - cw[0]) * 80 + (fw[1] - cw[1])
        let db = (cw[0] - bw[0]) * 80 + (cw[1] - bw[1])
        let pos = df < db ? fw : bw
    end

    return CharAt(pos)
endfu
fu! s:changeSurroundingQuotes()
    let qch = s:findQuote()
    let char = GetChar('Question', 'Change surrounding quotes with: ')
    if char == "'"
        let char = (qch ==# "\"" ? "'" : "\"") | end
    return "\<Plug>Csurround" . qch . char
endfu
fu! s:deleteSurroundingQuotes()
    return "\<Plug>Dsurround" . s:findQuote()
endfu


nmap <silent><expr>f'   "<Plug>Sneak_f" . <SID>findQuote(1, 'c')
nmap <silent><expr>F'   "<Plug>Sneak_F" . <SID>findQuote(0, 'c')

" delete/change surrounding quotes
nmap <expr>cs'  <SID>changeSurroundingQuotes()
nmap <expr>ds'  <SID>deleteSurroundingQuotes()
" }}}

" Substitute: operator (replace.vim)
" normal: s,ss,S        visual: s                                            {{{
" unlet! m
nmap s  <Plug>ReplaceOperator
nmap ss Vs
nmap S  s$
xmap s  <Plug>ReplaceOperator

" TODO assess usage
nmap X <Plug>ExchangeOperator
vmap X <Plug>ExchangeOperator
" }}}

" EasyAlign:
" mappings: ga, <A-a>                                                        {{{

" General
nmap <A-a> <Plug>(EasyAlign)
vmap <CR>  <Plug>(EasyAlign)

nmap <A-a>r     <Plug>(EasyAlign)ip1<C-x>
nmap <A-a><A-r> <Plug>(EasyAlign)ip1<C-x>
nmap <A-a><A-/> <Plug>(EasyAlign)ip1<C-x>
vmap <A-a>   ""<A-y><Plug>(EasyAlign)ip1<C-D><Left><C-x>.\{-}\zs\s*\ze<C-r>"<CR>
vmap <C-a>   ""<A-y><Plug>(EasyAlign)ip1<C-D><Left><C-x>.\{-}\zs\s*\ze<C-r>"<CR>

" align semicolon
nnoremap <A-a><A-;> vip:EasyAlign *:<CR>
" align bar
nnoremap <A-a><A-\> vip:EasyAlign *<Bar><CR>
" align equal
nnoremap <A-a><A-e> vip:EasyAlign *=<CR>
nnoremap <A-=>      vip:EasyAlign *=<CR>
" align word
nnoremap <A-a><A-w> vip:EasyAlign *<space><CR>
" align Last-Word
nnoremap <A-a>lw    vip:EasyAlign -<space><CR>
" align commas
nnoremap ,,         vip:EasyAlign *,<CR>


" EasyAlign                                                                  }}}

" SplitJoin:
" overrides 's' operator                                                     {{{
nmap sj :SplitjoinJoin<CR>
nmap sk :SplitjoinSplit<CR>
" }}}

" Comment:
" alt-'  &  alt-"                                                            {{{
nmap <A-'>      <Plug>NERDCommenterToggle
vmap <A-'>      <Plug>NERDCommenterSexy
" }}}

" StringTransform:
" gc, gC, --, -s, __                                                         {{{
nmap gc <Plug>(camel_case_operator)
xmap gc <Plug>(camel_case_operator)
nmap gC <Plug>(upper_camel_case_operator)
xmap gC <Plug>(upper_camel_case_operator)
nmap __ <Plug>(snake_case_operator)
xmap __ <Plug>(snake_case_operator)
nmap -- <Plug>(kebab_case_operator)
xmap -- <Plug>(kebab_case_operator)
nmap _s <Plug>(start_case_operator)
xmap _s <Plug>(start_case_operator)
nmap -s <Plug>(start_case_operator)
xmap -s <Plug>(start_case_operator)
"}}}

" }}}1
"===============================================================================
" Search & replace                                                          {{{1

" IncSearch
nmap / <Plug>(incsearch-forward)
nmap ? <Plug>(incsearch-backward)

nmap n  <Plug>(incsearch-nohl-n)zvzz
nmap N  <Plug>(incsearch-nohl-N)zvzz
nmap *  <Plug>(incsearch-nohl-*)
nmap #  <Plug>(incsearch-nohl-#)

" Yank selected text as an escaped search-pattern
map <silent><Plug>(visual-yank-plaintext)
      \ :<C-U>call setreg(v:register, '\C\V'.escape(visual#GetText(), '\/'))<CR>

vmap <M-y>           <Plug>(visual-yank-plaintext)
vmap <A-/>         "/<Plug>(visual-yank-plaintext)n
vmap <silent><C-F> "/<Plug>(visual-yank-plaintext):set hls<CR>
nmap z*         viw"/<Plug>(visual-yank-plaintext):set hls<CR>



" Text Replace TODO implement a real replace-mode
nnoremap <A-r>r     &
nnoremap <A-r><A-r> g&

nmap <A-r><A-l> :s///<left>
nmap <A-r><A-a> :%s///<left>
nmap <A-r>a     :%s///<left>
nmap <A-r><A-j> :.,$s///<left>
nmap <A-r>j     :.,$s///<left>
nmap <A-r><A-w> viw<C-F><A-r><A-l>
nmap <A-r><A-p> m'viw<C-F><A-r><A-l><A-p><CR>''

vmap <A-r>      :s///<left>

" SearchReplace
nnoremap <silent><C-F> :Search<CR>

" }}}1
"===============================================================================
" Macro & Automation                                                        {{{1

" Replay macro
nnoremap <M-q> @@

" Execute the next macro with current visual-range
vnoremap q :call VisualRecord()<CR>

function! VisualRecord () range "                                            {{{
    if exists('a:firstline')
        let g:range = [a:firstline, a:lastline]
    else
        let g:range = [getpos("'<")[1], getpos("'>")[1]]
    end

    noremap q     :call VisualExecute()<CR>
    noremap <C-c> :call VisualStop()<CR>

    call cursor(g:range[0], 1)
    normal! qv
endfu

function! VisualStop()
    normal! q
    let g:macro=getreg('v', 1)
    unmap q
    unmap <C-c>
endfu

function! VisualExecute ()
    call VisualStop()
    let g:macro = substitute(g:macro, 'q$', '', '')
    Pp g:range, g:macro
    "if empty(g:macro) | return | end
    for lnum in range(g:range[0]+1, g:range[1])
        call cursor(lnum, 1)
        echom lnum . '/' . line('.')
        call feedkeys(g:macro, '')
        "exe g:range[0] . ',' g:range[1] . 'normal ' . g:macro
    endfor
endfu

" }}}1
"===============================================================================
" Quick Utils                                                               {{{1
" @utils

" Yank all
nnoremap gya :keepmarks normal! m'ggVGy`'<CR>

" Exchange lhs-rhs
nmap gx= vihgxvilgx

" File Explorer
if has('win32')
nnoremap <F1> :silent !explorer .<CR>
else
nnoremap <F1> :silent !nautilus .<CR>
end

nnoremap <F3> :NERDTreeFind<CR>

nnoremap <F5> :e!<CR>


" Insert word of the line above
inoremap <C-Y> <C-C>:let @z = @"<CR>mz
                \:exec 'normal!' (col('.')==1 && col('$')==1 ? 'k' : 'kl')<CR>
                \:exec (col('.')==col('$') - 1 ? 'let @" = @_' : 'normal! yw')<CR>
                \`zp:let @" = @z<CR>a


nnoremap =r      :call QuickReload()<CR>



" Copy current file path
nmap <silent>ycf :let @+=expand("%:~") <Bar> call Warn('Yanked: ' . @+)<CR>
nmap <silent>ycd :let @+=expand("%:h") <Bar> call Warn('Yanked: ' . @+)<CR>
nmap <silent>ycF :let @+=expand("%:p") <Bar> call Warn('Yanked: ' . @+)<CR>
nmap <silent>ycD :let @+=expand("%:p:h") <Bar> call Warn('Yanked: ' . @+)<CR>


" Gtfo
nnoremap ZZ :wqall<CR>

" }}}1
"===============================================================================
" Operator-pending maps                                                     {{{1

" for lazyness
onoremap l $
onoremap h ^

" Paragraph: operator
" all paragraph
onoremap <A-p> ap
" in paragraph
xnoremap <A-p> ip

" Remaps to targets
omap '  i'
omap "  i"
omap id i"
omap iq i'
omap ik i{
omap ir i[
omap ad a"
omap aq a'
omap ak a{
omap ar a[

" A/in <tag>
onoremap a, a<
onoremap i, i<

" Until...
onoremap ; t;
onoremap : t:
onoremap , t,
onoremap . t.

" Until space
onoremap <Space>   E
onoremap <M-space> B
xnoremap <Space>   E
xnoremap <M-space> B


" Inside space
onoremap i<space> iW
vnoremap i<space> iW


" LHS/RHS operators:                                                         {{{
"let property = value
omap ih     <Plug>(operator-lhs)
omap iH     <Plug>(operator-Lhs)
omap ah     <Plug>(operator-Lhs)
omap il     <Plug>(operator-rhs)
omap al     <Plug>(operator-Rhs)
omap iL     <Plug>(operator-Rhs)

xmap ih     <Plug>(visual-lhs)
xmap iH     <Plug>(visual-Lhs)
xmap ah     <Plug>(visual-Lhs)
xmap il     <Plug>(visual-rhs)
xmap al     <Plug>(visual-Rhs)
xmap iL     <Plug>(visual-Rhs)
" end-of-LHS/RHS                                                             }}}

" }}}1
"===============================================================================
" Visual-mode                                                               {{{1
" xn := visual-mode noremap, excluding select-mode

" TODO use these to exchange text
" Visual Marks: {{{
xmap m  <Plug>VisualMarksVisualMark
nmap gm <Plug>VisualMarksGetVisualMark
"}}}

" Niceblock: {{{
xmap I     <Plug>(niceblock-I)
xmap gI    <Plug>(niceblock-gI)
xmap gi    <Plug>(niceblock-gI)
xmap A     <Plug>(niceblock-A)
xmap ga    <Plug>(niceblock-A)
""}}}

" VisualSelection Move: {{{
xnoremap       <silent> J :m '>+1<CR>gv=gv
xnoremap       <silent> K :m '<-2<CR>gv=gv
xnoremap <expr><silent> H 'dhP`[' . visualmode() . '`]'
xnoremap <expr><silent> L  'dp`[' . visualmode() . '`]'
"}}}

" 1}}}
"===============================================================================
" Lang & common maps                                                        {{{1

" Underspace
map! <A-space> _
map! <S-space> _

" Paste @@
cnoremap <A-p> <C-R>+
inoremap <A-p> <C-R>+

" Section: Filename/path insertion {{{

" noremap! <A-i><A-i> <C-R>=expand('%:p:~')<CR>
noremap! <A-i>f          <C-R>=expand('%')<CR>
noremap! <A-i><A-f>      <C-R>=expand('%:~')<CR>
noremap! <A-i>F          <C-R>=expand('%:p')<CR>
noremap! <A-i>h          <C-R>=expand('%:h:.')<CR>
noremap! <A-i><A-h>      <C-R>=expand('%:h:~')<CR>
noremap! <A-i>H          <C-R>=expand('%:p:h')<cr>
noremap! <A-i>d          <C-R>=expand('%:h:.')<CR>
noremap! <A-i><A-d>      <C-R>=expand('%:h:~')<CR>
noremap! <A-i>D          <C-R>=expand('%:p:h')<cr>
noremap! <A-i>b          <C-R>=expand('%:t:r')<CR>
noremap! <A-i>n          <C-R>=expand('%:t')<CR>
noremap! <A-i>e          <C-R>=expand('%:e')<CR>
noremap! <A-i>t          <C-R>=expand('%:t')<CR>
noremap! <A-i><          <C-R>=expand('%<')<CR>
noremap! <A-i>,          <C-R>=expand('%<') . '.'<CR>

noremap! <A-i><A-i>f     <C-R>=expand('#')<CR>
noremap! <A-i><A-i><A-f> <C-R>=expand('#:~')<CR>
noremap! <A-i><A-i>F     <C-R>=expand('#:p')<CR>
noremap! <A-i><A-i>h     <C-R>=expand('#:h:.')<CR>
noremap! <A-i><A-i><A-h> <C-R>=expand('#:h:~')<CR>
noremap! <A-i><A-i>H     <C-R>=expand('#:p:h')<cr>
noremap! <A-i><A-i>d     <C-R>=expand('#:h:.')<CR>
noremap! <A-i><A-i><A-d> <C-R>=expand('#:h:~')<CR>
noremap! <A-i><A-i>D     <C-R>=expand('#:p:h')<cr>
noremap! <A-i><A-i>b     <C-R>=expand('#:t:r')<CR>
noremap! <A-i><A-i>n     <C-R>=expand('#:t')<CR>
noremap! <A-i><A-i>e     <C-R>=expand('#:e')<CR>
noremap! <A-i><A-i>t     <C-R>=expand('#:t')<CR>
noremap! <A-i><A-i><     <C-R>=expand('#<')<CR>
noremap! <A-i><A-i>,     <C-R>=expand('#<')<CR>

noremap! <A-i>c     <C-R>=fnamemodify(getcwd(), ':~')<CR>
noremap! <A-i>C     <C-R>=getcwd()<CR>

"}}}

" Section: Move {{{
noremap! <A-j> <Down>
noremap! <A-k> <Up>
noremap! <A-h> <Left>
noremap! <A-l> <Right>
" }}}

" FIXME move the functions to some autoload folder
" Section: readline keybindings {{{

inoremap          <C-U> <C-O>d0
cnoremap          <C-U> <C-U>

inoremap          <C-A> <C-O>^
inoremap     <C-X><C-A> <C-A>
cnoremap          <C-A> <Home>
cnoremap     <C-X><C-A> <C-A>

inoremap <expr>   <C-B> getline('.')=~'^\s*$'&&col('.')>strlen(getline('.'))?"0\<Lt>C-D>\<Lt>Esc>kJs":"\<Lt>Left>"
cnoremap          <C-B> <Left>

inoremap <expr>   <C-D> col('.')>strlen(getline('.'))?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr>   <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"

inoremap <expr>   <C-E> col('.')>strlen(getline('.'))<bar><bar>pumvisible()?"\<Lt>C-E>":"\<Lt>End>"

inoremap <expr>   <C-F> col('.')>strlen(getline('.'))?"\<Lt>C-F>":"\<Lt>Right>"
cnoremap <expr>   <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"

inoremap <silent> <M-b> <C-O>:call search('\<', 'b')<CR>
inoremap <silent> <M-f> <C-O>:call search('\>')<CR>
cnoremap          <M-f> <C-R>=<SID>cmdForwardWord()<CR>
cnoremap          <M-b> <C-R>=<SID>cmdBackwardWord()<CR>

noremap!          <M-d> <C-O>dw
cnoremap          <M-d> <S-Right><C-W>
noremap!          <M-BS> <C-W>

function! s:cmdBackwardWord ()
    let line = getcmdline()
    let pos = getcmdpos()
    let n = 0
    let m = 1
    let me = 1
    "let pat = '\v[^A-Z][A-Z]\zs|\w+|\W\s+'
    let pat = '\C\v>|\W\zs\s+|[^A-Z]\zs[A-Z]'
    while (n < pos && n != -1)
        let m =  match(line,    pat, me)
        let me = matchend(line, pat, me)
        if (m == -1 || m+1 >= pos)
            break
        end
        let n = m
    endwhile
    if (n <= 1)
        call setcmdpos(1)     | else
        call setcmdpos(n + 1) | end
    return ''
endfu
function! s:cmdForwardWord ()
    let line = getcmdline()
    let pos = getcmdpos()
    let n = match(line, '\C\v>|\W\zs\s+|[^A-Z]\zs[A-Z]', pos)
    if n == -1
        call setcmdpos(len(line) + 1)
    else
        call setcmdpos(n + 1)
    end
    return ''
endfu

"}}}

" 1}}}
"===============================================================================
" Insert                                                                    {{{1


inoremap <A-o> <C-o>


" 1}}}
"===============================================================================
" Autocomplete & Snippets (<TAB>, <Space>, etc)                             {{{1

let UltiSnipsExpandTrigger       = "<A-;>"
let UltiSnipsJumpForwardTrigger  = "<C-A-n>"
let UltiSnipsJumpBackwardTrigger = "<C-A-p>"

let ycm_key_invoke_completion        =  '<C-Space>'
let ycm_key_list_select_completion   = [ '<Down>' ]
let ycm_key_list_previous_completion = [ '<Up>'   ]

inoremap <C-Space> <C-X><C-I>

" Filename autocompletion
inoremap <C-F> <C-X><C-F>

inoremap <silent><CR>    <C-R>=I_CR()<CR>
inoremap <silent><Tab>   <C-R>=I_TAB()<CR>
inoremap <silent><S-Tab> <C-R>=I_S_TAB()<CR>
inoremap <silent><Space> <C-R>=I_SPACE()<CR>

smap <Tab>   <Esc>:call UltiSnips#JumpForwards()<CR>
smap <S-Tab> <Esc>:call UltiSnips#JumpBackwards()<CR>

func! I_CR ()
    "if Ulti_canExpand()
        "return Ulti_expand() | end

    if pumvisible()
        return "\<C-Y>\<C-R>=Ulti_expand()\<CR>" | end

    "return delimitMate#ExpandReturn() . "\<C-g>u"
    return "\<CR>\<C-g>u"
endfu

func! I_SPACE ()
    "if delimitMate#ShouldJump() && pumvisible()
        "return delimitMate#JumpAny() | end

    if pumvisible()
        return "\<C-g>\<Esc>" . "\<space>"
    end

    return "\<C-g>u" . "\<space>"
endfu

fu! I_TAB ()
    if pumvisible()
        return "\<C-N>" | end

    if Ulti_canExpand()
        return Ulti_expand() | end

    if Ulti_canJump()
        return Ulti_jump('1') | end

    if  (getline('.')[col('.')-2] =~? '\w\|\.'
    \ && getline('.')[col('.')-1] !~? '\w' )
        return get(b:, 'tab_complete', &omnifunc != '' ? "\<C-X>\<C-O>" : "\<C-N>")."\<C-P>"  | end

    if exists('b:tab_key')
      return b:tab_key | end

    return "\<TAB>"
endfu

fu! I_S_TAB ()
    if Ulti_canJump() && !pumvisible()
        return Ulti_jump('0') | end

    if pumvisible()
        return "\<C-p>" | end

    return "\<S-TAB>"
endfu

" SECTION: UltiSnips helpers

function! Ulti_canExpand()
if !has('python3') | return 0 | end
py3 << EOF
import vim
from UltiSnips import UltiSnips_Manager, vim_helper
before = vim_helper.buf.line_till_cursor
sn=UltiSnips_Manager._snips(before, False)
vim.command('return %i' % len(sn))
EOF
endfunction

function! Ulti_canJump()
if !has('python3') | return 0 | end
py3 << EOF
import vim
from UltiSnips import UltiSnips_Manager
if UltiSnips_Manager._current_snippet:
    vim.command('return 1')
else:
    vim.command('return 0')
EOF
endfunction

function! Ulti_jump(dir)
py3 << EOF
import vim
from UltiSnips import UltiSnips_Manager
if UltiSnips_Manager._current_snippet:
    if vim.eval('a:dir') == '1':
        UltiSnips_Manager.jump_forwards()
    else:
        UltiSnips_Manager.jump_backwards()
EOF
    return ""
endfu

function! Ulti_expand()
    call UltiSnips#ExpandSnippet()
    return ""
endfu

" }}}1
"===============================================================================
" Command maps                                                              {{{1

set wildchar=<Tab>
set wildcharm=<C-x>

" Open CmdWindow
set cedit=<C-F>
cnoremap <A-;> <C-F>

" Insert all matches
cnoremap <A-a> <C-A>

" Insert...
cnoremap <A-i>.     '%'
cnoremap <A-i>5     '%'

cnoremap <C-r><C-l> <C-r>=getline('.')<CR>

" alt-u ~ go up
cnoremap <A-u> <C-W><C-W>

" Abbreviations: @cabbr

cabbrev pp      Pp
cabbrev sudo    w !sudo tee % >/dev/null


" Insert-like mappings
" Movement functions
function! s:mapCmdPairs()
    let s:cmd_pairs = {
    \'(': ')',
    \'[': ']',
    \'{': '}',
    \'"': '"',
    \"'": "'"
    \}
    for k in keys(s:cmd_pairs)
    let opening = k
    let closing = s:cmd_pairs[k]
    execute 'cnoremap ' . opening . ' ' . opening . closing .'<Left>'
    if closing == '"'
        execute "cnoremap <expr>" . closing . " <SID>cmdClosingPair('" . closing . "', '" . opening ."')"
    else
        execute 'cnoremap <expr>' . closing . ' <SID>cmdClosingPair("' . closing . '", "' . opening .'")'
    end
    endfor
    cnoremap <expr><BS>  <SID>cmdDeletePair("\<BS>")
    cnoremap <expr><C-h> <SID>cmdDeletePair("\<C-h>")
endfu
function! s:cmdClosingPair (closing, opening)
    let pos  = getcmdpos()
    let line = getcmdline()
    let next = line[pos - 1]
    if next == a:closing
        return "\<Right>"
    elseif a:closing == a:opening
        return a:opening . a:closing . "\<Left>"
    else
        return a:closing
    end
endfu
function! s:isAtEndOfCmdline ()
  return 1
    return getcmdpos() == 1+len(getcmdline())
endfu
function! s:cmdDeletePair (char)
    let pos  = getcmdpos()
    let line = getcmdline()
    let char_before = line[pos - 2]
    let char_after  = line[pos - 1]
    if has_key(s:cmd_pairs, char_before)
      \ && s:cmd_pairs[char_before] == char_after
        return "\<Right>\<BS>\<BS>"
    else
        return a:char
    end
endfu


" 1}}}
"===============================================================================
" Folds, scroll                                                             {{{1

nnoremap <A-H> 5zh
nnoremap <A-L> 4zl
nnoremap <C-h> zH
nnoremap <C-l> zL

nnoremap <C-k> za
nnoremap <C-o> zO

" Recursive open/close
nnoremap zm zM
nnoremap zr zR
nnoremap zR zr
nnoremap zM zm

" Mappings to easily toggle fold levels
nnoremap z0 :set foldlevel=0<CR>
nnoremap z1 :set foldlevel=1<CR>
nnoremap z2 :set foldlevel=2<CR>
nnoremap z3 :set foldlevel=3<CR>
nnoremap z- :set foldlevel-=1 <Bar> call Info('&foldlevel = ' . &foldlevel)<CR>
nnoremap z+ :set foldlevel+=1 <Bar> call Info('&foldlevel = ' . &foldlevel)<CR>

" 1}}}
"===============================================================================
" Options: ../plugin/options.vim
"===============================================================================
" vim: fdm=marker
2:                            Version 2.0, January 2004
20:       otherwise, or (ii) ownership of fifty percent (50%) or more of the
191:    Licensed under the Apache License, Version 2.0 (the "License");
195:        http://www.apache.org/licenses/LICENSE-2.0

> ISSUE_TEMPLATE.md
5: - [ ] Ideally, I'm providing a [sample JSFiddle](https://jsfiddle.net/n1k0/f2y3fq7L/6/) or a [shared playground link](https://rjsf-team.github.io/react-jsonschema-form/) demonstrating the issue.

> README.md
11: <a target=_blank href="https://www.browserstack.com/"><img width=200 src="https://user-images.githubusercontent.com/1689183/51487090-4ea04f80-1d57-11e9-9a91-79b7ef8d2013.png"></a>

> react-json-schema-form.iml
1: <?xml version="1.0" encoding="UTF-8"?>

> lerna.json
3:   "version": "2.0.0-alpha.1"

> packages/semantic-ui/README.md
25:     <img src="https://react.semantic-ui.com/logo.png" alt="Logo" width="140" height="120">
78: - `@semantic-ui-react >= 0.83.0` ([V0.83.0](https://github.com/Semantic-Org/Semantic-UI-React/releases/tag/v0.83.0))
81: - `react-jsonschema-form >= 1.6.0` ([in 1.6.0, the `withTheme` HOC was added](https://github.com/mozilla-services/react-jsonschema-form/pull/1226))

> packages/core/devServer.js
5: const server = process.env.RJSF_DEV_SERVER || "localhost:8080";
7: const host = splitServer[0];
23:   res.status(204).end();

> packages/material-ui/README.md
27:     <img src="https://raw.githubusercontent.com/cybertec-postgresql/rjsf-material-ui/master/rjsf-material-ui-logo.png" alt="Logo" width="140" height="120">
81: - `@material-ui/core >= 4.2.0` ([in 4.2.0, the `slider` component was added to the core](https://github.com/mui-org/material-ui/pull/16416))
83: - `react-jsonschema-form >= 1.6.0` ([in 1.6.0, the `withTheme` HOC was added](https://github.com/mozilla-services/react-jsonschema-form/pull/1226))
141: [build-shield]: https://img.shields.io/circleci/build/github/cybertec-postgresql/rjsf-material-ui.svg?style=flat-square&token=a58b0890f96bff2b53eef0f4d9c9e5d16eec2200

> packages/core/test/BooleanField_test.js
612:       expect(spy.lastCall.args[0].formData).eql(true);

> packages/core/test/withTheme_test.js
119:       expect(node.querySelectorAll(".string-field")).to.have.length.of(0);
196:       expect(node.querySelectorAll("#test-theme-widget")).to.have.length.of(0);
257:       ).to.have.length.of(0);

> packages/core/test/SchemaField_test.js
83:       expect(node.querySelectorAll("label")).to.have.length.of(0);
209:       expect(node.querySelectorAll("label")).to.have.length.of(0);
251:       expect(matches[0].textContent).to.equal("A Foo field");
258:         0
311:       expect(matches[0].textContent).to.eql("container");
326:       expect(matches[0].textContent).to.contain("test");
345:         expect(matches[0].textContent).to.eql("test");

> packages/core/test/ObjectField_test.js
45:       expect(fieldset[0].id).eql("root");
433:       expect(labels[0].textContent).eql("CustomName Key");
605:       expect(Object.keys(onChange.lastCall.args[0].formData)).eql([

> packages/core/test/StringField_test.js
69:       ).to.have.length.of(0);
306:       expect(node.querySelectorAll(".field option")[0].value).eql("");
322:       expect(node.querySelectorAll(".field option")[0].textContent).eql("Test");
461:       expect(options[0].innerHTML).eql("false");
482:       expect(options[0].innerHTML).eql("");
503:       expect(options[0].innerHTML).eql("");
549:           "ui:options": { rows: 20 },
554:       expect(node.querySelector("textarea").getAttribute("rows")).eql("20");
730:       const newDatetime = "2012-12-12";
738:         .eql(newDatetime.slice(0, 10));
780:         target: { value: "2012-12-12" },
786:         formData: "2012-12-12",
902:         target: { value: 2012 },
905:         target: { value: 10 },
921:         formData: "2012-10-02T01:02:03.000Z",
976:         // from 1900 to current year + 2 (inclusive) + 1 undefined option
977:         new Date().getFullYear() - 1900 + 3 + 1,
981:         60 + 1,
982:         60 + 1,
997:         "10",
1016:         "01",
1017:         "02",
1018:         "03",
1019:         "04",
1020:         "05",
1021:         "06",
1022:         "07",
1023:         "08",
1024:         "09",
1025:         "10",
1058:         const formValue = onChange.lastCall.args[0].formData;
1062:         expect(timeDiff).to.be.at.most(5000);
1147:       const datetime = "2012-12-12";
1172:         target: { value: 2012 },
1175:         target: { value: 10 },
1182:         formData: "2012-10-02",
1187:       const datetime = "2012-12-12";
1231:         // from 1900 to current year + 2 (inclusive) + 1 undefined option
1232:         new Date().getFullYear() - 1900 + 3 + 1,
1249:         "10",
1268:         "01",
1269:         "02",
1270:         "03",
1271:         "04",
1272:         "05",
1273:         "06",
1274:         "07",
1275:         "08",
1276:         "09",
1277:         "10",
1291:         formData: "2012-12-12",
1306:           formData: "2012-1212",
1309:         expect(err.message).eql("Unable to parse date 2012-1212");
1843:       const uriEncodedValue = "file%C3%A1%C3%A9%C3%AD%20%C3%B3%C3%BA1.txt";

> packages/core/test/anyOf_test.js
31:     expect(node.querySelectorAll("select")).to.have.length.of(0);
179:     expect(node.querySelectorAll("#root_bar")).to.have.length.of(0);
187:     expect(node.querySelectorAll("#root_foo")).to.have.length.of(0);
401:     expect(node.querySelector("select").value).eql("0");
445:     expect($select.value).eql("0");
508:     expect($select.value).eql("0");
571:     expect($select.value).eql("0");
727:       expect(selects[0].value).eql("0");
734:       expect(selects[0].value).eql("1");
735:       expect(selects[1].value).eql("0");
775:       Simulate.click(moveDownBtns[0]);

> packages/core/test/ArrayFieldTemplate_test.js
259:             0
278:           ).to.have.length.of(0);
284:           ).to.have.length.of(0);

> packages/core/test/FieldTemplate_test.js
38:         expect(node.querySelectorAll(".disabled")).to.have.length.of(0);
55:         expect(node.querySelectorAll(".disabled")).to.have.length.of(0);
76:         expect(node.querySelectorAll(".disabled")).to.have.length.of(0);

> packages/core/test/setup-jsdom.js
4: // @see https://github.com/facebook/react/issues/5046

> packages/core/test/oneOf_test.js
31:     expect(node.querySelectorAll("select")).to.have.length.of(0);
180:     expect(node.querySelectorAll("#root_bar")).to.have.length.of(0);
188:     expect(node.querySelectorAll("#root_foo")).to.have.length.of(0);
407:     expect(node.querySelector("select").value).eql("0");
451:     expect($select.value).eql("0");

> packages/core/test/mocha.opts
1: --timeout 5000

> packages/core/test/allOf_test.js
47:     expect(node.querySelectorAll("input")).to.have.length.of(0);

> packages/core/test/Form_test.js
138:       for (var i = 0, len = inputs.length; i < len; i++) {
163:       for (var i = 0, len = inputs.length; i < len; i++) {
173:         $schema: "http://json-schema.org/draft-06/schema#",
219:       for (var i = 0, len = inputs.length; i < len; i++) {
350:       let submitCount = 0;
366:       buttons[0].click();
565:       expect(node.querySelector("input[type=number]").value).eql("0");
589:       expect(node.querySelector("#root_children_0_name")).to.not.exist;
593:       expect(node.querySelector("#root_children_0_name")).to.exist;
683:       // Refs bug #140
709:       // Refs bug #140
1105:       const falseyValues = [0, false, null, undefined, NaN];
1362:           expect(node.querySelectorAll(".field-error")).to.have.length.of(0);
1384:           Simulate.change(node.querySelectorAll("input[type=text]")[0], {
1400:           expect(node.querySelectorAll(".field-error")).to.have.length.of(0);
1496:               value[0].message === "should NOT be shorter than 8 characters"
1718:         expect(fieldNodes[0].classList.contains("field-error")).eql(false);
1814:             property: ".outer[0][1]",
1816:             stack: ".outer[0][1] should NOT be shorter than 4 characters",
1822:             property: ".outer[1][0]",
1824:             stack: ".outer[1][0] should NOT be shorter than 4 characters",
2187:       expect(node.querySelectorAll("input:disabled")).to.have.length.of(0);
2355:           $schema: "http://json-schema.org/draft-04/schema#",
2369:             'no schema with key or ref "http://json-schema.org/draft-04/schema#"',
2377:           require("ajv/lib/refs/json-schema-draft-04.json"),
2407:             'no schema with key or ref "http://json-schema.org/draft-04/schema#"',
2731:           { title: "title0", details: "details0" },
2744:         "list.0.title",
2749:         list: [{ title: "title0" }, { details: "details1" }],
2789:             anotherThingNested2: 0,
2861:           "0": {
2862:             $name: "address_list.0",
2864:               $name: "address_list.0.city",
2867:               $name: "address_list.0.state",
2870:               $name: "address_list.0.street_address",
2891:           "address_list.0.city",
2892:           "address_list.0.state",
2893:           "address_list.0.street_address",

> packages/core/test/validate_test.js
64:         expect(errors[0].message).eql("should be string");
70:         expect(errorSchema.foo.__errors[0]).eql("should be string");
72:         expect(errorSchema[illFormedKey].__errors[0]).eql("should be string");
83:             multipleOf: 0.01,
84:             minimum: 0,
92:         const result = validateFormData({ price: 0.14 }, schema);
97:         expect(errors).to.have.length.of(0);
104:         $schema: "http://json-schema.org/draft-04/schema#",
118:       const metaSchemaDraft4 = require("ajv/lib/refs/json-schema-draft-04.json");
119:       const metaSchemaDraft6 = require("ajv/lib/refs/json-schema-draft-06.json");
127:           'no schema with key or ref "http://json-schema.org/draft-04/schema#"';
128:         expect(errors.errors[0].stack).to.equal(errMessage);
147:         expect(errors.errors[0].stack).to.equal(
160:         expect(errors.errors[0].stack).to.equal(
178:         const result = validateFormData({ phone: "800.555.2368" }, schema);
179:         expect(result.errors.length).eql(0);
184:           { phone: "800.555.2368" },
193:         expect(result.errors[0].stack).to.equal(
217:         expect(result.errors[0].stack).to.equal(
250:         expect(errors[0].stack).eql("pass2: passwords don't match.");
255:         expect(errorSchema.pass2.__errors[0]).eql("passwords don't match.");
273:         expect(result.errors).to.have.length.of(0);
281:         expect(result.errors).to.have.length.of(0);
306:         expect(errors[0].name).eql("type");
307:         expect(errors[0].property).eql(".properties['foo'].required");
308:         expect(errors[0].schemaPath).eql("#/definitions/stringArray/type"); // TODO: This schema path is wrong due to a bug in ajv; change this test when https://github.com/epoberezkin/ajv/issues/512 is fixed.
309:         expect(errors[0].message).eql("should be array");
316:         expect(errorSchema.properties.foo.required.__errors[0]).eql(
358:       return [Object.assign({}, errors[0], { message: newErrorMessage })];
375:       expect(errors[0].message).to.equal(newErrorMessage);
442:               minLength: 10,
466:             ".foo should NOT be shorter than 10 characters"
473:               message: "should NOT be shorter than 10 characters",
475:               params: { limit: 10 },
478:               stack: ".foo should NOT be shorter than 10 characters",
713:           expect(node.querySelectorAll(".errors li")).to.have.length.of(0);
741:       const formData = 0;
752:           <div className={"ErrorSchema"}>{errorSchema.__errors[0]}</div>
791:         $schema: "http://json-schema.org/draft-04/schema#",
812:             require("ajv/lib/refs/json-schema-draft-04.json"),
836:         expect(node.querySelectorAll(".errors li")).to.have.length.of(0);

> packages/core/docs/form-customization.md
113: ![](https://i.imgur.com/VF5tY60.png)
123:         yearsRange: [1980, 2030],
479:         <input type="radio" name="0.005549338200675935" value="true"><span>Enable</span>
486:         <input type="radio" name="0.005549338200675935" value="false"><span>Disable</span>

> packages/core/playground/app.js
147:               step="0.00001"
157:               step="0.00001"
213:           height={400}
335:     if (hash && typeof hash[1] === "string" && hash[1].length > 0) {

> packages/core/test/utils_test.js
53:       it("should keep existing form data that is equal to 0", () => {
60:             0
62:         ).to.eql(0);
1059:                       default: 0,
1068:                               enum: [0],
1083:               bit_rate_cfg_mode: 0,
1105:                       default: 0,
1114:                               enum: [0],
1169:     it("should not convert the value to an integer if the input ends with a 0", () => {
1170:       // this is to allow users to input 3.07
1171:       expect(asNumber("3.0")).eql("3.0");
1174:     it("should allow numbers with a 0 in the first decimal place", () => {
1175:       expect(asNumber("3.07")).eql(3.07);
1651:       const schema = { $ref: "#/definitions/a~0complex~1name" };
2745:           "0": {
2746:             $name: "list.0",
2748:               $name: "list.0.a",
2751:               $name: "list.0.b",
2754:               $name: "list.0.c",
2882:           "0": {
2883:             $name: "address_list.0",
2885:               $name: "address_list.0.city",
2888:               $name: "address_list.0.state",
2891:               $name: "address_list.0.street_address",
3100:           "0": {
3101:             $name: "defaultsAndMinItems.0",
3118:           "0": {
3119:             $name: "fixedItemsList.0",
3130:           "0": {
3131:             $name: "fixedNoToolbar.0",
3145:           "0": {
3146:             $name: "listOfObjects.0",
3148:               $name: "listOfObjects.0.id",
3151:               $name: "listOfObjects.0.name",
3175:           "0": {
3176:             $name: "listOfStrings.0",
3184:           "0": {
3185:             $name: "minItemsList.0",
3187:               $name: "minItemsList.0.name",
3205:           "0": {
3206:             $name: "multipleChoicesList.0",
3214:           "0": {
3215:             $name: "nestedList.0",
3216:             "0": {
3217:               $name: "nestedList.0.0",
3220:               $name: "nestedList.0.1",
3225:             "0": {
3226:               $name: "nestedList.1.0",
3232:           "0": {
3233:             $name: "noToolbar.0",
3241:           "0": {
3242:             $name: "unorderable.0",
3250:           "0": {
3251:             $name: "unremovable.0",
3282:         hour: 0,
3283:         minute: 0,
3284:         second: 0,
3289:       expect(parseDateString("2016-04-05T14:01:30.182Z")).eql({
3290:         year: 2016,
3295:         second: 30,
3300:       expect(parseDateString("2016-04-05T14:01:30.182Z", false)).eql({
3301:         year: 2016,
3304:         hour: 0,
3305:         minute: 0,
3306:         second: 0,
3315:           year: 2016,
3320:           second: 30,
3322:       ).eql("2016-04-05T14:01:30.000Z");
3329:             year: 2016,
3335:       ).eql("2016-04-05");
3340:     it("should pad a string with 0s", () => {
3341:       expect(pad(4, 3)).eql("004");

> packages/core/docs/validation.md
76: To have your schemas validated against any other meta schema than draft-07 (the current version of [JSON Schema](http://json-schema.org/)), make sure your schema has a `$schema` attribute that enables the validator to use the correct meta schema. For example:
80:   "$schema": "http://json-schema.org/draft-04/schema#",
85: Note that react-jsonschema-form only supports the latest version of JSON Schema, draft-07, by default. To support additional meta schemas pass them through the `additionalMetaSchemas` prop to your `Form` component:
88: const additionalMetaSchemas = require("ajv/lib/refs/json-schema-draft-04.json");
96: In this example `schema` passed as props to `Form` component can be validated against draft-07 (default) and by draft-04 (added), depending on the value of `$schema` attribute.

> packages/core/test/uiSchema_test.js
980:             value: "#001122",
984:           formData: { foo: "#001122" },
1097:           minimum: 10,
1098:           maximum: 100,
1157:           expect(input.getAttribute("min")).eql("10");
1161:           expect(input.getAttribute("max")).eql("100");
1164:         it("should support '0' as minimum and maximum constraints", () => {
1167:             minimum: 0,
1168:             maximum: 0,
1176:           expect(input.getAttribute("min")).eql("0");
1177:           expect(input.getAttribute("max")).eql("0");
1240:           expect(input.getAttribute("min")).eql("10");
1244:           expect(input.getAttribute("max")).eql("100");
1247:         it("should support '0' as minimum and maximum constraints", () => {
1250:             minimum: 0,
1251:             maximum: 0,
1259:           expect(input.getAttribute("min")).eql("0");
1260:           expect(input.getAttribute("max")).eql("0");
1590:         expect(node.querySelectorAll("[type=radio]")[0]).not.eql(null);
1645:         Simulate.change(node.querySelectorAll("[type=radio]")[0], {
1808:       expect(ids).eql(["myform_0", "myform_1"]);
1849:         "myform_0_foo",
1850:         "myform_0_bar",

> packages/core/test/ArrayField_test.js
102:       expect(fieldset[0].id).eql("root");
190:       expect(matches[0].textContent).to.eql(
198:       expect(node.querySelectorAll(".field-string")).to.have.length.of(0);
262:       const startRow1_key = startRows[0].getAttribute(ArrayKeyDataAttr);
270:       const endRow1_key = endRows[0].getAttribute(ArrayKeyDataAttr);
277:       expect(endRows[0].hasAttribute(ArrayKeyDataAttr)).to.be.true;
336:       const startRow1_key = startRows[0].getAttribute(ArrayKeyDataAttr);
340:       Simulate.click(addBeforeButtons[0]);
341:       Simulate.click(addAfterButtons[0]);
352:       expect(endRows[0].hasAttribute(ArrayKeyDataAttr)).to.be.true;
405:       expect(inputs[0].value).eql("foo");
433:       Simulate.click(moveDownBtns[0]);
437:       expect(inputs[0].value).eql("bar");
453:       expect(inputs[0].value).eql("foo");
466:       const startRow1_key = startRows[0].getAttribute(ArrayKeyDataAttr);
470:       Simulate.click(moveDownBtns[0]);
473:       const endRow1_key = endRows[0].getAttribute(ArrayKeyDataAttr);
481:       expect(endRows[0].hasAttribute(ArrayKeyDataAttr)).to.be.true;
494:       const startRow1_key = startRows[0].getAttribute(ArrayKeyDataAttr);
501:       const endRow1_key = endRows[0].getAttribute(ArrayKeyDataAttr);
509:       expect(endRows[0].hasAttribute(ArrayKeyDataAttr)).to.be.true;
517:         for (let i = 0; i < 3; i++) {
553:       const startRow1_key = startRows[0].getAttribute(ArrayKeyDataAttr);
557:       const button = node.querySelector(".item-0 .array-item-move-to-2");
561:       expect(inputs[0].value).eql("bar");
566:       const endRow1_key = endRows[0].getAttribute(ArrayKeyDataAttr);
574:       expect(endRows[0].hasAttribute(ArrayKeyDataAttr)).to.be.true;
587:       expect(moveUpBtns[0].disabled).eql(true);
588:       expect(moveDownBtns[0].disabled).eql(false);
613:       Simulate.click(dropBtns[0]);
617:       expect(inputs[0].value).eql("bar");
627:       Simulate.click(deleteBtns[0]);
631:       Simulate.change(inputs[0], { target: { value: "fuzz" } });
633:       expect(inputs[0].value).eql("fuzz");
648:       Simulate.click(dropBtns[0]);
651:       const endRow1_key = endRows[0].getAttribute(ArrayKeyDataAttr);
654:       expect(endRows[0].hasAttribute(ArrayKeyDataAttr)).to.be.true;
690:       Simulate.click(dropBtns[0]);
694:       ).to.have.length.of(0);
748:       expect(inputs[0].id).eql("root_0");
776:       expect(inputs[0].id).eql("root_foo_0_bar");
777:       expect(inputs[1].id).eql("root_foo_0_baz");
811:       expect(inputs[0].value).eql("Default name");
832:       expect(inputs[0].value).to.eql("Raphael");
855:       expect(inputs[0].value).to.eql("Raphael");
879:       expect(inputs[0].value).to.eql("Raphael");
968:       expect(inputs.length).eql(0);
1071:         expect(options[0].selected).eql(true); // foo
1094:         expect(matches[0].textContent).to.eql(
1095:           "should NOT have duplicate items (items ## 1 and 0 are identical)"
1127:         Simulate.change(node.querySelectorAll("[type=checkbox]")[0], {
1197:         expect(matches[0].textContent).to.eql(
1274:       expect(li[0].textContent).eql("file1.txt (text/plain, 5 bytes)");
1306:       expect(matches[0].textContent).to.eql(
1379:       expect(matches[0].textContent).to.eql(
1444:       expect(strInput.id).eql("root_0");
1485:       Simulate.change(numInput, { target: { value: "101" } });
1488:         formData: ["bar", 101],
1596:       const startRow1_key = startRows[0].getAttribute(ArrayKeyDataAttr);
1617:         const endRow1_key = endRows[0].getAttribute(ArrayKeyDataAttr);
1628:         expect(endRows[0].hasAttribute(ArrayKeyDataAttr)).to.be.true;
1637:         Simulate.change(inputs[0], { target: { value: "bar" } });
1648:         Simulate.click(dropBtns[0]);
1657:         Simulate.click(dropBtns[0]);

> packages/core/docs/index.md
13: <a target=_blank href="https://www.browserstack.com/"><img height=200 src="https://user-images.githubusercontent.com/1689183/51487090-4ea04f80-1d57-11e9-9a91-79b7ef8d2013.png"></a>
23: Requires React 15.0.0+.
199: * `"additionalProperties":false` produces incorrect schemas when used with [schema dependencies](#schema-dependencies). This library does not remove extra properties, which causes validation to fail. It is recommended to avoid setting `"additionalProperties":false` when you use schema dependencies. See [#848](https://github.com/mozilla-services/react-jsonschema-form/issues/848) [#902](https://github.com/mozilla-services/react-jsonschema-form/issues/902) [#992](https://github.com/mozilla-services/react-jsonschema-form/issues/992)
236:  - 2 columns form with CSS and FieldTemplate: <https://jsfiddle.net/n1k0/bw0ffnz4/1/>
263: A live development server showcasing components with hot reload enabled is available at [localhost:8080](http://localhost:8080).
268: $ RJSF_DEV_SERVER=0.0.0.0:8000 npm start
275: $ pip install mkdocs==1.0.4
279: Documentation will be served by [localhost:8000](http://localhost:8000).
314: There is also special cased where you can use `oneOf` in [schema dependencies](dependencies.md#schema-dependencies), If you'd like to help improve support for these keywords, see the following issues for inspiration [#329](https://github.com/mozilla-services/react-jsonschema-form/pull/329) or [#417](https://github.com/mozilla-services/react-jsonschema-form/pull/417). See also: [#52](https://github.com/mozilla-services/react-jsonschema-form/issues/52), [#151](https://github.com/mozilla-services/react-jsonschema-form/issues/151), [#171](https://github.com/mozilla-services/react-jsonschema-form/issues/171), [#200](https://github.com/mozilla-services/react-jsonschema-form/issues/200), [#282](https://github.com/mozilla-services/react-jsonschema-form/issues/282), [#302](https://github.com/mozilla-services/react-jsonschema-form/pull/302), [#330](https://github.com/mozilla-services/react-jsonschema-form/issues/330), [#430](https://github.com/mozilla-services/react-jsonschema-form/issues/430), [#522](https://github.com/mozilla-services/react-jsonschema-form/issues/522), [#538](https://github.com/mozilla-services/react-jsonschema-form/issues/538), [#551](https://github.com/mozilla-services/react-jsonschema-form/issues/551), [#552](https://github.com/mozilla-services/react-jsonschema-form/issues/552), or [#648](https://github.com/mozilla-services/react-jsonschema-form/issues/648).
320: A: Probably not. We use Bootstrap v3 and it works fine for our needs. We would like for react-jsonschema-form to support other frameworks, we just don't want to support them ourselves. Ideally, these frontend styles could be added to react-jsonschema-form with a third-party library. If there is a technical limitation preventing this, please consider opening a PR. See also: [#91](https://github.com/mozilla-services/react-jsonschema-form/issues/91), [#99](https://github.com/mozilla-services/react-jsonschema-form/issues/99), [#125](https://github.com/mozilla-services/react-jsonschema-form/issues/125), [#237](https://github.com/mozilla-services/react-jsonschema-form/issues/237), [#287](https://github.com/mozilla-services/react-jsonschema-form/issues/287), [#299](https://github.com/mozilla-services/react-jsonschema-form/issues/299), [#440](https://github.com/mozilla-services/react-jsonschema-form/issues/440), [#461](https://github.com/mozilla-services/react-jsonschema-form/issues/461), [#546](https://github.com/mozilla-services/react-jsonschema-form/issues/546), [#555](https://github.com/mozilla-services/react-jsonschema-form/issues/555), [#626](https://github.com/mozilla-services/react-jsonschema-form/issues/626), and [#623](https://github.com/mozilla-services/react-jsonschema-form/pull/623).
324: A: There's no specific built-in way to do this, but you can write your own FieldTemplate that supports hiding/showing fields according to user input. See the "tips and tricks" section above for one example implementation. See also: [#268](https://github.com/mozilla-services/react-jsonschema-form/issues/268), [#304](https://github.com/mozilla-services/react-jsonschema-form/pull/304), [#598](https://github.com/mozilla-services/react-jsonschema-form/issues/598), [#920](https://github.com/mozilla-services/react-jsonschema-form/issues/920).

> packages/core/test/NumberField_test.js
40:           minimum: 0,
44:       expect(node.querySelector("input").min).to.eql("0");
51:           maximum: 100,
55:       expect(node.querySelector("input").max).to.eql("100");
73:           minimum: 0,
77:       expect(node.querySelector("input").min).to.eql("0");
84:           maximum: 100,
88:       expect(node.querySelector("input").max).to.eql("100");
231:             input: "2.0",
239:             input: "2.30",
243:             input: "2.300",
247:             input: "2.3001",
248:             output: 2.3001,
251:             input: "2.03",
252:             output: 2.03,
255:             input: "2.003",
256:             output: 2.003,
259:             input: "2.00300",
260:             output: 2.003,
263:             input: "200300",
264:             output: 200300,
293:           target: { value: ".00" },
297:           formData: 0,
299:         expect($input.value).eql(".00");
310:           formData: 2.03,
315:         expect($input.value).eql("2.03");
319:           formData: 203,
322:         expect($input.value).eql("203");
350:           target: { value: "2.0" },
352:         expect(node.querySelector(".field input").value).eql("2.0");
355:           target: { value: "2.00" },
357:         expect(node.querySelector(".field input").value).eql("2.00");
360:           target: { value: "2.000" },
362:         expect(node.querySelector(".field input").value).eql("2.000");
374:           target: { value: "0" },
376:         expect(node.querySelector(".field input").value).eql("0");
426:       expect(spy.lastCall.args[0].formData).eql(1);
498:             enum: [0],
508:       expect(selects[0].value).eql("");
512:       expect(options[0].innerHTML).eql("");
532:       expect(selects[0].value).eql("2");
536:       expect(options[0].innerHTML).eql("2");
539:     it("should render a select element without a blank option, if the default value is 0.", () => {
545:             enum: [0],
546:             default: 0,
556:       expect(selects[0].value).eql("0");
560:       expect(options[0].innerHTML).eql("0");

> packages/core/docs/advanced-customization.md
363: > Note: Prior to v0.35.0, the `options` prop contained the list of options (`label` and `value`) for `enum` fields. Since v0.35.0, it now exposes this list as the `enumOptions` property within the `options` object.
398: > Note: Until 0.40.0 it was possible to register a widget as object with shape `{ component: MyCustomWidget, options: {...} }`. This undocumented API has been removed. Instead, you can register a custom widget with a React `defaultProps` property. `defaultProps.options` can be an object containing your custom options.
437: > Note: Since v0.41.0, the `ui:widget` object API, where a widget and options were specified with `"ui:widget": {component, options}` shape, is deprecated. It will be removed in a future release.

> packages/semantic-ui/src/TextAreaWidget/TextAreaWidget.js
25:   const error = rawErrors && rawErrors.length > 0 ? { content: rawErrors[0], pointing } : false;

> packages/core/src/utils.js
257:           const defaultsLength = defaults ? defaults.length : 0;
304:   if (formData === 0 || formData === false || formData === "") {
347:     .filter(key => key.indexOf("ui:") === 0)
404:   if (/\.0$/.test(value)) {
405:     // we need to return this as a string here, to allow for input like 3.07
411:   if (/\.\d*0$/.test(value)) {
434:       : `property '${arr[0]}'`;
473:     return schema.enum[0];
512:     schema.items.length > 0 &&
547:       part = part.replace(/~1/g, "/").replace(/~0/g, "~");
813:       return errors.length === 0;
822:   const subschema = validSubschemas[0];
906:     if (ka.length === 0 && kb.length === 0) {
924:     for (var j = ka.length - 1; j >= 0; j--) {
931:     for (let k = ka.length - 1; k >= 0; k--) {
1024:       hour: includeTime ? -1 : 0,
1025:       minute: includeTime ? -1 : 0,
1026:       second: includeTime ? -1 : 0,
1037:     hour: includeTime ? date.getUTCHours() : 0,
1038:     minute: includeTime ? date.getUTCMinutes() : 0,
1039:     second: includeTime ? date.getUTCSeconds() : 0,
1044:   { year, month, day, hour = 0, minute = 0, second = 0 },
1049:   return time ? datetime : datetime.slice(0, 10);
1055:     s = "0" + s;
1064:   const params = splitted[0].split(";");
1066:   const type = params[0].replace("data:", "");
1069:     return param.split("=")[0] === "name";
1078:     name = properties[0].split("=")[1];
1084:   for (let i = 0; i < binary.length; i++) {
1098:   if (schema.minimum || schema.minimum === 0) {
1101:   if (schema.maximum || schema.maximum === 0) {
1108:   for (let i = 0; i < options.length; i++) {
1166:   return 0;

> packages/semantic-ui/src/ArrayFieldTemplate/ArrayFieldTemplate.js
33:   marginBottom: '0px',
37:   marginBottom: '10px',

> packages/core/src/validate.js
23:     /^data:([a-z]+\/[a-z0-9-+.]+)?;(?:name=(.*);)?base64,(.*)$/
27:     /^(#?([0-9A-Fa-f]{3}){1,2}\b|aqua|black|blue|fuchsia|gray|green|lime|maroon|navy|olive|orange|purple|red|silver|teal|white|yellow|(rgb\(\s*\b([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\b\s*,\s*\b([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\b\s*,\s*\b([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\b\s*\))|(rgb\(\s*(\d?\d%|100%)+\s*,\s*(\d?\d%|100%)+\s*,\s*(\d?\d%|100%)+\s*\)))$/
58:     if (path.length > 0 && path[0] === "") {
59:       path.splice(0, 1);
62:     for (const segment of path.slice(0)) {
213:   // Clear errors to prevent persistent errors, see #1104

> packages/semantic-ui/src/UpDownWidget/UpDownWidget.js
23:   const error = rawErrors && rawErrors.length > 0 ? { content: rawErrors[0], pointing } : false;

> packages/semantic-ui/src/CheckboxesWidget/CheckboxesWidget.js
8:   const updated = selected.slice(0, at).concat(value, selected.slice(at));
64:             autoFocus={autofocus && index === 0}

> packages/semantic-ui/src/SelectWidget/SelectWidget.js
85:   const error = rawErrors && rawErrors.length > 0 ? { content: rawErrors[0], pointing } : false;

> packages/semantic-ui/src/RawErrors/RawErrors.js
16:   if (displayError && errors && errors.length > 0) {

> packages/semantic-ui/src/TextWidget/TextWidget.js
25:     rawErrors && rawErrors.length > 0
26:       ? { content: rawErrors[0], pointing }

> packages/semantic-ui/src/RadioWidget/RadioWidget.js
25:   const error = rawErrors && rawErrors.length > 0 ? { content: rawErrors[0], pointing } : false;

> packages/semantic-ui/src/PasswordWidget/PasswordWidget.js
24:   const error = rawErrors && rawErrors.length > 0 ? { content: rawErrors[0], pointing } : false;

> packages/semantic-ui/src/RangeWidget/RangeWidget.js
25:   const error = rawErrors && rawErrors.length > 0 ? { content: rawErrors[0], pointing } : false;

> packages/semantic-ui/src/CheckboxWidget/CheckboxWidget.js
22:   const error = rawErrors && rawErrors.length > 0 ? { content: rawErrors[0], pointing } : false;

> packages/core/playground/samples/custom.js
19:     lat: 0,
20:     lon: 0,

> packages/core/playground/samples/ordering.js
45:     bio: "Roundhouse kicking asses since 1940",

> packages/core/playground/samples/nullable.js
33:         minLength: 10,

> packages/core/playground/samples/large.js
3:   for (let i = 0; i < n; i++) {
12:       largeEnum: { type: "string", enum: largeEnum(100) },
30:       choice10: { $ref: "#/definitions/largeEnum" },

> packages/core/playground/samples/numbers.js
28:         maximum: 100,
31:         title: "Integer range (by 10)",
33:         minimum: 50,
34:         maximum: 100,
35:         multipleOf: 10,
61:     integerRangeSteps: 80,

> packages/core/playground/samples/customObject.js
53:         minLength: 10,
61:     bio: "Roundhouse kicking asses since 1940",

> packages/core/playground/samples/errorSchema.js
33:         minLength: 10,
66:     bio: "Roundhouse kicking asses since 1940",

> packages/material-ui/src/CheckboxesWidget/CheckboxesWidget.tsx
13:   const updated = selected.slice(0, at).concat(value, selected.slice(at));
72:               autoFocus={autofocus && index === 0}

> packages/core/playground/samples/alternatives.js
10:             enum: ["#ff0000"],
15:             enum: ["#00ff00"],
20:             enum: ["#0000ff"],
84:     currentColor: "#00ff00",
85:     colorMask: ["#0000ff"],
86:     colorPalette: ["#ff0000"],

> packages/material-ui/src/FieldTemplate/FieldTemplate.tsx
27:       {rawErrors.length > 0 && (

> packages/core/playground/samples/simple.js
33:         minLength: 10,
66:     bio: "Roundhouse kicking asses since 1940",

> packages/core/playground/samples/date.js
44:           yearsRange: [1980, 2030],
50:           yearsRange: [1980, 2030],

> packages/core/src/components/Form.js
140:     if (fields.length === 0 && typeof formData !== "object") {
270:       if (Object.keys(errors).length > 0) {

> packages/core/src/components/AddButton.js
12:           tabIndex="0"

> packages/core/src/components/fields/ObjectField.js
119:     var index = 0;
166:         return 0;

> packages/core/src/components/fields/MultiSchemaField.js
49:     if (option !== 0) {
54:     return this && this.state ? this.state.selectedOption : 0;
58:     const selectedOption = parseInt(option, 10);
96:       selectedOption: parseInt(option, 10),
146:             schema={{ type: "number", default: 0 }}

> packages/core/src/components/fields/BooleanField.js
47:         (schema.enum && schema.enum[0] === false

> packages/core/src/components/widgets/CheckboxWidget.js
13:   if (schema.enum && schema.enum.length === 1 && schema.enum[0] === true) {
19:     return schemaRequiresTrueValue(schema.anyOf[0]);
24:     return schemaRequiresTrueValue(schema.oneOf[0]);

> packages/core/src/components/fields/ArrayField.js
310:       newKeyedFormData.splice(index, 0, newKeyedFormDataRow);
383:         _newKeyedFormData.splice(newIndex, 0, keyedFormData[index]);
402:         // See https://github.com/tdegrunt/jsonschema/issues/206
489:           canMoveUp: index > 0,
496:           autofocus: autofocus && index === 0,
688:           autofocus: autofocus && index === 0,

> packages/core/src/components/widgets/AltDateWidget.js
38:       options={{ enumOptions: rangeOptions(range[0], range[1]) }}
57:       yearsRange: [1900, new Date().getFullYear() + 2],
119:         { type: "hour", range: [0, 23], value: hour },
120:         { type: "minute", range: [0, 59], value: minute },
121:         { type: "second", range: [0, 59], value: second }
149:               autofocus={autofocus && i === 0}

> packages/core/src/components/fields/NumberField.js
7: // digits followed by any number of 0 characters up until the end of the line.
9: // you don't incorrectly match against "0".
10: const trailingCharMatcherWithPrefix = /\.([0-9]*0)*$/;
12: // This is used for trimming the trailing 0 and . characters without affecting
16: const trailingCharMatcher = /[0.]0*$/;
50:     if (`${value}`.charAt(0) === ".") {
51:       value = `0${value}`;
75:       // or more '0' characters
76:       const re = new RegExp(`${value}`.replace(".", "\\.") + "\\.?0*$");

> packages/core/src/components/widgets/BaseInput.js
5:   // Note: since React 15.2.0 we can't forward unknown element attributes, so we

> packages/core/src/components/fields/SchemaField.js
101:   if (errors.length === 0) {
217:             style={{ border: "0" }}
259:   if (Object.keys(schema).length === 0) {
320:     errors && errors.length > 0 ? "field-error has-error has-danger" : "",

> packages/core/src/components/widgets/CheckboxesWidget.js
6:   const updated = selected.slice(0, at).concat(value, selected.slice(at));
34:               autoFocus={autofocus && index === 0}

> packages/core/src/components/widgets/DateTimeWidget.js
14:   // Note - date constructor passed local ISO-8601 does not correctly

> packages/core/src/components/widgets/RadioWidget.js
21:   // this is a temporary fix for radio button rendering bug in React, facebook/react#7630.
39:               autoFocus={autofocus && i === 0}

> packages/core/src/components/widgets/FileWidget.js
33:   if (filesInfo.length === 0) {
86:           onChange(state.values[0]);

> packages/material-ui/src/ObjectFieldTemplate/ObjectFieldTemplate.tsx
10:     marginTop: 10,
47:             style={{ marginBottom: '10px' }}
