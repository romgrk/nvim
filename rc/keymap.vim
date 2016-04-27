" Description: vim keymap
" Last Modified: 27 April 2016
" Command: !::exe [so %]

" TODO -> use CompleteDone autocmd to auto-insert ;
" TODO Search shortcuts
" TODO s & reacent mappings
" TODO explore g- mapping & changelist
" TODO configure Targets.vim
" TODO configure git
" FIXME ../plugin/space.vim

"===============================================================================
" Major maps                                                                {{{1

nnoremap <silent><expr> <Esc> ( StopAutoHL() ? "" : ClearHighlights(v:count) ? "" : ":nohl<CR>" )

let mapleader = ","

let s:quickmap = {
\ 'w': ":silent! w | Success ' '.expand('%:t') . ' @ '.Now()",
\ '<': ':messages', ';': ":\<Up>",  ':': ':terminal',
\ "\<C-F>": ':Files', "\<C-D>": ':NERDTreeFind',
\ "\<A-;>":  'q:":P', "\<A-s>":  ":set ?\<Left>",
\ 'b':       ':CtrlPBuffer',
\}
if !exists('g:quickmap') | let g:quickmap = {}
else                     | call extend(g:quickmap,   s:quickmap) | end
func! CmdJump ()
    let c = GetChar('BoldError', ':')
    call feedkeys( get(g:quickmap, c, ':' . c) )
endfunc

" Semicolon key
"let semi = maparg(';', 'n', 0, 1)
nmap <silent> <expr>  ;  sneak#is_sneaking()
                    \ ? '<Plug>SneakNext'
                    \ : ":call CmdJump()<CR>"
nmap <silent> <A-;> <Plug>SneakPrevious
xmap <silent> ;     <Plug>SneakNext
vmap <silent> <A-;> <Plug>SneakPrevious

nnoremap q; q:

nnoremap p  ]p
nnoremap P  ]P

nnoremap Y  y$

nnoremap u u
nnoremap U <C-r>
"nmap    u <Plug>(RepeatUndo)

" go-lower/go-upper
nnoremap gl gu
nnoremap gu gU

" go-replace
nnoremap gr      gR
xnoremap gr      r<space>gR

nnoremap go<Tab> :Tabview<CR>
nmap     gt      :InteractiveWindow<CR>t

" Insert newline
nnoremap <CR>   o<Esc>
nnoremap <A-CR> O<Esc>


" Split line (as opposed to J)
nnoremap <C-J>  i<CR><Esc>:silent -DeleteTrailingWS<CR>


" free <C-G>
nnoremap g<C-G> <C-G>

" }}}1
"===============================================================================
" RC & Setup quick access                                                   {{{1
" @configuration

" Local config
nmap gslc	:Edit .vimrc<CR>
nmap gsy	:Edit .ycm_extra_conf.py<CR>
nmap gsgy	:Edit $rc/ycm.py<CR>

" Directories
nn gsv      :VimFiler <C-r>=$vim<CR><CR>
nn gsvr     :Files $vim<CR>
nn gsvb     :Files $bundle<CR>
nn gsvp     :Files $vim/rc/plugin<CR>

nn gs<A-p> :Edit $vim/plugin/
nn gsvp    :VimFiler $vim/plugin<CR>
nn gsg     :Edit $vim/autoload/git.vim<CR>
" Files
nn gsrc	:Edit $MYVIMRC<CR>
nn gsm	:Edit $vim/rc/keymap.vim<CR>
nn gskm	:PreviewEdit $vim/rc/keymap.vim<CR>:silent! normal g;<CR>
nn gsko	:Edit $vim/plugin/options.vim<CR>
nn gsa	:Edit $vim/rc/autocmd.vim<CR>
nn gsf	:Edit $vim/rc/function.vim<CR>
nn gsd	:Edit $vim/rc/commands.vim<CR>
nn gsc	:Edit $vim/rc/colors.vim<CR>
nn gsh	:Edit $vim/rc/highlight.vim<CR>
nn gsl	:Edit $vim/rc/lavalamp.vim<CR>
nn gso	:Edit $vim/rc/settings.vim<CR>
nn gsj	:Edit $vim/colors/darker.vim<CR>
nn gstl	:Edit $vim/rc/plugins/lightline.vim<CR>
nn gsp	:Edit $vim/rc/plugins.vim<CR>
nn gsP	:Edit $vim/rc/plugins/
nn gsrf :Files $rc<CR>
nn gsrv :Files $vim<CR>

" New...
nn <A-n><A-s>    :UltiSnipsEdit<CR>
nn <A-n><A-m>    :EditFtplugin<CR>
nn <A-n><A-a>    :EditFtsyntax<CR>

