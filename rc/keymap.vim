" File: keymap.vim
" Description: vim keymap
" Last Modified: 27 April 2016
" !::exe [So]


" Recent mappings:

nnoremap <A-e> El

nmap <A-=>  m`v<A-p><CR>=``

if has('win32')
  nnoremap <C-A> ggVG
  noremap  <C-c> "+y
  nnoremap gp    "+p
end


"===============================================================================
" Major maps                                                                {{{1

let mapleader = ','

" <Esc>
nnoremap <silent><expr> <Esc> (
            \   exists('b:esc') ? b:esc
            \ : StopAutoHL()    ? ""
            \ : ClearHighlights(v:count) ? ""
            \ : ":nohl<CR>" )

" <CR>
"cnoremap <expr> <CR> g:space.parse_cmd_line()


" V cycles visual modes
nnoremap       v v
xnoremap <expr>v
            \ (mode() ==# 'v' ? "\<C-V>"
            \ : mode() ==# 'V' ? 'v' : 'V')

" <Space>[Space] prefix
"nmap <expr>[Space]   SpaceDo()
"nnoremap [Space]   :Commands<CR>
nnoremap [Space]   <Nop>

" Space/Alt+Space

nmap <Space> [Space]
            "\ (g:space.is_spacing ? SpaceDo()
            "\ : '[Space]')
            "" sneak#is_sneaking() ?  '<Plug>SneakNext'
            "" : '<Plug>(space-do)'
"nnoremap <M-Space> <Plug>(space-reverse)


nnoremap Y  y$

nnoremap u u
nnoremap U <C-R>
"nmap    u <Plug>(RepeatUndo)

" YankRing
nmap     p <Plug>(miniyank-autoput)
nmap     P <Plug>(miniyank-autoPut)
nmap <A-p> <Plug>(miniyank-cycle)
"nmap <Leader>c <Plug>(miniyank-tochar)
"nmap <Leader>l <Plug>(miniyank-toline)
"nmap <Leader>b <Plug>(miniyank-toblock)


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
nnoremap gL  gul
nnoremap gu  gU

nnoremap gU  ~

" go-replace
nnoremap gr      gR
xnoremap gr      r<space>gR

" go-winmode
nnoremap gw      :InteractiveWindow<CR>

" Next/Previous Tab
nnoremap g[ gT
nnoremap g] gt

" Open
nnoremap <silent>go :!xdg-open <C-R><C-A><CR>


" Insert newline
nnoremap <CR>   o<Esc>
nnoremap <A-CR> O<Esc>


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
\ "\<A-o>": ":CtrlPMRU\<CR>",
\ 'b':      ':CtrlPBuffer',
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
nmap gsly           :Edit .ycm_extra_conf.py<CR>
nmap gsyy           :Edit $rc/ycm.py<CR>

" Files
nnoremap gsrv       :Files $vim<CR>
nnoremap gsvb       :Files $bundle<CR>
nnoremap gsvp       :Files $vim/rc/plugin<CR>
nnoremap gsrc       :Edit $MYVIMRC<CR>
nnoremap gsm        :Edit $vim/rc/keymap.vim<CR>
nnoremap gs<A-m>    :PreviewEdit $vim/rc/keymap.vim<CR>:silent! normal g;<CR>
nnoremap gskm       :PreviewEdit $vim/rc/keymap.vim<CR>:silent! normal g;<CR>
nnoremap gsko       :Edit $vim/plugin/options.vim<CR>
nnoremap gsa        :Edit $vim/rc/autocmd.vim<CR>
nnoremap gse        :Edit $vim/rc/events.vim<CR>
nnoremap gsf        :Edit $vim/rc/function.vim<CR>
nnoremap gsd        :Edit $vim/rc/commands.vim<CR>
nnoremap gsc        :Edit $vim/rc/colors.vim<CR>
nnoremap gsh        :Edit $vim/rc/highlight.vim<CR>
nnoremap gsl        :Edit $vim/rc/lavalamp.vim<CR>
nnoremap gso        :Edit $vim/rc/settings.vim<CR>
nnoremap gsj        :Edit $vim/colors/darker.vim<CR>
nnoremap gstl       :Edit $vim/rc/plugins/lightline.vim<CR>
nnoremap gsp        :Edit $vim/rc/plugins.vim<CR>
nnoremap gsP        :Edit $vim/rc/plugins/
nnoremap gs<A-p>    :Edit $vim/plugin/
nnoremap gsg        :Edit $vim/autoload/git.vim<CR>

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
xnoremap <expr><A-l> (&ve=~#'onemore'<Bar><Bar>&ve==#'all') ? '$h' : '$'

" wide move
noremap <A-j> 5<Down>
noremap <A-k> 5<Up>
nnoremap <A-j> 5gj
nnoremap <A-k> 5gk

" scroll up/down
nnoremap <A-u> 10<C-Y>
nnoremap <A-d> 10<C-E>

nnoremap <A-b> <Left>gel

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
" nmap <silent> ge    <Plug>CamelCaseMotion_ge

xmap <silent> w     <Plug>CamelCaseMotion_w
xmap <silent> b     <Plug>CamelCaseMotion_b
xmap <silent> e     <Plug>CamelCaseMotion_e
xmap <silent> ge    <Plug>CamelCaseMotion_ge

omap <expr>   w     searchpos('\%#\s', '')[1] ?
                    \ '<Plug>CamelCaseMotion_w' : '<Plug>CamelCaseMotion_e'
omap <silent> <A-w> <Plug>CamelCaseMotion_e

xmap <silent> b     <Plug>CamelCaseMotion_b

" xmap <silent> ge    <Plug>CamelCaseMotion_ge
xmap <A-w> B
xmap <A-e> E

xnoremap iw iw

" }}}

" 1}}}
"===============================================================================
" Sneak                                                                     {{{1

nmap <PageUp>   <Plug>Sneak_S
nmap <PageDown> <Plug>Sneak_s

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
" EasyMotion                                                                {{{1
function! EnableEasyMotion ()

"nmap sd     <Plug>(easymotion-lineanywhere)
"nmap gL     <Plug>(easymotion-overwin-line)
"nmap g<C-f> <Plug>(easymotion-f2)
nmap <M-e>   <Plug>(easymotion-bd-w)

nnoremap [Space]L :call EasyMotion#overwin#line()<CR>

nnoremap       [j :call EasyMotion#JK(0, 1)<CR>
nnoremap       ]j :call EasyMotion#JK(0, 0)<CR>
nnoremap [Space]k :call EasyMotion#JK(0, 1)<CR>
nnoremap [Space]j :call EasyMotion#JK(0, 0)<CR>
nnoremap       [w :call EasyMotion#WB(0, 1)<CR>
nnoremap       ]w :call EasyMotion#WB(0, 0)<CR>

call EasyMotion#command_line#cnoremap("\<BS>\<BS>")
call EasyMotion#command_line#cnoremap(";\<CR>")
call EasyMotion#command_line#cmap(" \<Tab>")
call EasyMotion#command_line#cmap("\<A-space>\<Tab>")
"call EasyMotion#command_line#cmap("\<A-space>\<Tab>")

endfunc
if exists('*timer_start')
            \ && has('vim_starting')
            \ && exists('*EasyMotion#command_line#cmap')
    call timer_start(6000, 'EnableEasyMotion')
end
" }}}1
"===============================================================================
" Commands & Space maps                                                     {{{1
" @space

nnoremap <C-A-B>           :NeomakeSh make build<CR>

" YCM:
nnoremap [Space]yr         :YcmRestartServer<CR>
nnoremap [Space]yi         :YcmDebugInfo<CR>
nnoremap [Space]yd         :YcmDiags<CR>
nnoremap [Space]yy         :YcmForceCompileAndDiagnostics<CR>
nnoremap [Space]<space>    :YcmCompleter GetType<CR>
nnoremap [Space]<A-d>      :YcmCompleter GetDoc<CR>
nnoremap [Space]]          :YcmCompleter GoTo<CR>
nnoremap [Space]}          :YcmCompleter GoToType<CR>
nnoremap [Space]gd         :YcmCompleter GoToDefinition<CR>
nnoremap [Space]gD         :YcmCompleter GoToDeclaration<CR>
nnoremap [Space]I          :YcmCompleter GoToInclude<CR>
nnoremap [Space]gr         :YcmCompleter RefactorRename<space>

"===============================================================================

" Session management:
nnoremap      [Space]ss     :wall! <Bar> SaveSession<CR><Esc>
nnoremap      [Space]so     :call feedkeys(":OpenSession! \<C-D>", 't')<CR>
nnoremap      [Space]sd     :OpenSession! default<CR>
nnoremap      [Space]sc     :wall! <Bar> CloseSession<CR>

nnoremap      [Space]sl     :SourceLocalVimrc<CR>

" Git:

nnoremap      [Space]ma   :Magit<CR>

nnoremap      [Space]gc   :Gcommit % -m ''<Left>
nnoremap      [Space]gk   :Git checkout<space>
nnoremap      [Space]gK   :Git checkout -b<space>
nnoremap      [Space]gp   :Gpull<CR>
nnoremap      [Space]gP   :Gpush<CR>
nnoremap      [Space]gs   :Gstatus<CR>

"===============================================================================
" Ack, Ag, Grep & File Searching

" Files:
nnoremap      [Space]md     :Mkdir! <C-D>
nnoremap      [Space]mv     :Move <C-D>

" Search:
nnoremap      [Space]ac     :Ack<space>
nnoremap      [Space]ak     :Ack<space><C-R><C-W><CR>
nnoremap      [Space]ag     :Ag<space>
nnoremap      [Space]aa     :Ag <C-R><C-W><CR>
nnoremap      [Space]as     :Ag <C-R>/<CR>

"===============================================================================

" Windows-things:
nnoremap      [Space]w-   :call SizeDown()<CR>
nnoremap      [Space]w+   :call SizeUp()<CR>

"===============================================================================

" Various:
nnoremap      [Space]ret  :set et <Bar> ret<CR>
nnoremap      [Space]ap   vip:EasyAlign<CR>
" ArgWrap     foo(bwibble, wobble, wubble)
nnoremap      [Space]arg  :ArgWrap<CR>
nnoremap      [Space]ret  :set et <Bar> ret<CR>
nnoremap      [Space]dws  :%DeleteTrailingWS<CR>
nnoremap      [Space]aw   :call AutodetectShiftWidth()<CR>
" Stackoverflow
nnoremap      [Space]st   :SO<space>
nnoremap      [Space]sf   :SOf<space>

" Multi-Cursors:
" (see: ./plugins/multiple-cursors.vim)
nnoremap      [Space]mw :.,.MultipleCursorsFind \S\+<CR>o<Esc>
nnoremap      [Space]mW :.,.MultipleCursorsFind \w\+<CR>

" }}}1
"===============================================================================
" Panels, File navigation, FZF & CtrlP                                      {{{1


nnoremap <silent><A-\>   :NERDTreeFocus<CR>
nnoremap <silent><C-\>   :NERDTreeToggle<CR>
nnoremap <silent><C-A-\> :NERDTreeFind<CR>
nnoremap <silent><C-A-T> :TagbarToggle<CR>
nnoremap <silent><C-A-L> :call ToggleWindows()<CR>


nnoremap <C-A-P>  :Commands<CR>
nnoremap <C-A-O>  :GitFiles<CR>


if has('win32')
nnoremap <silent> <A-i>    :CtrlPFunky<CR>
else
nnoremap <silent> <A-i>    :CtrlPBufTag<CR>
end

nnoremap <silent> <A-S-I>  :CtrlPTag<CR>

nnoremap <silent> <A-o>    :CtrlP<CR>
nnoremap <silent> <A-O>    :CtrlPMixed<CR>
nnoremap <silent> <C-S>    :CtrlPBuffer<CR>

" }}}1
"===============================================================================
" Window & Tabs navigation                                                  {{{1
" @windows

" Cycle between editor Windows
nnoremap <silent> <A-w>      :GoNextListedWindow<CR>

" Windows actions
nnoremap <C-W>v     <C-W>v<C-W>l
nnoremap <C-W>s     <C-W>s<C-W>j
nnoremap <C-W>;     :split  <Bar> terminal<CR>
nnoremap <C-W>:     :vsplit <Bar> terminal<CR>
nnoremap <C-W><A-;> :tabedit term://bin/zsh<CR>
nnoremap <C-W>y     :WindowYank<CR>
nnoremap <C-W>g     :WindowPaste<CR>
nnoremap <C-W><C-Y> :WindowCopyView<CR>
nnoremap <C-W>\     :WindowFitText<CR>

nnoremap <C-W><Tab> :tabedit <C-r>=bufname(buf#filter('&buflisted')[-1])<CR><CR>
nnoremap <C-W>t     :tab split<CR>

" Terminal navigation mappings down here. }}}1
"===============================================================================
" Terminal                                                          @term   {{{1
if has('nvim')

" Panels/Navigation
nnoremap g:             :OpenTerminal<CR>
nnoremap g<A-;>         :OpenTerminalHere<CR>
nnoremap g<space>       :GoFirstTerminalWindow<CR>
nnoremap <C-W><space>   :ToggleTerminalWindow<CR>
nnoremap <C-W><M-Space> :wincmd s \| NextTerminalBuffer<CR>


tmap <A-,>          <C-\><C-N>:PreviousTerminalBuffer<CR>
tmap <A-.>          <C-\><C-N>:NextTerminalBuffer<CR>
tmap <C-A-,>        <C-\><C-N>:bp<CR>
tmap <C-A-.>        <C-\><C-N>:bn<CR>

" Close
tnoremap <A-c>      <C-\><C-N>:bd!<CR>

tnoremap <A-e>      <C-\><C-n>
tnoremap <A-Tab>    <C-\><C-N>gt
tnoremap <F12>      <C-\><C-n>

" Navigation
tnoremap ;         <C-\><C-N>:
tnoremap <A-;>     <Esc>;
tnoremap <A-w>     <C-\><C-N><A-w>
tnoremap <A-2>     <C-\><C-N><C-W>w

" Arrows
tnoremap <A-j>     <Esc>j
tnoremap <A-k>     <Esc>k
tnoremap <A-h>     <Esc>h
tnoremap <A-l>     <Esc>l

end "of has('nvim') }}}1
"===============================================================================
" Buffer navigation                                                         {{{1

nnoremap <silent> <A-,> :Bprev<CR>
nnoremap <silent> <A-.> :Bnext<CR>
nnoremap <silent> <A-<> gT
nnoremap <silent> <A->> gt

nnoremap <A-c>      :BufferClose<CR>
nnoremap <A-C>      :BufferReopen<CR>
nnoremap <C-A-c>    :BufferClose<CR><C-w>c
nnoremap <C-A-q>    :BufferWipeReopen<CR>

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
nnoremap <silent>>> V><Esc>
nnoremap <silent><< V<<Esc>
vnoremap          > >gv
vnoremap          < <gv


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

" Section: local text-objects
" function definitions & search patterns TODO move to autoload               {{{

" function-call patterns
let name_pattern = '\(\k\|\i\|\f\|<\|>\|:\|\\\)\+'
let args_pattern = '\(\\)\|[^)]\)*'
let fcall_pattern = name_pattern . '\s*\ze('
let fargs_pattern = name_pattern . '\s*(\zs' . args_pattern . '\ze\s*)'
let func_pattern  = name_pattern . '\s*(' . args_pattern . '\s*)'


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
fu! s:findFunc (...)
    let f = a:0 ? a:1 : 'bnc'
    let fc = f =~# 'c' ? 'c' : ''
    let fb = f =~# 'b' ? 'b' : ''
    let fn = f =~# 'n' ? 'n' : ''
    let visual = f =~# 'v' ? 1 : 0

    let pattern = '\(\k\|\i\|\f\|<\|>\|:\|\\\)\+\s*\ze('
    if (a:0 == 2)
        let pattern = a:2 | end

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
" }}}

" Functioncall: Text-Object
" change inside/all current/last/next fcall                                  {{{
nmap cif    :call <SID>changeFunc('c')<CR>
nmap cIf    :call <SID>changeFunc('ic')<CR>
nmap caf    :call <SID>changeFunc('ac')<CR>
nmap cnf    :call <SID>changeFunc('n')<CR>
nmap cpf    :call <SID>changeFunc('l')<CR>
nmap cinf   :call <SID>changeFunc('in')<CR>
nmap cilf   :call <SID>changeFunc('il')<CR>
nmap canf   :call <SID>changeFunc('an')<CR>
nmap calf   :call <SID>changeFunc('al')<CR>

nmap dsf  :call DSurroundFunc()<CR>
nmap csf  :call CSurroundFunc()<CR>
nmap cof  :call <SID>changeFunc('c')<CR>

fu! DSurroundFunc()
    call s:findFunc ('vbc')
    normal ddsb
endfu
fu! CSurroundFunc ()
    let saved_cursor = getcurpos()
    call s:findFunc ('vbc') | redraw
    let char = GetChar('TextWarning', 'Change surrounding func with: ')
    if char != "\<Esc>"
        call feedkeys('dcsb' . char, '')
    else
        Reset saved_cursor
    end
endfu
" }}}

" FindQuote:
" mappings:                                                                  {{{
" cs''  toggles surrounding quotes
" ds'   deletes surrounding quotes
" f'    is equivalent to f' and/or f"
nmap <silent><expr>f'   "<Plug>Sneak_f" . <SID>findQuote(1, 'c')
nmap <silent><expr>F'   "<Plug>Sneak_F" . <SID>findQuote(0, 'c')

" delete/change surrounding quotes
nmap <expr>cs'  CSurroundQuotes()
nmap <expr>ds'  DSurroundQuotes()

fu! CSurroundQuotes()
    let qch = s:findQuote()
    let char = GetChar('TextWarning', 'Change surrounding quotes with: ')
    if char == "'"
        let char = (qch ==# "\"" ? "'" : "\"") | end
    return "\<Plug>Csurround" . qch . char
endfu
fu! DSurroundQuotes()
    return "\<Plug>Dsurround" . s:findQuote()
endfu

" }}}

" Substitute: operator (replace.vim)
" normal: s,ss,S        visual: s                                            {{{
" unlet! m
nmap s  <Plug>ReplaceOperator
nmap ss V<C-S>
nmap S  s$
xmap s     <Plug>ReplaceOperator

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
vmap <A-'>      <Plug>NERDCommenterToggle
nmap <A-">      <Plug>NERDCommenterSexy
xmap <A-">      <Plug>NERDCommenterSexy
" }}}

" StringTransform:
" gc,g_,--,-s,__                                                             {{{
nmap gc <Plug>(camelCaseOperator)
xmap gc <Plug>(camelCaseOperator)
nmap _c <Plug>(camelCaseOperator)
xmap _c <Plug>(camelCaseOperator)
nmap _- <Plug>(camelCaseOperator)
xmap _- <Plug>(camelCaseOperator)
nmap g_ <Plug>(snakeCaseOperator)
xmap g_ <Plug>(snakeCaseOperator)
nmap __ <Plug>(snakeCaseOperator)
xmap __ <Plug>(snakeCaseOperator)
nmap -- <Plug>(kebabCaseOperator)
xmap -- <Plug>(kebabCaseOperator)
nmap _s <Plug>(startCaseOperator)
xmap _s <Plug>(startCaseOperator)
nmap -s <Plug>(startCaseOperator)
xmap -s <Plug>(startCaseOperator)
"}}}

" }}}1
"===============================================================================
" Search & replace                                                          {{{1

nnoremap / /
nnoremap ? ?

" IncSearch
nmap <C-F>    <Plug>(incsearch-forward)
nmap <C-G>    <Plug>(incsearch-backward)
nmap <C-A-F>  <Plug>(incsearch-backward)

nmap n  <Plug>(incsearch-nohl-n)
nmap N  <Plug>(incsearch-nohl-N)
nmap *  <Plug>(incsearch-nohl-*)
nmap #  <Plug>(incsearch-nohl-#)

"nmap <expr> n  SpaceSetup('search', '<Plug>(incsearch-nohl-n)', 'n', 'N', 1)
"nmap <expr> N  SpaceSetup('search', '<Plug>(incsearch-nohl-N)', 'n', 'N', 0)
"nmap <expr> *  SpaceSetup('search', '<Plug>(incsearch-nohl-*)', 'n', 'N', 1)
"nmap <expr> #  SpaceSetup('search', '<Plug>(incsearch-nohl-#)', 'n', 'N', 1)

" Yank selected text as an escaped search-pattern
map <silent><Plug>(visual-yank-plaintext)
     \ :<C-U>call setreg(v:register, '\V'.escape(visual#GetText(), '\/'))<CR>
vmap <M-y>           <Plug>(visual-yank-plaintext)
vmap <A-/>         "/<Plug>(visual-yank-plaintext)n
vmap <silent><C-F> "/<Plug>(visual-yank-plaintext):set hls<CR>
nmap z*         viw"/<Plug>(visual-yank-plaintext):set hls<CR>
" credits: xolox
function! visual#GetText()
    " Why is this not a built-in Vim script function?!
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    return join(lines, "\n")
endfunction



" Text Replace TODO implement a real replace-mode
nnoremap <A-r>r     &
nnoremap <A-r><A-r> g&

nmap <A-r><A-w> viw<C-F><A-r><A-l>

nmap <A-r><A-l> :s///<left>
nmap <A-r><A-a> :%s///<left>
nmap <A-r>a     :%s///<left>
nmap <A-r><A-f> :.,$s///<left>
nmap <A-r><A-j> :.,$s///<left>
nmap <A-r>j     :.,$s///<left>
nmap <A-r><A-n> :%s///<Left>
nmap <A-r>n     :%s///<Left>
nmap <A-r><A-p> :%s///c<left><left>

vmap <A-r>      :s///<left>

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
" @quick

" File Explorer
if has('win32')
nnoremap <F1> :silent !explorer .<CR>
end

" Diff/Undiff open windows
nnoremap <F12>   :windo diffthis<CR>
nnoremap <S-F12> :windo diffoff<CR>


" Insert word of the line above
inoremap <C-Y> <C-C>:let @z = @"<CR>mz
                \:exec 'normal!' (col('.')==1 && col('$')==1 ? 'k' : 'kl')<CR>
                \:exec (col('.')==col('$') - 1 ? 'let @" = @_' : 'normal! yw')<CR>
                \`zp:let @" = @z<CR>a

" Fold around search patterns
nnoremap <silent><expr>  [Space]zz  FS_ToggleFoldAroundSearch({'context':1})

" Fixes something
nnoremap <expr>i empty(getline('.')) ? 'cc' : 'i'

nnoremap =r      :call QuickReload()<CR>

nnoremap gh      :call ReopenHelp()<CR>


nmap gK  <Plug>Zeavim
nmap gZK <Plug>ZVKeyDocset

nnoremap <M-1> :SynStack<CR>
nnoremap <M-3> :SynCurrentEdit<CR>
nnoremap <M-4> :Fullfill<space>


" Copy current file path
nmap <silent>y5  :let @+=expand("%") <Bar> call Warn('Yanked: ' . @+)<CR>
nmap <silent>ycf :let @+=expand("%:~") <Bar> call Warn('Yanked: ' . @+)<CR>
nmap <silent>ycd :let @+=expand("%:h") <Bar> call Warn('Yanked: ' . @+)<CR>
nmap <silent>ycF :let @+=expand("%:p") <Bar> call Warn('Yanked: ' . @+)<CR>
nmap <silent>ycD :let @+=expand("%:p:h") <Bar> call Warn('Yanked: ' . @+)<CR>


" Insert 愛 (<S-F3>)
imap <expr> <F1>  "\u611B"


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
omap p      <Plug>(operator-lhs)
omap P      <Plug>(operator-Lhs)
omap v      <Plug>(operator-rhs)
omap V      <Plug>(operator-Rhs)
omap <A-i>  <Plug>(operator-lhs)
omap <A-I>  <Plug>(operator-Lhs)
omap H      <Plug>(operator-lhs)
omap L      <Plug>(operator-rhs)

xmap H      <Plug>(operator-lhs)
xmap L      <Plug>(operator-rhs)
xmap ih     <Plug>(operator-lhs)
xmap il     <Plug>(operator-rhs)
xmap ah     <Plug>(visual-Lhs)
xmap al     <Plug>(visual-Rhs)
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
xmap <C-a> <Plug>(niceblock-A)
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
cnoremap <A-p> <C-R>"
inoremap <A-p> <C-R>"

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
from UltiSnips import UltiSnips_Manager, _vim
SM = UltiSnips_Manager
before = _vim.buf.line_till_cursor
sn=SM._snips(before, False)
vim.command('return %i' % len(sn))
EOF
endfunction

function! Ulti_canJump()
if !has('python3') | return 0 | end
py3 << EOF
import vim
from UltiSnips import UltiSnips_Manager, _vim
SM = UltiSnips_Manager
if SM._cs:
    vim.command('return 1')
else:
    vim.command('return 0')
EOF
endfunction

function! Ulti_jump(dir)
py3 << EOF
import vim
from UltiSnips import UltiSnips_Manager, _vim
SM = UltiSnips_Manager
if SM._cs:
    if vim.eval('a:dir') == '1':
        SM._jump()
    else:
        SM._jump(True)
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

cabbrev hh      vertical help
cabbrev pp      Pp
cabbrev ff      F
cabbrev sudo    w !sudo tee % >/dev/null


" Insert-like mappings
cnoremap <expr>( <SID>isAtEndOfCmdline() ? "()<Left>" : "("
cnoremap <expr>[ <SID>isAtEndOfCmdline() ? "[]<Left>" : "["
cnoremap <expr>{ <SID>isAtEndOfCmdline() ? "{}<Left>" : "{"
cnoremap <expr>) <SID>cmdClosingPair(')')
cnoremap <expr>] <SID>cmdClosingPair(']')
cnoremap <expr>} <SID>cmdClosingPair('}')
" Movement functions
function! s:cmdClosingPair (char, ...)
    let pos  = getcmdpos()
    let line = getcmdline()
    if line[pos - 1] == a:char
        return "\<Right>"
    else
        return a:char
    end
endfu
function! s:isAtEndOfCmdline ()
    return getcmdpos() == 1+len(getcmdline())
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
nnoremap z- :set foldlevel-=1 <Bar> call Info('&foldlevel = ' . &foldlevel)<CR>
nnoremap z+ :set foldlevel+=1 <Bar> call Info('&foldlevel = ' . &foldlevel)<CR>

" 1}}}
"===============================================================================
" Options: ../plugin/options.vim
"===============================================================================
" vim: fdm=marker
