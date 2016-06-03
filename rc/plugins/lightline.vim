" File: lightline.vim
" Author: romgrk
" Description: configuration of lightline.vim
" Date: 10 Sep 2015
" !::exe [so % | call lightline#init() | call lightline#colorscheme()]

augroup TabLine
    au!
    au BufNew *    call TabLineUpdate()
    au BufWinEnter,BufEnter,BufWritePost * call TabLineUpdate()
    au TabEnter,TabNewEntered *            call TabLineUpdate()
augroup END

" Dictionnaries
let s:L = {
\ 'colorscheme':          'wombat',
\ 'separator':            { 'left': '', 'right': '' },
\ 'subseparator':         { 'left': '', 'right': '' },
\ 'tabline_separator':    { 'left': '▎', 'right': '' },
\ 'tabline_subseparator': { 'left': '', 'right': '' },
\ 'enable':               { 'tabline': 0, 'statusline': 1, },
\ 'tab':                  { 'active':   [ 'filename', 'modified' ],
\                           'inactive': [ 'filename', 'modified' ], },
\ }
let s:L.tab_component_function = {
\     'modified':  'ModifiedFlag',
\     'session':   'SessionLine',
\ }
let s:L.mode_map = {
\ 'c' :      ':',     '?':       '?',     't' :      'T',
\ 'n' :      'N',     'v' :      '<',     's' :      'S',
\ 'i' :      'I',     'V' :      'V',     'S' :      'S',
\ 'R' :      'R',     "\<C-v>":  '^',     "\<C-s>":  'S', } "                }}}
"let s:L.component = {
"\     'percent':      'FilePercentFlag',
let s:L.component_function = {
\     'ctrlpmark':    'CtrlPMark',
\     'diff':         'CurrentDiff',
\     'fileformat':   'FileformatFlag',
\     'filetype':     'SL_filetype',
\     'fugitive':     'FugitiveHead',
\     'github':       'GithubFlag',
\     'icon':         'lightline#icon',
\     'inactiveHead': 'SL_Inactive',
\     'modified':     'ModifiedFlag',
\     'nameHL':       'StatuslineNameHL',
\     'name':         'StatuslineName',
\     'readonly':     'ROFlag',
\     'relativePath': 'LightLineRelativePath',
\     'space':        'SlSpace',
\     'syntastic':    'SyntasticStatuslineFlag',
\     'tag':          'SL_tag',
\ }
let s:L.component_expand = {
\     'buffers':      'BufferLine',
\     'filehead':     'FileHead',
\     'tableft':      'TablineLeft',
\ }
let s:L.component_type = {
\     'tableft':   'warning',
\     'icon':       'icon',
\     'modified':   'warning',
\     'syntastic':  'warning',
\ }

" Statusline                                                                 {{{
let s:L.active = {
    \ 'left' : [ [ 'fugitive', 'nameHL', 'modified', 'readonly', ],
    \            [ 'tag', 'ctrlpmark'                  ],
    \            [ 'space',                            ], ],
    \ 'right': [ [ 'percent' ],
    \            [ 'name',   ],
    \            [ 'github', ], ], }
"let s:L.inactive = {
    "\ 'right': [ [ 'percent'  ],
    "\            [ 'github', 'readonly'  ],
    "\             ]
    "\} "                                                                    }}}
let s:L.tabline = {
    \ 'left': [ [ 'tabs' ] ],
    \ 'right': [ [ 'session' ] ] , }

let g:lightline = s:L

function! SlSpace()
    if !&buflisted
        return ""
    end
    if exists("g:space")
        let type = GetSpaceType()
        let cmd = GetSpaceMovement()
        return cmd
    end

    return ''
endfunc
function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('nR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction
let ctrlp_status_func = { 'main': 'CtrlPStatusFunc_1',
                        \ 'prog': 'CtrlPStatusFunc_2', }
function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked, ...)
    let g:lightline.ctrlp_focus = a:focus
    let g:lightline.ctrlp_byfname = a:byfname
    let g:lightline.ctrlp_regex = a:regex
    let g:lightline.ctrlp_prev = a:prev
    let g:lightline.ctrlp_item = a:item
    let g:lightline.ctrlp_next = a:next
    let g:lightline.ctrlp_marked = a:marked
    return lightline#statusline(0)
endfunction
function! CtrlPStatusFunc_2(str)
    return lightline#statusline(0)
endfunction
let tagbar_status_func = 'TagbarStatusFunc'
function! TagbarStatusFunc(current, sort, fname, flags, ...) abort
    let colour = a:current ? '%#StatusLine#' : '%#StatusLineNC#'
    let flagstr = join(a:flags, '')
    if flagstr != ''
        let flagstr = '[' . flagstr . '] '
    endif
    let g:lightline.tagb_current = a:current
    let g:lightline.tagb_sort = a:sort
    let g:lightline.tagb_fname = a:fname
    let g:lightline.tagb_flags = a:flags
    return colour . a:fname . ' [sorted by ' . a:sort . '] ' . flagstr
endfunction

fu! s:hl (...)
    let str = '%#' . a:1 . '#'
    if a:0 > 1
        let str .= join(a:000[1:], '')
    end
    return str
endfu
fu! s:hlt (...)
    let str = '%#' . a:1 . '#'
    let str .= '%' . (a:0>2?a:2 :'') . '{"' . (a:0>2?a:3 : a:2) . '"}'
    return str
endfu
fu! s:b (expr)
    return '%{' . a:expr . '}'
endfu
fu! s:t (...)
    return '%{"' . a:1 . '"}'
endfu
fu! s:e (...)
    return '%' . a:1 . '{' . a:2 . '}'
endfu
fu! s:p (...)
    return '%' . a:1 . '(' . a:2 . '%)'
endfu
fu! s:dim (a, b)
    return a:a . '.' . a:b
endfu

let s:bufHL = ['BufTabLineFill', 'BufTabLineActive', 'BufTabLineCurrent']

fu! TabLineUpdate ()
    let &tabline = BufferLine() . '%=' . TablineSession() . Tabpages()
endfu
fu! TabGutter ()
    let w = &numberwidth
    if w == 0
        return ''
    end
    let ftab = get(g:, 'filertab', 0)

    let w += ftab

    let split = ftab ? s:hlt('TabGutterSplit', '▎') : ''
    let text = s:hlt('TabGutter', '  ' . '' . '  ')
    let part = s:p( s:dim(w, w), split . text)
    return part
endfu
fu! TablineLeft()
    let win = win#(1)
    if win.w('&filetype') !~# 'vimfiler'
        let g:filertab = 0
        return ''
    else
        let g:filertab = 1
    end

    let dir = win.b('vimfiler').current_dir
    let title = fnamemodify(dir, ':~')[:-2]
    "let prompt = '  '
    let prompt = ' ' . FtIcon('dir.alt') . ' '

    let icons = ''
    if filewritable(dir)!=2
        let icons .= Icon('lock') | end

    let w = win.width()
    let wp = strwidth(prompt)
    let wi = strwidth(icons)
    let wpi = wp + wi
    let wt = w - wpi

    if strwidth(title) > wt
        let title = '…' . title[-(wt-1):]
    end

    let head  = s:p( s:dim('', wp),   s:hlt('FilerIcon', prompt))
    let text  = s:p( s:dim(wpi-w, w), s:hlt('FilerTab', title))
    let state = s:p( s:dim('', wi),   s:hlt('FilerAccent', icons))

    let part = s:p('-' . w . '.' . w , head . text . state)
    let g:tabp = part

    return part
endfu
fu! TablineSession (...)
    return '%#SessionTab#%( ' . SessionLine() . ' %)'
endfunc
fu! SessionLine (...)
    let name = ''

    if exists('*xolox#session#find_current_session')
        let name = xolox#session#find_current_session()
    end

    if empty(name)
        let name = substitute(getcwd(), $HOME, '~', '')
    end

    return name
endfu
fu! BufferLine ()
    let result = []
    for num in buf#filter('&buflisted', '!empty(bufname(v:val))')
        let type = buf#activity(0+num)
        let mod  = buf#modF(0+num) ? 'M' : ''
        let hlprefix   = '%#'. s:bufHL[type] . mod .'#'
        " let iconprefix = '%#'. s:bufHL[type] .'Icon#'
        " let iconExpr  = '%{FtIcon("'. bufname(num) .'")}'
        " let result += [iconprefix . iconExpr]
        let bufExpr = '%{buf#tail('. num .')}'
        let sep = '%( %)'
        let result += [hlprefix . sep . bufExpr . sep]
    endfor

    let part = join(result, '') . s:hl('TabLineFill')
    return part