" Edit runtime syntax file
nmap <A-n><A-f>    :EditSyntax<CR>

" }}}1
"===============================================================================
" Jumps & cursor movement                                                   {{{1

" j/k screen rows
nnoremap j gj
nnoremap k gk

nnoremap H <C-O>
nnoremap L <C-I>

" SoL-EoL motion
map <A-h> ^
map <A-l> $
if (&virtualedit=~#'onemore')
    xmap $ $h
end

" wide move
noremap <A-j> 5<Down>
noremap <A-k> 5<Up>

" scroll up/down
nnoremap <A-u> 10<C-Y>
nnoremap <A-d> 10<C-E>

nnoremap <Down> 8<C-e>
nnoremap <Up> 7<C-y>

" Previous/next in jump list
"nnoremap <Tab>   <C-o>

" Close any preview window then jump
"nnoremap <C-]> <C-w>z<C-]>

" Character-wise jumps
nnoremap ''  `'
nnoremap '   `

nnoremap <C-S> ?
nnoremap <C-F> /

" CamelCase motion
" map: w, b,        nmap: e, ge                                              {{{
"if exists('*camelcasemotion#CreateMotionMappings')
"call camelcasemotion#CreateMotionMappings('<leader>')
"end

nmap <silent> w <Plug>CamelCaseMotion_w
nmap <silent> b <Plug>CamelCaseMotion_b
nmap <silent> e <Plug>CamelCaseMotion_e
nmap <silent> ge <Plug>CamelCaseMotion_ge
xmap <silent> w <Plug>CamelCaseMotion_w
xmap <silent> b <Plug>CamelCaseMotion_b
xmap <silent> e <Plug>CamelCaseMotion_e
xmap <silent> ge <Plug>CamelCaseMotion_ge

omap <silent> w <Plug>CamelCaseMotion_w
xmap <silent> b <Plug>CamelCaseMotion_b
xmap <silent> ge <Plug>CamelCaseMotion_ge
"xnoremap <silent> e e

"omap <silent> iw <Plug>CamelCaseMotion_iw
"xmap <silent> iw <Plug>CamelCaseMotion_iw
"omap <silent> ib <Plug>CamelCaseMotion_ib
"xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie

xnoremap iw iw

" }}}

" 1}}}
"===============================================================================
" Sneak                                                                     {{{1

"nmap <A-w>   <Plug>Sneak_s
nmap <M-f>    <Plug>Sneak_s
"xmap <M-f> <Plug>Sneak_F
"omap <M-f> <Plug>Sneak_F
nmap <M-b>    <Plug>Sneak_S
nmap <M-e>    <Plug>(easymotion-bd-w)

nmap <expr> <Space> sneak#is_sneaking()
            \ ? '<Plug>SneakNext'
            \ : '<Plug>(space-do)'
nmap        <M-space> <Plug>(space-reverse)

"nmap <expr> <a-;> sneak#state().reverse==1
        "\ ? "<Plug>Sneak_s<CR>"
        "\ : "<Plug>Sneak_S<CR>"
"nmap <expr> <Plug>RomgrkSneak sneak#is_sneaking()
    "\
    "\ ? (sneak#state().reverse==0
            "\ ? "<Plug>(SneakStreak)<CR>"
            "\ : "<Plug>(SneakStreakBackward)<CR>")
    "\ : "<BS>"

nmap <expr> <a-;> sneak#is_sneaking()
    \
    \ ? (sneak#state().reverse==1
            \ ? "<Plug>Sneak_s<CR>"
            \ : "<Plug>Sneak_S<CR>")
    \ : "<Plug>SneakNext"

"nmap s <Plug>Sneak_s
"nmap S <Plug>Sneak_S
" find operator
nmap f     <Plug>Sneak_f
xmap f     <Plug>Sneak_f
omap f     <Plug>Sneak_f
nmap F     <Plug>Sneak_F
xmap F     <Plug>Sneak_F
omap F     <Plug>Sneak_F

" until operator
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
"omap t <Plug>Sneak_t
"omap T <Plug>Sneak_T
xmap u <Plug>Sneak_t
xmap U <Plug>Sneak_T
omap u <Plug>Sneak_t
omap U <Plug>Sneak_T

" 1}}}
"===============================================================================
" EasyMotion  @easymotion                                                   {{{1

"nmap sd     <Plug>(easymotion-lineanywhere)
"nmap gL     <Plug>(easymotion-overwin-line)
nmap <C-L>  <Plug>(easymotion-overwin-line)
"nmap g<C-f> <Plug>(easymotion-f2)

nnoremap gj <Plug>(easymotion-j)
nnoremap gk <Plug>(easymotion-k)
nnoremap [w :call EasyMotion#WB(0, 1)<CR>
nnoremap ]w :call EasyMotion#WB(0, 0)<CR>

call EasyMotion#command_line#cnoremap("\<BS>\<BS>")
call EasyMotion#command_line#cnoremap(";\<CR>")
call EasyMotion#command_line#cmap(" \<Tab>")
call EasyMotion#command_line#cmap("\<A-space>\<Tab>")
"call EasyMotion#command_line#cmap("\<A-space>\<Tab>")

" }}}1
"===============================================================================
" Notes                                                                      {{{

nmap <A-n>o        :Note<space>
nmap <A-n><A-o>    :Files ~/notes<CR>

nmap <A-n><A-n>    :Edit $vim/plugin/notes.vim<CR>

nmap <A-n>e        :Edit ~/notes/
nmap <A-n><A-e>    :Edit ~/notes/

nmap <A-n>r        :RelatedNotes<CR>
nmap <A-n><A-r>    :RecentNotes<CR>

"                                                                            }}}
"===============================================================================
" Multi-Cursors (see: ./plugins/multiple-cursors.vim)
"===============================================================================
" Unite & FZF & CtrlP                                                        {{{

nnoremap <C-A-P>  :Commands<CR>
nnoremap <C-A-O>  :GitFiles<CR>

nnoremap <A-i>    :CtrlPBufTag<CR>
nnoremap <A-S-I>  :CtrlPTag<CR>

nnoremap <C-P>    :CtrlPMixed<CR>
nnoremap <C-B>    :CtrlPBuffer<CR>
nnoremap <A-o>    :CtrlPCurWD<CR>
nnoremap <A-O>    :CtrlP<CR>
nnoremap <C-N>    :CtrlPCurFile<CR>

nnoremap gut      :Unite tag:% -start-insert<CR>
nnoremap guT      :Unite tag   -start-insert<CR>
nnoremap guu      :Unite -start-insert neomru/file<CR>
nnoremap gus      :Unite -start-insert source<CR>
nnoremap gug      :Unite -start-insert file_rec/git<CR>
nnoremap guf      :Unite -start-insert file_rec/neovim<CR>
nnoremap gui      :Unite -start-insert tag:%<CR>
nnoremap guI      :Unite -start-insert tag<CR>

nnoremap gum       :<C-u>Unite mapping<CR>
nnoremap gu<C-A-u> :<C-u>Unite source -start-insert<CR>
"nn <C-A-u>f  :<C-u>UniteWithBufferDir -buffer-name=files buffer bookmark file<CR>
"nn <C-A-u>.  :<C-u>UniteWithCurrentDir -buffer-name=files buffer bookmark file<CR>

"nnoremap g<     g<

" }}}1
"===============================================================================
" Window & navigation                                                       {{{1


nnoremap <A-w> <C-W>w

nnoremap <C-W>;     :wincmd v <Bar> terminal<CR>
nnoremap <C-W><A-;> :wincmd s <Bar> terminal<CR>
nnoremap <C-W>:     :tab terminal<CR>

nnoremap <silent>     g<C-W> :InteractiveWindow<CR>
nnoremap <silent>     g<M-w> :InteractiveWindow<CR>
nnoremap <silent> <C-W><C-W> :InteractiveWindow<CR>

" Cycle between editor Windows
nnoremap <silent> <C-W>n     :GoNextListedWindow<CR>
nnoremap <silent> <C-W><C-N> :GoNextListedWindow<CR>

nnor <silent> gf;             :GotoFirstTerminalWindow<CR>
nnor <silent> gn;             :Tabview \| terminal<CR>
nnor <silent> g<A-;>          :OpenTerminalHere<CR>
"nmap <silent> <F9>            :ToggleTerminalWindow<CR>
"tmap <silent> <F9>       <F12>:ToggleTerminalWindow<CR>

" Close buffer & window
nnor <C-q> :BufferClose<CR><C-w>c

" Tagbar
nnor <C-A-T> :TagbarToggle<CR>

" set textwidth/fullheight
nmap \|\|     :<C-r>=&tw<CR>wincmd  <Bar><CR>
nmap \\       z999<CR>

" }}}1
"===============================================================================
" Terminal                                                          @term   {{{1

if has('nvim')

tnoremap <F12>      <C-\><C-n>
tnoremap <M-e>      <C-\><C-n>
tnoremap <A-tab>    <C-\><C-N>gt
tnoremap <C-\><C-\> <Esc>

tmap <A-,> <F12>:PreviousTerminalBuffer<CR>
tmap <A-.> <F12>:NextTerminalBuffer<CR>
tmap <C-A-,> <F12>:bp<CR>
tmap <C-A-.> <F12>:bn<CR>

tmap <A-S-W> <F12>:terminal<CR>
tnoremap <C-A-w> <C-\><C-N>:exe '!kill ' . b:term_job_pid <Bar> bdelete<CR>

" Navigation
tmap     <A-space> <F12><C-w>c
tmap     <A-;>     <F12>:
tnoremap ;;        <Esc>;
"tmap    <C-w> <F12><C-w>
tmap     <A-w>     <F12><A-w>
tmap     <A-2>     <F12><C-w>w
" Arrows
tmap     <A-j>     <Esc>j
tmap     <A-k>     <Esc>k
tmap     <A-h>     <Esc>h
tmap     <A-l>     <Esc>l

" Close
tmap <A-c> <F12>:bd!<CR>

tmap <C-D> <C-D><CR>

end

" }}}1
"===============================================================================
" Buffer navigation                                                         {{{1

command! -bar Bnext bnext
command! -bar Bprev bprevious

nnoremap <silent> <A-,> :Bprev<CR>
nnoremap <silent> <A-.> :Bnext<CR>
nnoremap <silent> <A-<> gT
nnoremap <silent> <A->> gt
"nnoremap <BS>  gT
"nnoremap <C-H> gT
"nnoremap <C-L> gt

nnoremap <A-c>     :BufferClose<CR>
nnoremap <A-C>     :BufferReopen<CR>
nnoremap <C-A-w>   :BufferWipeReopen<CR>

nmap g<Tab>  :tabedit <C-r>=bufname(buf#filter('&buflisted')[-1])<CR><CR>
nmap <C-W>t  :tab sp<CR>

nnoremap ]a :tnext<CR>
nnoremap [a :tprevious<CR>
nnoremap ]A :tfirst<CR>
nnoremap [A :tlast<CR>

"nnoremap ]q :qnext<CR>
"nnoremap [q :qprevious<CR>
"nnoremap [Q :qfirst<CR>
"nnoremap ]Q :qlast<CR>

"nnoremap <expr> ]l SpaceSetup('quickfix', ':lnext', ':lnext', ':lprevious', 1)
"nnoremap <expr> [l SpaceSetup('quickfix', ':lprevious', ':lnext', ':lprevious', 0)
"nnoremap ]L :llast<CR>
"nnoremap [L :lfirst<CR>

"nnoremap [c :cprevious<CR>
"nnoremap ]c :cnext<CR>
"nnoremap [C :cfirst<CR>
"nnoremap ]C :clast<CR>
"nmap [t :tprevious<CR>
"nmap ]t :tnext<CR>
"nmap [T :tfirst<CR>
"nmap ]T :tlast<CR>

" }}}1
"===============================================================================
" File navigation & Vimfiler                                                {{{1

nmap <C-M-n> :Edit <C-r>=expand("%:p:h")<CR>/

nnoremap gh         :call ReopenHelp()<CR>

nnoremap <silent>gn      :NERDTree<CR>
nnoremap <silent><C-\>   :NERDTreeToggle<CR>
nnoremap <silent><A-\>   :VimFiler<CR>
nnoremap <silent>g<A-j>  :Autojump<CR>

" goto currentfile dir
nnoremap g<C-D> :VimFiler <C-r>=expand('%:p:h')<CR><CR>
" find currentfile in vimfiler
nnoremap g<C-F> :VimFiler -find<CR>

"                                                                           }}}1
"===============================================================================
" Text manipulation                                                         {{{1

" Targets_and_Surround_config:

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

" Delete Remaining Arguments
nmap dra danad/)\<Bar>]<CR>
" function ( a, b, [d or 45], e, rem, ain, ing)
" function ( a, b, [d or 45], e, rem, ain, ing)


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
vmap s     <Plug>ReplaceOperator
vmap <C-S> <Plug>ReplaceOperator

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
nmap <C-/>      <Plug>NERDCommenterSexy
xmap <C-/>      <Plug>NERDCommenterSexy
" }}}

nmap \c m`<Plug>(camelCaseOperator)iw``
nmap \s m`<Plug>(snakeCaseOperator)iw``
nmap \- m`<Plug>(kebabCaseOperator)iw``

nmap gc <Plug>(camelCaseOperator)
xmap gc <Plug>(camelCaseOperator)
nmap -_ <Plug>(camelCaseOperator)
xmap -_ <Plug>(camelCaseOperator)
nmap __ <Plug>(snakeCaseOperator)
xmap __ <Plug>(snakeCaseOperator)
nmap -- <Plug>(kebabCaseOperator)
xmap -- <Plug>(kebabCaseOperator)
" aka dash-case
nmap -t <Plug>(startCaseOperator)
xmap -t <Plug>(startCaseOperator)
" aka title-ize
"nmap -u <Plug>(upperCaseOperator)
"xmap -u <Plug>(upperCaseOperator)
"nmap -l <Plug>(lowerCaseOperator)
"xmap -l <Plug>(lowerCaseOperator)

" }}}1
"===============================================================================
" Search & replace                                                          {{{1

nmap <A-/>    <Plug>(easymotion-sn)
nmap /        <Plug>(incsearch-forward)
nmap ?        <Plug>(incsearch-backward)
nmap <expr>n  SpaceSetup('search', 'n', 'n', 'N', 1)
nmap <expr>N  SpaceSetup('search', 'n', 'n', 'N', 0)
nmap <expr>*  SpaceSetup('search', '*', 'n', 'N', 1)
nmap <expr>#  SpaceSetup('search', '#', 'n', 'N', 1)
nnoremap   g/ m`g*``

"let s:pulse = 0
"fu! PulseMap (...)
"let s:pulse = get(a:, 1, !s:pulse)
"if (s:pulse)
"nmap n  <Plug>(romgrk-n)<Plug>Pulse
"nmap N  <Plug>(romgrk-N)<Plug>Pulse
"nmap *  <Plug>(romgrk-*)<Plug>Pulse
"nmap #  <Plug>(romgrk-#)<Plug>Pulse
"nmap g/ <Plug>(romgrk-h)<Plug>Pulse
"nmap z* <Plug>(romgrk-h)
"else
"nmap n  <Plug>(romgrk-n)
"nmap N  <Plug>(romgrk-N)
"nmap *  <Plug>(romgrk-*)
"nmap #  <Plug>(romgrk-#)
"nmap g/ <Plug>(romgrk-h)
"nmap z* <Plug>(romgrk-h)
"end
"endfu
"call PulseMap(1)

vmap <A-/>         "/<Plug>(visual-yank-plaintext)n
vmap <silent><C-F> "/<Plug>(visual-yank-plaintext):set hls<CR>
"nmap <C-F> *

" Replace shortcuts
" TODO implement a real replace-mode
nmap <C-R>      :s___g<left><left>
nmap <C-G>      &
nmap <A-r><A-r> g&
nmap <A-r><A-l> :s___g<left><left>
nmap <A-r><A-a> :%s___g<left><left>
nmap <A-r>a     :%s___g<left><left>
nmap <A-r><A-f> :.,$s___g<Left><left>
nmap <A-r><A-j> :.,$s___g<Left><left>
nmap <A-r>j     :.,$s___g<Left><left>
nmap <A-r><A-n> :%s___<Left>
nmap <A-r>n     :%s___<Left>
nmap <A-r><A-p> :%s___gc<Left><left><left>

vmap <A-r>      :s___g<left><left>
"nmap <A-r><A-c> :%s___gc<Left><left><left>
"nmap <A-r><A-o> :%s___<Left>

" }}}1
"===============================================================================
" Macro & Automation                                                        {{{1

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
" Registers & Yank                                                          {{{1

nnoremap gp m`p``
nnoremap gP m`P``

nnoremap <M-p> :call YankCycle()<CR>

let s:lead = 0
fu! YankCycle ()
    let hist = neoyank#_get_yank_histories()['"']

    if getreg('"')==hist[0][0]
        let s:lead = 0 | end

    let s:lead += 1

    undo

    call setreg('"', hist[s:lead][0], hist[s:lead][1])

    normal! ""p
endfu

" }}}1
"===============================================================================
" Quick Utils                                                               {{{1
" @quick
let lt_location_list_toggle_map = '<C-W><C-L>'
let lt_quickfix_list_toggle_map = '<C-W>q'
let lt_height = 10

"vmap zz     <Plug>ZVVisSelection
"nmap zz     <Plug>ZVMotion
nmap gzz <Plug>Zeavim
nmap gzk <Plug>ZVKeyDocset

nmap +0  :HlClear<CR>
nmap +l  :HlLine bg_darkestpurple<CR>
nmap +c  :match  bg_yellow /\v%<C-R>=line('.')<CR>l%<C-R>=col('.')<CR>c./<CR>
nmap +m  :match  bg_red /\v%<C-R>=line("'" . v:register)<CR>l%<C-R>=col("'" . v:register)<CR>c./<CR>

nmap <C-W>y :WindowYank<CR>
nmap <C-W>g :WindowPaste<CR>

nmap \ut :UpdateTags %<CR>
nmap \ur :UpdateTags -r %:h<CR>
nmap \uu :Unite -execute-command=UpdateTags\ -R directory <CR>

nmap \m :Magit<CR>
nmap \s :Startify<CR>

nnoremap r<A-u> ~

" Yank selected text as a plain-text pattern
map <silent><Plug>(visual-yank-plaintext)
            \ :<C-u>call setreg(v:register,
            \ '\V' . escape(visual#GetText(), '\/'))<CR>
"nmap <M-y>   <Plug>(visual-yank-plaintext)
vmap <M-y>   <Plug>(visual-yank-plaintext)

" Quick reload snippet, map
nmap =r :call QuickReload()<CR>

" go man page
nnoremap gK K

" Open link (or file)
nmap <silent> go :!xdg-open <C-R><C-A><CR>

" Re-select last pasted text
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

nnoremap <expr><M--> color#Test(expand('<cword>'))
            \? '"_ciw' . color#Darken(expand('<cword>')) . "\<Esc>"
            \: "\<Nop>"
nnoremap <expr><M-=> color#Test(expand('<cword>'))
            \? '"_ciw' . color#Lighten(expand('<cword>')) . "\<Esc>"
            \: "\<Nop>"
" #00f6ff
" #00a7cd
" #007691

" Replay macro
nmap <M-q> @@

" Move line up/down
nnoremap <C-A-k> ddkkp
nnoremap <C-A-j> ddp

" Yank & Paste * (yank-up, yank-down)
nmap yu yyP
nmap yd yyp

" Indent
nnoremap >> V><Esc>
nnoremap << V<<Esc>
vnoremap > >gv
vnoremap < <gv

" Fixes something
nnoremap <expr>i IndentWithI()

" Edit tmp buffer
nmap <leader>q :edit <C-R>=tempname()<CR><CR>

nmap <M-1> :SynStack<CR>
nmap <M-3> :SynCurrentEdit<CR>
"nmap <F1>  :SynStack<CR>
"nmap <F3>  :SynCurrentEdit<CR>

nmap <expr><C-A-g>  'i' . _#Trim(system("gcolor3"))
imap <expr><C-A-g>  _#Trim(system("gcolor3"))
cmap <expr><C-A-g>  _#Trim(system("gcolor3"))

" Copy current file path
nmap <silent>ycf :let @+=expand("%") <Bar> call Warn('Yanked: ' . @+)<CR>
nmap <silent>ycp :let @+=expand("%:p") <Bar> call Warn('Yanked: ' . @+)<CR>
nmap <silent>ycd :let @+=expand("%:p:h") <Bar> call Warn('Yanked: ' . @+)<CR>

" Insert 愛 (<S-F3>)
imap <expr> <F1>  "\u611B"
imap <expr> <F3>  "\u611B"
imap <expr> <F15> "\u611B"
imap <expr> <F27> "\u611B"

" Gtfo
nnoremap ZZ :wqall<CR>

" }}}1
"===============================================================================
" Operator-pending maps                                                     {{{1

onoremap l $
onoremap h ^

onoremap i<A-p> ip
onoremap <A-p>  ap

" Until...
onoremap ; t;
onoremap : t:

" Until space
onoremap <space>   E
onoremap <M-space> B
" Inside space
onoremap i<space> iW
vnoremap i<space> iW

" Until quote-or-double
"omap <expr> '   't' . <SID>findQuote(1)
"omap <expr> "   'T' . <SID>findQuote(0)

" LHS/RHS operators:                                                         {{{
"let property = value
"omap p  <Plug>(operator-lhs)
"omap P  <Plug>(operator-Lhs)
omap v      <Plug>(operator-rhs)
omap V      <Plug>(operator-Rhs)
omap <M-i>  <Plug>(operator-lhs)
omap <M-I>  <Plug>(operator-Lhs)
"omap <C-i>  <Plug>(operator-rhs)
omap H <Plug>(operator-lhs)
omap L <Plug>(operator-rhs)

xmap <M-i>  <Plug>(operator-lhs)
xmap H <Plug>(operator-lhs)
xmap L <Plug>(operator-rhs)
xmap aH <Plug>(visual-Lhs)
xmap aL <Plug>(visual-Rhs)

" end-of-LHS/RHS                                                             }}}

" }}}1
"===============================================================================
" Session management                                                        {{{1

nmap <silent><leader>ss :wall <Bar> SaveSession<CR><Esc>
nmap         <leader>so :OpenSession!<space>
nmap <silent><leader>sd :OpenSession! default<CR>
nmap <silent><leader>sc :wall <Bar> CloseSession<CR>

" 1}}}
"===============================================================================
" Autocomplete & snippets (<TAB>, <Space>, etc)                             {{{1

let UltiSnipsExpandTrigger       = "<A-;>"
let UltiSnipsJumpForwardTrigger  = "<C-A-n>"
let UltiSnipsJumpBackwardTrigger = "<C-A-p>"

let ycm_key_invoke_completion        =  '<C-Space>'
let ycm_key_list_select_completion   = [ '<Down>' ]
let ycm_key_list_previous_completion = [ '<Up>'   ]

" Ctrl-Space
"inoremap <expr><C-@> pumvisible() ? '<C-X><C-O>' : '<C-C>'
inoremap <expr><C-@> pumvisible() ? '<C-X><C-O>' : '<C-X><C-O>'

inoremap <silent><CR>    <C-r>=I_CR()<CR>
inoremap <silent><Tab>   <C-r>=I_TAB()<CR>
inoremap <silent><S-Tab> <C-r>=I_S_TAB()<CR>
inoremap <silent><Space> <C-r>=I_SPACE()<CR>

smap <Tab>   <Esc>:call UltiSnips#JumpForwards()<CR>
smap <S-Tab> <Esc>:call UltiSnips#JumpBackwards()<CR>

fu! I_CR ()
    if Ulti_canExpand() && pumvisible()
        return Ulti_expand() | end

    if pumvisible()
        return "\<C-Y>\<C-R>=Ulti_expand()\<CR>" | end

    return delimitMate#ExpandReturn() . "\<C-g>u"
endfu

fu! I_SPACE ()
    "if delimitMate#ShouldJump() && pumvisible()
        "return delimitMate#JumpAny() | end

    if pumvisible()
        "let deoplete#disable_auto_complete = 1
        return "\<C-g>\<Esc>" . "\<space>"
    end

    return "\<C-g>u" . "\<space>"
endfu

fu! I_TAB ()
    if pumvisible()
        return "\<C-N>" | end

    if Ulti_canExpand()
        return Ulti_expand()
    end

    if Ulti_canJump()
        return Ulti_jump('1') | end

    if  (getline('.')[col('.')-2] =~? '\w\|\.'
    \ && getline('.')[col('.')-1] !~? '\w' )
        return "\<C-X>\<C-O>" | end


    if delimitMate#ShouldJump()
        let res = delimitMate#JumpAny()
        if !empty(res) | return res | end
    end

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
py3 << EOF
import vim
from UltiSnips import UltiSnips_Manager, _vim
SM = UltiSnips_Manager
EOF

function! Ulti_canExpand()
py3 << EOF
before = _vim.buf.line_till_cursor
sn=SM._snips(before, False)
vim.command('return %i' % len(sn))
EOF
endfunction

function! Ulti_canJump()
py3 << EOF
if SM._cs:
    vim.command('return 1')
else:
    vim.command('return 0')
EOF
endfunction

function! Ulti_jump(dir)
py3 << EOF
if SM._cs:
    if vim.eval('a:dir') == '1':
        SM._jump()
    else:
        SM._jump(True)
EOF
    return ""
endfu

function! Ulti_expand()
py3 << EOF
SM.expand()
EOF
"if SM._cs:
    "tabstops = []
    "for i in SM._cs._tabstops:
        "ts = SM._cs._tabstops[i]
        "try:
            "text = ts.current_text
        "except IndexError:
            "continue
        "if len(text) == 0:
            "continue
        "tabstops.append([ts._start[0] + 1, ts._start[1] + 1, len(text)])
    "vim.command("let g:tabstops = %s" % (tabstops))
"else:
    "vim.command("let g:tabstops = []")
"EOF
    "if !empty(g:tabstops)
        "if exists('g:ts_match')
            "try | call matchdelete(g:ts_match) | catch | endtry
            "unlet g:ts_match
        "end
        "let g:ts_match = matchaddpos('MatchHighlight', g:tabstops)
        ""echo g:tabstops
    "end
    return ""
endfu

function! TAB_expandOrJump()
    call UltiSnips#ExpandSnippetOrJump()
    return g:ulti_expand_or_jump_res
endfu

" }}}1
"===============================================================================
" Visual-mode                                                               {{{1
" xn := visual-mode noremap, excluding select-mode

xnoremap <space>    E
xnoremap <M-space>  B

" Combine with VMarks?
xmap <silent> <C-A-U> :call UltiSnips#SaveLastVisualSelection()<CR>gvm'

" Visual Marks
" TODO use these to exchange text
xmap m <Plug>VisualMarksVisualMark
nmap < <Plug>VisualMarksGetVisualMark

" Niceblock
xmap <C-I> <Plug>(niceblock-I)
xmap I     <Plug>(niceblock-I)
xmap gI    <Plug>(niceblock-gI)
xmap gi    <Plug>(niceblock-gI)
"xmap <C-I> <Plug>(niceblock-I)
xmap A     <Plug>(niceblock-A)
xmap <C-a> <Plug>(niceblock-A)
xmap ga    <Plug>(niceblock-A)
xmap gA    <Plug>(niceblock-A)

" Move visual block.
xnoremap <silent> J :m '>+1<CR>gv=gv
xnoremap <silent> K :m '<-2<CR>gv=gv

" 1}}}
"===============================================================================
" Lang & common maps                                                        {{{1

" Underspace
map! <A-space> _
map! <S-space> _

" Paste @@
cnoremap <A-p> <C-R>"
inoremap <A-p> <Esc>]pa

" Move
"noremap! <A-j> <Down>
"noremap! <A-k> <Up>
noremap! <A-j> <Down>
noremap! <A-k> <Up>
"noremap! <A-h> <Left>
"noremap! <A-l> <Right>

inoremap        <C-A> <C-O>^
inoremap   <C-X><C-A> <C-A>
cnoremap        <C-A> <Home>
cnoremap   <C-X><C-A> <C-A>

inoremap <expr> <C-B> getline('.')=~'^\s*$'&&col('.')>strlen(getline('.'))?"0\<Lt>C-D>\<Lt>Esc>kJs":"\<Lt>Left>"
cnoremap        <C-B> <Left>

inoremap <expr> <C-D> col('.')>strlen(getline('.'))?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"

inoremap <expr> <C-E> col('.')>strlen(getline('.'))<bar><bar>pumvisible()?"\<Lt>C-E>":"\<Lt>End>"

inoremap <expr> <C-F> col('.')>strlen(getline('.'))?"\<Lt>C-F>":"\<Lt>Right>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"

noremap!        <M-b> <S-Left>
noremap!        <M-d> <C-O>dw
cnoremap        <M-d> <S-Right><C-W>
noremap!        <M-BS> <C-W>
noremap!        <M-f> <S-Right>

" 1}}}
"===============================================================================
" Insert maps                                                               {{{1

"imap ;;    <Esc>:
"imap <A-;> <C-r>=delimitMate#JumpAny()<CR>
" Filename autocompletion
"imap <C-f> <C-x><C-f>

"imap <A-d> <C-x><C-e><C-e><C-e><C-e>
"imap <A-u> <C-x><C-y><C-y><C-y><C-y>

" Readline-like bindings
"inoremap <C-b> <Left>
"inoremap <C-f> <Right>
"inoremap <nowait> <C-e> <C-o>$
"inoremap <nowait> <C-a> <C-o>0
"inoremap <M-b> <C-Left>
"inoremap <M-f> <C-Right>

" 1}}}
"===============================================================================
" Command maps                                                              {{{1

"set wildchar=<Tab>
"cmap <A-l> <C-l>
cnoremap <A-;> <C-F>

function! s:cmdClosingPair (char, ...)
    let pos  = getcmdpos()
    let line = getcmdline()
    if line[pos - 1] == a:char
        return "\<Right>"
    else
        return a:char
    end
endfu
function! s:endOfCmdline ()
    return getcmdpos() == 1+len(getcmdline())
endfu
function! CmdBackwardWord ()
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
function! CmdForwardWord ()
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

"cnoremap <C-b> <Left>
"cnoremap <C-f> <Right>
"cnoremap <C-a> <C-b>
"cnoremap <C-e> <C-e>
cnoremap <M-f> <C-R>=CmdForwardWord()<CR>
cnoremap <M-b> <C-R>=CmdBackwardWord()<CR>

" Insert-like mappings
cnoremap <expr>( <SID>endOfCmdline() ? "()<Left>" : "("
cnoremap <expr>[ <SID>endOfCmdline() ? "[]<Left>" : "["
cnoremap <expr>{ <SID>endOfCmdline() ? "{}<Left>" : "{"
cnoremap <expr>) <SID>cmdClosingPair(')')
cnoremap <expr>] <SID>cmdClosingPair(']')
cnoremap <expr>} <SID>cmdClosingPair('}')

" Abbreviations:
" Printing
cabbrev pp    Pp

" Sudo
cabbrev sudo w !sudo tee % >/dev/null

" Other
cabbrev %e expand('%:e')
cabbrev %< expand('%<')
cabbrev %, expand('%<')
cabbrev %f expand('%')
cabbrev %p expand('%:p')
cabbrev %F expand('%:p')
cabbrev %d expand('%:h')
cabbrev %c getcwd()

" 1}}}
"===============================================================================
" Folds, scroll                                                             {{{1

nnoremap z; zz

nnoremap <A-H> 5zh
nnoremap <A-L> 4zl

nnoremap <C-k> za
nnoremap <C-o> zO

" Recursive open/close
nnor zm zM
nnor zr zR
nnor zR zr
nnor zM zm

" Horizontal scroll
nnor zh zH
nnor zl zL
nnor zH 9zh
nnor zL 7zl

" 1}}}
"===============================================================================
" Options: ../plugin/options.vim
"===============================================================================
" vim:
