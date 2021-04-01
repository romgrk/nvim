" Description: vim keymap
" Last Modified: 27 April 2016
" !::exe [So]


" Recent mappings:
"

xmap <C-W>sr <Plug>(Visual-Split-VSResize)
xmap <C-W>ss <Plug>(Visual-Split-VSSplit)
xmap <C-W>sk <Plug>(Visual-Split-VSSplitAbove)
xmap <C-W>sj <Plug>(Visual-Split-VSSplitBelow)

nnoremap <silent><space>.       :Clap blines<CR>
nnoremap <silent><space><space> :Clap  grep<CR>

nnoremap ]q   :cnext<CR>
nnoremap [q   :cprevious<CR>
nnoremap ]l   :lnext<CR>
nnoremap [l   :lprevious<CR>
nnoremap ]c   /^<<<<CR>:set nohls<CR>
nnoremap [c   ?^<<<<CR>:set nohls<CR>


"===============================================================================
" Major maps                                                                {{{1

let mapleader = "\<space>"

" <Esc>
nnoremap <silent><expr> <Esc> (
            \   exists('b:esc') ? b:esc :
            \   coc#float#has_float() ? (coc#float#close_all() . '')[1] :
            \  ':nohl<CR>' )

" <CR>
"cnoremap <expr> <CR> g:space.parse_cmd_line()


" V cycles visual modes
nnoremap       v v
xnoremap <expr>v
            \ (mode() ==# 'v' ? "\<C-V>"
            \ : mode() ==# 'V' ? 'v' : 'V')


nnoremap Y  y$

" nnoremap u u
" nnoremap U <C-R>
nmap    . <Plug>(RepeatDot)
" nmap    u <Plug>(RepeatUndo)
nnoremap    u u
nnoremap    U <C-r>
nmap    <Plug>(ignore-1) <Plug>(RepeatDot)
nmap    <Plug>(ignore-2) <Plug>(RepeatUndo)
nmap    <Plug>(ignore-3) <Plug>(RepeatRedo)
nmap    <Plug>(ignore-4) <Plug>(RepeatUndoLine)

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
nnoremap <C-r>   gR
xnoremap <C-r>   r<space>gR

" Next/Previous Tab
nnoremap g[ gT
nnoremap g] gt

" Open
nnoremap <silent> go  :<C-U>OpenURLOrSearch<CR>
xnoremap <silent> go y:<C-U>OpenURLOrSearch <C-R>"<CR>


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

" Remove things we don't use
vmap <C-f> <Nop>
vmap <C-b> <Nop>

" }}}1
"===============================================================================
" Semicolon quick commands                                                  {{{1

" Semicolon key
nmap   <expr>   ;    <SID>quick_cmd()

imap ;w <Esc>;w

let s:quick_cmd_map = {
\ 'w':       ":w\<CR>",
\ "\<C-F>":  ':Files',
\ "\<A-;>":  'q:":P',
\}

function! s:quick_cmd ()
    if sneak#is_sneaking() " return maparg('<Plug>SneakNext', 'n')
        return ":call sneak#rpt('', 0)\<CR>"
    end
    echo ''
    let char = GetChar('Info', ':')
    let qmap = get(s:quick_cmd_map, char, ':' . char)
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
nmap gsln           :execute 'Note ' . GetCurrentSession()<CR>

" Files
nnoremap gsrc       :Edit $MYVIMRC<CR>
nnoremap gsro       :Edit $vim/coc-settings.json<CR>
nnoremap gsm        :Edit $vim/rc/keymap.vim<CR>
nnoremap gsko       :Edit $vim/plugin/options.vim<CR>
nnoremap gsa        :Edit $vim/rc/autocmd.vim<CR>
nnoremap gse        :Edit $vim/rc/events.vim<CR>
nnoremap gsf        :Edit $vim/rc/function.vim<CR>
nnoremap gsd        :Edit $vim/rc/commands.vim<CR>
nnoremap gsc        :Edit $vim/rc/colors.vim<CR>
nnoremap gsh        :Edit $vim/rc/highlight.vim<CR>
nnoremap gso        :Edit $vim/rc/settings.vim<CR>
nnoremap gsjg       :Edit $HOME/github/github-light.vim/colors/github-light.vim<CR>
nnoremap gsjd       :Edit $HOME/github/doom-one.vim/colors/doom-one.vim<CR>
nnoremap gsp        :Edit $vim/rc/plugins.vim<CR>
nnoremap gsP        :Clap filer $vim/rc/plugins/<CR>
nnoremap gsv        :Clap files $vim<CR>

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
noremap  <A-j> 5<Down>
noremap  <A-k> 5<Up>
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
nnoremap H <C-O>zz
nnoremap L <C-I>zz


" no noremap: remapped to matchit
nmap <Tab> %
vmap <Tab> %
omap <Tab> %

" Character-wise jumps always
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


nmap <silent> <leader>coc :Clap coc_commands<CR>
nmap <silent> <F2>       :call CocAction('rename')<CR>

" xmap <silent> gme    :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
" nmap <silent> gme    :<C-u>CocCommand actions.open<CR>


" Coc Diagnostics
nnoremap <silent>[d  <Plug>(coc-diagnostic-previous)
nnoremap <silent>]d  <Plug>(coc-diagnostic-next)
nnoremap <silent>[e  <Plug>(coc-diagnostic-previous-error)
nnoremap <silent>]e  <Plug>(coc-diagnostic-next-error)


" Remap keys for gotos
nmap <silent> gd     <Plug>(coc-definition)zz
nmap <silent> gy     <Plug>(coc-type-definition)zz
nmap <silent> gD     <Plug>(coc-implementation)zz
nmap <silent> gR     <Plug>(coc-references)
nmap <silent> g<A-r> <Plug>(coc-references-used)

" Use K for show documentation in preview window
nnoremap <silent> K     :call <SID>show_documentation()<CR>
inoremap <silent> <C-k> <C-O>:call coc#float#jump()<CR>
inoremap <silent> <A-u> <C-O>:call coc#float#scroll(-1)<CR>
inoremap <silent> <A-d> <C-O>:call coc#float#scroll(+1)<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
    return
  end
  if !empty(win#filter('getwinvar(v:val, "float")'))
    call coc#float#jump()
    call s:coc_popup_mappings()
  else
    call CocAction('doHover')
  end
endfunction

function! s:coc_popup_mappings ()
  nnoremap <silent><buffer> <Esc> :call coc#float#close_all()<CR>
endfunc


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
nnoremap <silent><leader>op        :OptionsWidget<CR>

nunmap <leader>ac
nunmap <leader>a


"===============================================================================

" Session management:
nnoremap   <expr><leader>ss     xolox#session#find_current_session() != 'default' ?
                              \ ":wall! \<Bar> SaveSession\<CR>\<Esc>" : ":wall! \<Bar> SaveSession\<space>"
nnoremap <silent><leader>sS     :SaveSession!<space>
nnoremap <silent><leader>so     :Clap session<CR>
nnoremap <silent><leader>sd     :OpenSession! default<CR>
nnoremap <silent><leader>sc     :wall! <Bar> CloseSession<CR>
nnoremap <silent><leader>si     :wall! <Bar> CloseSession <Bar> OpenSession! <C-D>

nnoremap <silent><leader>sl     :SourceLocalVimrc<CR>
nnoremap <silent><leader>sn     :Note <C-R>=xolox#session#find_current_session()<CR><CR>


nnoremap <silent><leader>np     :NewProject<space>

" Notes:
nnoremap <silent><leader>no     :Clap note<CR>

" Git:

nnoremap <silent><leader>gg     :tabedit %<CR>:Git<CR><C-W>o
nnoremap <silent><leader>gaa    :Git add --all<CR>
nnoremap <silent><leader>ga.    :Git add %<CR>
nnoremap         <leader>gcm    :Git commit -m ""<Left>
nnoremap         <leader>gcam   :Git commit -am ""<Left>
nnoremap         <leader>g.     :Git commit % -m ""<Left>
nnoremap         <leader>gk     :Git checkout<space>
nnoremap         <leader>gK     :Git checkout -b<space>
nnoremap         <leader>gb     :Clap git_branch<CR>
nnoremap         <leader>gl     :Git pull<CR>
nnoremap         <leader>gp     :EchoHL ErrorMsg Remaped to SPC g p p<CR>
nnoremap         <leader>gpp    :Git push<CR>
nnoremap         <leader>gpf    :Git push --force<CR>
nnoremap         <leader>gpu    :Git push -u origin <C-R>=trim(system('git rev-parse --abbrev-ref HEAD'))<CR><CR>
nnoremap <silent><leader>gs     :Gstatus<CR>
nnoremap <silent><leader>gu     :GitOpenUnmergedFiles<CR>
nnoremap <silent><leader>gda    :GitDiff<CR>
nnoremap <silent><leader>gd.    :GitDiff %<CR>
nnoremap         <leader>gdd    :GitDiff<space>
nnoremap         <leader>gr.    :Git restore %<CR>
nnoremap         <leader>grA    :Git restore .<CR>

" GitMessenger:
nnoremap <silent><leader>gm     :GitMessenger<CR>

" GitGutter:
nnoremap <silent><leader>hh     :GitGutter
nnoremap <silent><leader>hs     :GitGutterStageHunk<CR>
nnoremap <silent><leader>hv     :GitGutterPreviewHunk<CR>
nnoremap <silent><leader>hu     :GitGutterUndoHunk<CR>

" Open in Github:
nnoremap <silent><leader>gh     :GH<CR>

"===============================================================================
" Ack, Ag, Grep & File Searching

" Files:
nnoremap <silent><leader>md     :Mkdir! <C-D>
nnoremap <silent><leader>mv     :Move <A-i>d/
nnoremap <silent><leader>rn     :Rename<space>

" Search:
" nnoremap <silent><leader>ag     XXX implement search
" nnoremap <silent><leader>aa     XXX implement search

"===============================================================================
" Window things

nnoremap <silent><leader>ww   :InteractiveWindow<CR>

nnoremap <silent><leader>w-   :call SizeDown()<CR>
nnoremap <silent><leader>w+   :call SizeUp()<CR>

"===============================================================================

" Various:

nnoremap <silent><leader>mp   :MarkdownPreview<CR>
nnoremap <silent><leader>mP   :MarkdownPreviewStop<CR>

nnoremap <silent><leader>cp   :VCoolor<CR>
nnoremap   <expr><leader>c-   '"_ciw' . color#Darken(expand('<cword>')) . "\<Esc>"
nnoremap   <expr><leader>c=   '"_ciw' . color#Lighten(expand('<cword>')) . "\<Esc>"

nnoremap <silent><leader>gf   :NERDTreeFind<CR>

nnoremap <silent><leader>ap   vip:EasyAlign<CR>
nnoremap <silent><leader>ret  :set et <Bar> ret<CR>
nnoremap <silent><leader>dws  :%DeleteTrailingWS<CR>

nnoremap         <leader>how  :r !howdoi<space>

nnoremap <silent><leader>syv  :SynStack<CR>
nnoremap <silent><leader>sye  :SynCurrentEdit<CR>

nnoremap <silent><leader>ti   :Todoist<CR>
nnoremap <silent><leader>to   :Clap todoist<CR>

nnoremap <silent><leader>td   :OpenTodo<CR>

nnoremap <silent><leader>npm  :Clap npm<CR>

nnoremap <silent><leader>qr   :call QuickReload()<CR>
nnoremap <expr>  <leader>qo   expand('%:e') == 'vim' ? ':So<CR>' : ':luafile %<CR>'
nmap     <silent><leader>qw   :w<CR><F5>

nnoremap         <leader>up   :PlugUpdate <Bar> CocUpdate<CR>

nnoremap <silent><leader>hh   :Clap help_tags<CR>


" Multi-Cursors:
" (see: ./plugins/multiple-cursors.vim)
nnoremap      <leader>mw :.,.MultipleCursorsFind \S\+<CR>o<Esc>
nnoremap      <leader>mW :.,.MultipleCursorsFind \w\+<CR>
nnoremap      <leader>mf :MultipleCursorsFind<space>

" }}}1
"===============================================================================
" Panels, File navigation & Clap                                       {{{1


nnoremap <silent><C-\>   :NERDTreeToggle<CR>
nnoremap <silent><C-A-\> :NERDTreeFind<CR>
nnoremap <silent><C-A-T> :TagbarToggle<CR>
nnoremap <silent><C-A-L> :call ToggleWindows()<CR>

nnoremap <silent> <A-o>    :Clap files <C-R>=getcwd()<CR><CR>
nnoremap <silent> <C-A-o>  :Clap filer <C-R>=escape(expand("%:p:h"), ' ')<CR><CR>

nnoremap <silent> <A-S-o>  :Clap mrufiles<CR>
" nnoremap <silent> <C-S>    :Clap buffers<CR>

nnoremap <silent> <A-i>    :Clap tags<CR>
" nnoremap <silent> <A-S-I>  :Clap generated_tags<CR>
" nnoremap <silent> <A-S-I>  :Clap tagfiles<CR>
nnoremap <silent> <A-S-I>  :Clap coc_symbols<CR>


nnoremap <silent> <C-p>    :Clap command<CR>

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
nnoremap <C-w>q     :BufferClose! <Bar> wincmd c<CR>

nnoremap <C-w><Tab> :tabedit <C-r>=bufname()<CR><CR>

" Terminal navigation mappings down here. }}}1
"===============================================================================
" Terminal                                                            @term {{{1
if has('nvim')

" Panels/Navigation
nnoremap g:             :GoFirstTerminalWindow<CR>
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


tnoremap <A-;>     ;

end "of has('nvim') }}}1
"===============================================================================
" Buffer navigation                                                         {{{1

nnoremap <silent> <A-,> :BufferPrevious<CR>
nnoremap <silent> <A-.> :BufferNext<CR>
nnoremap <silent> <A-<> :BufferMovePrevious<CR>
nnoremap <silent> <A->> :BufferMoveNext<CR>

nnoremap <silent> <A-1> :BufferGoto 1<CR>
nnoremap <silent> <A-2> :BufferGoto 2<CR>
nnoremap <silent> <A-3> :BufferGoto 3<CR>
nnoremap <silent> <A-4> :BufferGoto 4<CR>
nnoremap <silent> <A-5> :BufferGoto 5<CR>
nnoremap <silent> <A-6> :BufferGoto 6<CR>
nnoremap <silent> <A-7> :BufferGoto 7<CR>
nnoremap <silent> <A-8> :BufferGoto 8<CR>
nnoremap <silent> <A-9> :BufferLast<CR>

nnoremap <silent> <A-c> :BufferClose!<CR>
nnoremap <silent> <A-C> :BufferReopen<CR>

nnoremap <silent><A-space>  :BufferPick<CR>
nnoremap <silent><space>bd  :BufferOrderByDirectory<CR>
nnoremap <silent><space>bl  :BufferOrderByLanguage<CR>

if exists('g:gui_oni')
nnoremap <silent> <A-,> :tabprev<CR>
nnoremap <silent> <A-.> :tabnext<CR>
nnoremap <silent> <A-c> :tabclose<CR>
end
if exists('g:fvim_loaded')
nnoremap <silent> <C-Tab>   :BufferNext<CR>
nnoremap <silent> <C-S-Tab> :BufferPrevious<CR>
end

" }}}1
"===============================================================================
" Text manipulation                                                         {{{1

" Increase/decrease
nmap - <Plug>(CtrlXA-CtrlX)
nmap _ <Plug>(CtrlXA-CtrlA)
nmap + <Plug>(CtrlXA-CtrlA)
nmap = <Plug>(CtrlXA-CtrlA)

" Exchange line x-up/down
nnoremap <expr> <C-x>j     'ddp'  . col('.') . '<Bar>'
nnoremap <expr> <C-x>k     'ddkP' . col('.') . '<Bar>'

" Exchange args left/right
nnoremap        <C-x>h  :SidewaysLeft<CR>
nnoremap        <C-x>l  :SidewaysRight<CR>

" Yank & Paste * (yank-up, yank-down)
nnoremap yu yyP
nnoremap yd yyp

" Indent
nnoremap <silent><nowait> > V><Esc>
nnoremap <silent><nowait> < V<<Esc>
vnoremap <silent><nowait> > >gv
vnoremap <silent><nowait> < <gv

nmap <silent>g<  vii<<Esc>
nmap <silent>g>  vii><Esc>


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
nmap <A-a>   <Plug>(EasyAlign)
vmap <CR>    <Plug>(EasyAlign)
xmap g<A-a>  <Plug>(EasyAlign)

nmap <A-a><A-a>        <Plug>(EasyAlign)ip1<C-x>
xmap <A-a><A-a> ""<A-y><Plug>(EasyAlign)ip1<C-D><Left><C-x>.\{-}\zs\s*\ze<C-r>"<CR>

" align semicolon
nnoremap <A-a><A-;> vip:EasyAlign *:<CR>
xnoremap <A-a><A-;>    :EasyAlign *:<CR>
" align bar
nnoremap <A-a><A-\> vip:EasyAlign *<Bar><CR>
xnoremap <A-a><A-\>    :EasyAlign *<Bar><CR>
" align equal
nnoremap <A-a><A-e> vip:EasyAlign *=<CR>
xnoremap <A-a><A-e>    :EasyAlign *=<CR>
nnoremap <A-a><A-=> vip:EasyAlign *=<CR>
xnoremap <A-a><A-=>    :EasyAlign *=<CR>
nnoremap <A-a>=     vip:EasyAlign *=<CR>
xnoremap <A-a>=        :EasyAlign *=<CR>
" align word
nnoremap <A-a><A-w>     vip:EasyAlign *\<space><CR>
xnoremap <A-a><A-w>        :EasyAlign *\<space><CR>
nnoremap <A-a>w         vip:EasyAlign *\<space><CR>
xnoremap <A-a>w            :EasyAlign *\<space><CR>
nnoremap <A-a><space>   vip:EasyAlign *\<space><CR>
xnoremap <A-a><space>      :EasyAlign *\<space><CR>
nnoremap <A-a><A-space> vip:EasyAlign *\<space><CR>
xnoremap <A-a><A-space>    :EasyAlign *\<space><CR>
" align Last-Word
nnoremap <A-a>-<space>  vip:EasyAlign -<space><CR>
xnoremap <A-a>-<space>     :EasyAlign -<space><CR>
" align commas
nnoremap <A-a><A-,>     vip:EasyAlign *,<CR>
xnoremap <A-a><A-,>        :EasyAlign *,<CR>
nnoremap <A-a>,         vip:EasyAlign *,<CR>
xnoremap <A-a>,            :EasyAlign *,<CR>


" EasyAlign                                                                  }}}

" SplitJoin:
" overrides 's' operator                                                     {{{
nmap   sj   :SplitjoinJoin<CR>
nmap   sk   :SplitjoinSplit<CR>
" }}}

" Comment:
" alt-'  &  alt-"                                                            {{{
nmap <A-'>      <Plug>NERDCommenterToggle
vmap <A-'>      <Plug>NERDCommenterSexy
" }}}

" StringTransform:
" Change Case                                                                {{{
nmap <leader>ccc <Plug>(camel_case_operator)
nmap <leader>ccC <Plug>(upper_camel_case_operator)
nmap <leader>cc_ <Plug>(snake_case_operator)
nmap <leader>cc- <Plug>(kebab_case_operator)
nmap <leader>ccs <Plug>(start_case_operator)
" xmap <leader>ccc <Plug>(camel_case_operator)
" xmap <leader>ccC <Plug>(upper_camel_case_operator)
" xmap <leader>cc_ <Plug>(snake_case_operator)
" xmap <leader>cc- <Plug>(kebab_case_operator)
" xmap <leader>ccs <Plug>(start_case_operator)
"}}}

" }}}1
"===============================================================================
" Search & replace                                                          {{{1

" Search
nnoremap g/ *zvzz
nnoremap g? #zvzz

" nnoremap g/ <Nop>
" nnoremap g? <Nop>

" IncSearch
" nmap / <Plug>(incsearch-forward)
" nmap ? <Plug>(incsearch-backward)

nmap n  <Plug>(incsearch-nohl-n)zvzz
nmap N  <Plug>(incsearch-nohl-N)zvzz
nmap *  <Plug>(incsearch-nohl-*)
nmap #  <Plug>(incsearch-nohl-#)

" Yank selected text as an escaped search-pattern
map <silent><Plug>(visual-yank-plaintext)
      \ :<C-U>call setreg(v:register, '\C\V'.escape(visual#GetText(), '\/'))<CR>

vmap <silent>    <C-f>  "/<Plug>(visual-yank-plaintext):set hlsearch<CR>

vmap <silent>       g/  "/<Plug>(visual-yank-plaintext)n
vmap <silent>       g?  "/<Plug>(visual-yank-plaintext)N

nmap <silent><expr> g\  incsearch#go(<SID>incsearch_config())

function! s:incsearch_config() abort
  return {'converters': [{val -> '\V' . escape(val, '/\')}]}
endfunction




" Text Replace TODO implement a real replace-mode
nnoremap <A-r>r     &
nnoremap <A-r><A-r> g&

nmap <A-r><A-l>   :s///<left>
nmap <A-r><A-a>   :%s///<left>
nmap <A-r>a       :%s///<left>
nmap <A-r><A-j>   :.,$s///<left>
nmap <A-r>j       :.,$s///<left>
nmap <A-r><A-w>   viw<C-F><A-r><A-l>
nmap <A-r>w       viw<C-F><A-r><A-l>
nmap <A-r><A-p>   m'viw<C-F><A-r><A-l><A-p><CR>''

xmap <A-r><A-r>   :s///<left>
xmap <A-r>r       :s///<left>
xmap <A-r><A-a>   <C-f><A-r><A-a>
xmap <A-r><A-l>   <C-f><A-r><A-l>

" SearchReplace
nnoremap <silent><C-f><C-f> :Search<CR>
nnoremap <silent><C-f><C-w> "cyiw:Search \b<C-r>c\b<CR>
nnoremap <silent><C-f>w     "cyiw:Search \b<C-r>c\b<CR>

" }}}1
"===============================================================================
" Macro & Automation                                                        {{{1

" Replay macro
nnoremap <M-q> @q
" Replay macro (visual)
xnoremap @  :normal @q<CR>

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

" Foldmethod
nmap z;m :setlocal fdm=marker<CR>
nmap z;s :setlocal fdm=syntax<CR>
nmap z;i :setlocal fdm=indent<CR>
nmap z;I :setlocal fdm=expr<CR>:setlocal foldexpr=GetIndentFold(v:lnum)<CR>
nmap z;e :setlocal fdm=expr<CR>
nmap z;E :setlocal fdm=expr<CR>:setlocal foldexpr=
nmap z;t :setlocal fdm=expr<CR>:setlocal foldexpr=nvim_treesitter#foldexpr()<CR>



" Surround line with { and }
nnoremap  g{   m`o}<esc><lt><lt>kkA<Space>{<esc>``
nnoremap  g,   m`A,<Esc>``

" Yank all
nnoremap <silent>gya :%y+<CR>
nnoremap         dya ggdG

" Exchange lhs-rhs
nmap gx= vihgxvilgx

" File Explorer
if has('win32')
nnoremap <F1> :silent !explorer .<CR>
else
nnoremap <F1> :!nautilus . &<CR>
end

nnoremap <F5> :e!<CR>

" Insert word of the line above
inoremap <C-Y> <C-C>:let @z = @"<CR>mz
                \:exec 'normal!' (col('.')==1 && col('$')==1 ? 'k' : 'kl')<CR>
                \:exec (col('.')==col('$') - 1 ? 'let @" = @_' : 'normal! yw')<CR>
                \`zp:let @" = @z<CR>a





" Copy current file path
nmap <silent>ycf :let @+=expand("%:~") <Bar> call Warn('Yanked: ' . @+)<CR>
nmap <silent>ycd :let @+=expand("%:h") <Bar> call Warn('Yanked: ' . @+)<CR>
nmap <silent>ycF :let @+=expand("%:p") <Bar> call Warn('Yanked: ' . @+)<CR>
nmap <silent>ycD :let @+=expand("%:p:h") <Bar> call Warn('Yanked: ' . @+)<CR>


" Gtfo
nnoremap ZZ :wqall!<CR>

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

" Treesitter operator:
" ./rc/plugins/tree-sitter.after.lua

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
cnoremap <A-p> <C-r>+
inoremap <A-p> <C-r>+

" Section: Filename/path insertion {{{

" noremap! <A-i><A-i> <C-R>=expand('%:p:~')<CR>
noremap! <A-i>f          <C-R>=expand('%')<CR>
noremap! <A-i><A-f>      <C-R>=expand('%:~')<CR>
noremap! <A-i>F          <C-R>=expand('%:p')<CR>
noremap! <A-i>h          <C-R>=expand('%:h:.')<CR>/
noremap! <A-i><A-h>      <C-R>=expand('%:h:~')<CR>/
noremap! <A-i>H          <C-R>=expand('%:p:h')<CR>/
noremap! <A-i>d          <C-R>=expand('%:h:.')<CR>/
noremap! <A-i><A-d>      <C-R>=expand('%:h:~')<CR>/
noremap! <A-i>D          <C-R>=expand('%:p:h')<CR>/
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
    if Ulti_canExpand()
        return Ulti_expand() | end

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

" set wildchar=<Tab>
" set wildcharm=<C-x>

set wildcharm=<Tab>
cmap <expr> <Tab>   wilder#in_context() ? wilder#next()     : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"


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
cabbrev hh      vert h
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