endfu
fu! Tabpages ()
    if tabpagenr('$') == 1
        return ''
    end
    let tabpart = ''
    for t in range(1, tabpagenr('$'))
        if !empty(t)
            let style = (t == tabpagenr()) ?  'TabLineSel'
                        \ : gettabvar(t, 'hl', 'LightLineRight_tabline_0')
            let tabpart .= s:hl(style, ' ' . t[0] . ' ')
        end
    endfor
    return tabpart
endfu

function! lightline#mode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? s:L.mode_map[mode()] : ''
endfunction

fu! GetTerminalTitle ()
    let title = get(b:, 'term_title', 0)
    if empty(title)
        return 'TERMINAL'
    else
        let tokens = split(title, ':')
        return len(tokens) > 1 ? tokens[1][1:] : tokens[0]
    endif
endfu
fu! GetTerminalSubtitle ()
    let title = get(b:, 'term_title', 0)
    if empty(title)
        return ''
    else
        return join(split(title, ':')[1:], ':')
    endif
endfu
fu! GetTerminalDecoration()
    let terms = buf#filter('&buftype=="terminal"')
    if empty(terms)
        return '' | end
    let tnum    = bufnr('%')
    let deco = []
    for t in terms
        if t == tnum
            let deco += ['●']
        else
            let deco += ['○']
        end
    endfor
    return join(deco, ' ')
endfu

fu! IsGit (dir)
    let res = system('cd ' . a:dir . ' && git show-branch')
    return (res !~? '^fatal')
endfu
fu! s:gitBranch (dir)
    let head = a:dir.'/.git/HEAD'
    if filereadable(head)
        let patt = '\v/\zs[^/]+\ze\s*$'
        let branch = matchstr(
            \join(readfile(head), ''), patt)
        if strlen(branch)
            return branch
        end
    end
    return ''
endfu

" FIXME
fu! lightline#icon ()
    if &bt ==# 'terminal'
        return '' | end
    if &previewwindow
        return '' | end
    if &ft ==# 'vimfiler'
        let branch = s:gitBranch(b:vimfiler.current_dir)
        if strlen(branch)
            return branch . ' '
        else
            return Icon('dir') | end
    end
    if &ft ==# 'unite'
        return ' ' | end
    if &ft ==# 'help'
        return '' | end

    let i = FtIcon(expand('%'))
    return len(i) ? i : ''
endfu

fu! CurrentDiff()
    if &bt == 'terminal'
        return '' | end
    if &ft == 'vimfiler'
        return '' | end
    if &ft ==# 'unite'
        return 'Unite' | end
    if !&modifiable || &readonly
        return '' | end "

    let sum = gitgutter#hunk#summary()
    if len(sum) == 0
        return
    end
    if sum[0]==0 && sum[1]==0 && sum[2]==0
        return ''
    end
    let diff = []
    if sum[0] != 0
        call add(diff, sum[0] . ' ' )
    end
    if sum[1] != 0
        call add(diff, sum[1] . ' '  )
    end
    if sum[2] != 0
        call add(diff, sum[2] . ' ' )
    end
    return lightline#concatenate(diff, 1)
endfu

fu! SL_tag()

    if &bt ==# 'terminal' | return '' | end
    if &ft ==? 'vimfiler' | return '' | end
    if &ft ==? 'unite'    | return '' | end
    if &ft ==# 'help'     | return '' | end
    if get(b:, 'panel')   | return '' | end

    "return '%{tagbar#currenttag("%s", "")}'
    if exists('*tagbar#currenttag')
        return tagbar#currenttag("%s", "")
    else
        return ''
    end
    "let cword = expand('<cword>')
    "let tags = taglist('^' . cword . '$')
    "let res = ' '
    "if len(tags) > 0
        "let tag = tags[0]
        "if exists('tag["name"]')
            "if tag['name'] ==# cword && get(tags[0], 'language', '') ==? b:current_syntax
                ""redraw
                ""call EchonHL('TextSpecial', tags[0]['cmd'])
                ""call EchonHL('Comment', string(tags[0]))
                "let res = tag["kind"] . ':' . tag["name"]
                "if exists('tag["type"]')
                    "let res = res . ': ' . tag['type']
                "end
                "return res
            "end
        "end
    "end
    ""if len(res) < 15
        ""let res = res . repeat(' ', 15 - len(res))
    ""endif
    ""let ct = tagbar#currenttag('%s','', 'sf')
    "return res
endfu

fu! GithubFlag ()
    "if exists('b:github')
        "return b:github | end

    if IsGithub(@%)
        let b:github = Icon('github') . ' '
    else
        let b:github = '' | end

    return b:github
endfu

fu! FileHead()
    if &ft ==? 'vimfiler'
        return '' | end
        "return vimfiler#get_status_string() | end
    if &ft ==? 'unite'
        return unite#get_status_string() | end
    if &ft ==? 'help'
        return 'HELP' | end
    if &ft ==? 'terminal'
        return '' | end

    if get(b:, 'panel', 0)
        return bufname('%') | end

    let fugitive = LightLineFugitive()
    if !empty(fugitive)
        return fugitive
    endif

    return ''
endfu
fu! LightLineRelativePath ()
    if &bt ==? 'terminal' | return '' | end
    if buf#ispanel()      | return '' | end

    let file = bufname('%')
    let path = fnamemodify(file, ':.:h')
    if path ==# '.'
        return '' | end
    let hpath = fnamemodify(file, ':~:h')
    if len(hpath) < len(path)
        let tokens = split(hpath, '/')[1:]
    else
        let tokens = split(path, '/')
    endif
    return lightline#concatenate(tokens, 0)
endfunc

fu! s:basename (a)
    let p = (a:a[-1:]=='/')
            \? a:a[0:-2]
            \: a:a
    return fnamemodify(p, ':t')
endfu

fu! StatuslineNameHL () abort
    let fname = expand('%:t')
    return  fname == 'ControlP' ? 'ControlP' :
          \ fname == '__Tagbar__' ? get(g:lightline, 'tagb_current', 'tagb') :
          \ fname =~ '__Gundo\|NERD_tree' ? '' :
          \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
          \ &ft == 'unite' ? unite#get_status_string() :
          \ &bt == 'terminal' ? GetTerminalTitle() :
          \ &ft == 'unite' ? unite#get_status_string() :
          \ &ft == 'vimshell' ? vimshell#get_status_string() :
          \ ('' != fname ? fname : '[No Name]')
    "return GetTerminalDecoration() | end
    "if &ft ==# 'vimfiler' return s:basename(b:vimfiler.current_dir)
endfu
fu! StatuslineName () abort
    let fname = expand('%:t')
    return  fname == 'ControlP' ? get(g:lightline, 'ctrlp_item', 'item') :
          \ fname == '__Tagbar__' ? get(g:lightline, 'tagb_current', 'tagb') :
          \ fname =~ '__Gundo\|NERD_tree' ? '' :
          \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
          \ &ft == 'unite' ? unite#get_status_string() :
          \ &bt == 'terminal' ? GetTerminalTitle() :
          \ &ft == 'unite' ? unite#get_status_string() :
          \ &ft == 'vimshell' ? vimshell#get_status_string() :
          \ ('' != fname ? fname : '[No Name]')
    "return GetTerminalDecoration() | end
    "if &ft ==# 'vimfiler' return s:basename(b:vimfiler.current_dir)
endfu

fu! ModifiedFlag(...)
    if (a:0)
        let tab = a:1
        let modified = gettabwinvar(tab, 1, '&modified')
        return modified ? '✚' : ''
    end

    if get(b:, 'panel', 0) | return '' | end
    return &modified ? '✚' : ''
endfu
fu! ROFlag()
    if get(b:, 'panel', 0) | return '' | end
    return &readonly ? '' : '' "
endfu

fu! FugitiveHead()
    let _ = fugitive#head()
    return strlen(_) ? _.' ' : ''
endfu

fu! FileformatFlag()
    if buf#ispanel()
        return '' | end
    let formatIcons = {
    \ 'unix': '',
    \ 'mac':  '',
    \ 'dos':  '',
    \}
    return formatIcons[&fileformat]
endfunction

fu! SL_filetype()
    if &bt ==? 'terminal' | return '' | end
    if &ft ==? 'vimfiler' | return '' | end
    if buf#ispanel()
        return '' | endif
    return FtIcon()
endfunc
fu! SL_Inactive ()
    if &ft ==? 'vimfiler'
        return vimfiler#get_status_string() | end

    if &bt ==# 'terminal'
        return GetTerminalSubtitle()[1:] | end

    if &ft ==# 'help'
        return expand('%:h:h:t') | end

    return bufnr('%')
endfu

fu! FilePercentFlag()
    if &ft ==? 'vimfiler' | return ''                 | end
    if &bt ==? 'terminal' | return b:terminal_job_pid | end
    if buf#ispanel()
        return '' | endif
    let percent = (100 * line('.') / line('$')) . '%'
    return percent
endfunc


