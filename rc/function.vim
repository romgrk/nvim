" File: function.vim
" Author: romgrk
" Date: 7 May 2016
" Exec: !::exe [redraw | echo 'sourced' | source %]

" Printing/logging
com! -nargs=* -complete=highlight EchoHL  call EchoHL(<f-args>)
com! -nargs=* -complete=highlight EchonHL call EchonHL(<f-args>)
com! -nargs=* -complete=highlight Echon   call Echon(<f-args>)

" Syntax-editing/Filetype specific files
com! -nargs=1 -complete=file Edit call Edit(<f-args>)
com! -nargs=1 -complete=file PreviewEdit call PreviewEdit(<f-args>)
com! EditFtplugin                 call Edit(FindFtPlugin())
com! EditFtsyntax                 call Edit(FindFtSyntax())

func! PreviewEdit (file)
    let saved_previewheight = &previewheight
    let &previewheight = 10
    execute 'pedit ' . a:file
    let &previewheight = saved_previewheight
    wincmd P
    nmap <silent><buffer> <Esc><Esc> :BufferClose <Bar> wincmd z<CR>
    "silent normal! g;
endfunc
func! Edit(file) "                                                             {{{
    if !(win#info().listed)
        call GoFirstListedWindow()
    end
    execute 'edit ' . a:file
endfu "                                                                      }}}

fu! FindFtPlugin(...) "                                                      {{{
    let file   = a:0 ? a:1 : bufname('%')
    let ftfile = $vim . '/after/ftplugin/' . &ft . '.vim'
    return ftfile
endfu "                                                                      }}}
fu! FindFtSyntax(...) "                                                      {{{
    "let file   = a:0 ? a:1 : bufname('%')
    let ftdir  = $vim . '/after/syntax/' . &ft . '.vim'
    return ftdir
endfu "                                                                      }}}

com! OpenBufferInNewTab tab sview %

com! -bar BufferClose      call BufferCloseCurrent()
com! -bar BufferReopen     call BufferReopenClosed()
com! -bar BufferWipeReopen call BufferWipeReopen()
fu! BufferCloseCurrent ()
    let bufnum = bufnr("%")
    let altnum = bufnr("#")

    if buflisted(altnum)
        buffer #
    else
        bnext | end

    if bufnum==bufnr('%') | enew | end

    exe "bdelete! " . bufnum
endfu
fu! BufferReopenClosed()
    if !exists('g:session.closed_buffers')
        let g:session.closed_buffers = []
    end
    if len(g:session.closed_buffers) == 0
        echom 'BufferReopen: no previously closed buffer'
        return
    end
    let bufname = remove(g:session.closed_buffers, -1)
    exe 'edit ' . bufname
    exe 'EchoHL TextInfo ''restored buffer ' . bufname . ' from close-list'''
endfu
fu! BufferWipeReopen(...)
    let bufnum = (a:0==1) ? a:1 : bufnr('%')
    let bufname = bufname(bufnum)
    exe bufnum . 'bufdo w'
    exe 'BufferClose'
    exe bufnum . 'bw'
    exe 'e ' . bufname
endfu
fu! StoreBuffer(bufferName)
    if !buflisted(a:bufferName) | return | end
    if &previewwindow           | return | end

    if !exists('g:session.closed_buffers')
        let g:session.closed_buffers = []
    end
    let filename = fnamemodify(a:bufferName, ':p')
    call add(g:session.closed_buffers, filename)
    if (len(g:session.closed_buffers) > 20)
        call remove(g:session.closed_buffers, 15, -1)
    end
endfu
fu! RestorePosition ()
    " Go back to where the cursor was when the file was closed if
    " it exists and is a valid position.
    if (line("'\"") > 1 && line("'\"") <= line("$"))
        normal! `"
    end
endfunc

com! Autojump call Autojump( 'VimFiler' )
fu! Autojump(...)

    let q = input('j ')
    if empty(q) | return | end

    let dir = system('fasd -d ' . q)
    let dir = substitute(dir, '\s\|\n', '', 'g')

    if empty(dir) | return | end

    execute (a:0 ? a:1 . ' ' : 'e ') . dir
endfu

let g:termsize = 10

com! OpenTerminal            call OpenTerminal()
com! OpenTerminalHere        call OpenTerminal(1)
com! GoFirstTerminalWindow   call GoFirstTerminalWindow()
com! ToggleTerminalWindow    call ToggleTerminalWindow()
com! GetTerminalWindow       call GetTerminalWindow()
fu! OpenTerminal(...) "                                                      {{{
    if (a:0 != 0 && a:1 == 1)
        noautocmd cd %:h
        call GetNewTerminalWindow()
        noautocmd cd -
    else
        call GetNewTerminalWindow()
    end
endfu "                                                                      }}}
fu! GoFirstTerminalWindow() "                                              {{{
    let terms = win#filter('&bt=="terminal"')
    if !empty(terms)
        execute terms[0] . 'wincmd w'
    elseif empty(terms)
        let terms = buf#filter('&bt=="terminal"')
        execute 'buffer ' . terms[0]
    else
        call GetNewTerminalWindow()
    end
endfu "                                                                      }}}
fu! ToggleTerminalWindow() "                                                 {{{
    let size = get(g:, 'termsize', 10)
    if !exists('g:termwin') || !g:termwin.exists()
        let winnr = win#first('&ft=="terminal"')
        if (winnr == -1)
            let g:termwin = GetTerminalWindow()
        else
            let g:termwin = win#(winnr)
        endif
        call g:termwin.focus()
        call g:termwin.height(size)
        return | end
    if g:termwin.height() == 0
        call g:termwin.height(size)
        call g:termwin.focus()
    else
        call g:termwin.blur()
        call g:termwin.height(0) | end
endfu "                                                                      }}}
fu! GetTerminalWindow(...) "                                                 {{{
    let terms = buf#filter('&bt=="terminal"')
    if !empty(terms)
        let cmd = 'b' . terms[0]
    else
        let cmd = 'term'
    end
    let size = get(g:, 'termsize', 10)
    let win = win#split('', [cmd])
    call win.height(size)
    let &winheight = size
    return win
endfu "                                                                      }}}
fu! GetNewTerminalWindow(...) "                                              {{{
    let win = win#split('', ['term'])
    let size = get(g:, 'termsize', 10)
    call win.height(size)
    let &winheight = size
    return win
endfu "                                                                      }}}

com! NextTerminalBuffer     call GoNextTerminalBuffer()
com! PreviousTerminalBuffer call GoNextTerminalBuffer(1)
fu! GoNextTerminalBuffer (...)
    let backward = get(a:, 1, 0)
    if backward
        let bufnr = buf#previous('&bt=="terminal"')
    else
        let bufnr = buf#next('&bt=="terminal"')
    end
    if bufnr != bufnr('%')
        exe 'b' . bufnr
    end
    startinsert
endfu

" Window navigation
com! -bar WinMain              call GoFirstListedWindow()
com! -bar GoFirstListedWindow  call GoFirstListedWindow()
com! -bar GoNextListedWindow   call GoNextListedWindow()
com! -bar GoNextVimfilerWindow call GoNextVimfilerWindow()
fu! GoFirstListedWindow() "                                                  {{{
    let windows = win#list('listed')
    if !len(windows)
        return | endif
    let winID = windows[0].winnr
    execute  winID . 'wincmd w'
endfu "                                                                      }}}
fu! GoNextListedWindow() "                                                   {{{
    let windows = win#list('listed')
    let lenght = len(windows)
    if (lenght == 0) || ((lenght == 1) && (windows[0].winnr == winnr()))
        wincmd w
        return
    end

    if (lenght == 1) && !(win#().listed())
        exe windows[0]['winnr'] . 'wincmd w'
        return
    end

    let idx = index(windows, win#())
    if (idx == -1)
        execute windows[0].winnr . 'wincmd w'
    else
        let idx = (idx+1 == len(windows)) ? 0 : idx + 1
        execute windows[idx].winnr . 'wincmd w'
    endif
endfu "                                                                      }}}
fu! GoNextVimfilerWindow() "                                                 {{{
    let n = win#next('&ft=="vimfiler"')
    if (n != winnr())
        execute n . 'wincmd w'
    else
        execute 'wincmd w'
    endif
endfu "                                                                      }}}

com! BookmarkFile     call BookmarkFile()
com! BookmarkLastHelp call BookmarkLastHelp()
com! ReopenHelp       call ReopenHelp()
fu! BookmarkFile(...) "                                                      {{{
    let file = get(a:000, '1', @%)
    let line = get(a:000, '2', line('.'))
    silent! exe '!echo ' . file . ':' . line . ' >> ' . get(g:, 'bookmarks', $HOME . '/.cache/nvim/bookmarks')
    if !exists('g:session["bookmarks"]')
        let g:session["bookmarks"] = []
    end
    call add(g:session['bookmarks'], [file, line])
endfu "                                                                      }}}
fu! BookmarkLastHelp() "                                                     {{{
    if &ft !~? 'help'
        return | endif
    let g:session.last_help=[expand("%:p"), getcurpos()]
endfu "                                                                      }}}
fu! ReopenHelp() abort "                                                     {{{
    if !exists('g:session.last_help')
        call Warn('No last help')
        exe 'Helptags'
        return
    end

    if !_#isList(g:session.last_help[1])
        call Warn('last_help == ', g:session.last_help)
    end
    exe 'split buffer' . g:session.last_help[0]
    call cursor(g:session.last_help[1][1], 0)
    "set filetype=help
	doautocmd Syntax
endfu "                                                                      }}}

" Utils

func! Compare(i1, i2)
    return a:i1 == a:i2 ? 0 : a:i1 > a:i2 ? 1 : -1
endfunc

function! SizeUp ()
    let max = 0+&columns
    let anchors = sort([max/3, 2*max/3, max, 0+&textwidth], 'Compare')
    let size = winwidth(0)
    Pp size, anchors
    let i = 0
    while size >= anchors[i] && i < len(anchors)
        let i += 1
    endwhile

    call win#().width(anchors[i])
endfunc
function! SizeDown ()
    let max = 0+&columns
    let anchors = sort([0, max/3, 2*max/3, &textwidth+0], 'Compare')
    let size = winwidth(0)
    Pp size, anchors
    let i = len(anchors) - 1
    while size <= anchors[i] && i > 0
        let i -= 1
    endwhile

    call win#().width(anchors[i])
endfunc

function! FoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . ' …' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunc
function! FoldFunction(...) "                                                      {{{
    let line    = substitute(getline(v:foldstart),
    \                   '/\*\|\*/\|\("\s*\)\={[{]{\d\=', '', 'g')
    let nl      = v:foldend - v:foldstart
    if nl <= 9
        let prefix = "[" . nl . "]    "
    elseif nl <= 99
        let prefix = "[" . nl . "]   "
    elseif nl <= 999
        let prefix = "[" . nl . "]  "
    elseif nl <= 9999
        let prefix = "[" . nl . "] "
    else
        let prefix = "[...]  "
    endif
    return prefix . line
endfu "                                                                      }}}

fu! AutodetectShiftWidth (...) "                                             {{{
    let silent = get(a:, 1, 1)
    for lnum in range(min([10, line('$')]))
        let line = getline(lnum)
        let i = match(line, '\v^[ ]+\zs[^ ]')
        if (i > 1 && (i % 2 == 0) && i < 10)
            "if &vbs>=5 | echo 'setlocal sw=' . i | end
            if (silent == 1)
                call Info(' (tabs: ' . i . ')')
            end
            silent! exe 'setlocal sw=' . i
            return
        end
    endfor
    "if &vbs>=5 | echo 'No indent found' | end
endfu     "                                                                  }}}


com! -nargs=1                    HAS echo has('<args>')
com! -nargs=1                    Has echo has('<args>')
com! -nargs=* -complete=function LOG call PrintWithoutNewlines(<args>)

fu! PrintChars(start, end, ...) "                                                  {{{
    let start = _#isNumber(a:start) ? a:start : char2nr(a:start)
    let end   = _#isNumber(a:end)   ? a:end   : char2nr(a:end)
    let sep = get(a:000, 0, ' ')

    let i = start
    let res = ''

    if (i < 0xFFFF)
        let format = '%04x'
    else
        let format = '%05x'
    end

    while (i < end)
        execute
            \ 'let res .="\u' . printf(format, (i)) .'"'
        let res .= sep
        let i = i + 1
    endwhile

    let @r=res
    exe 'normal! "rp'
endfu "                                                                      }}}
fu! PrintWithoutNewlines(value) "                                            {{{
    if type(a:value) == type("string")
        let strings = split(a:value, '\n')
    else
        let strings = a:value
    endif
    echo join(strings, ', ')
endfu "                                                                      }}}

com! SynStack       call SyntaxStack()
com! SynCurrent     call SynCurrent()
com! SynCurrentEdit call SynCurrentEdit()
com! ToggleSyntax   call ToggleSyntax()
com! EditSyntax     call EditSyntax()
fu! SynCurrent()
    echo synIDattr(synID(line("."), col("."), 1), "name")
endfu
fu! SynCurrentEdit()
    let @h = synIDattr(synID(line("."), col("."), 1), "name")
    call feedkeys(":hi! link h ")
endfu
fu! SyntaxStack() "                                                          {{{
    let synNames = []
    let lastID       = 0
    for id in synstack(line("."), col("."))
        call add(synNames, synIDattr(id, "name"))
        let lastID = id
    endfor
    if lastID == 0 | return | end
    exe 'EchonHL ' . synIDattr(synIDtrans(lastID), "name") . ' ' .synIDattr(synIDtrans(lastID), "name")
    echon ' ' . string(synNames)
    Pp hi#(lastID)
    echohl None
endfu "                                                                      }}}
fu! ToggleSyntax()
   if exists("g:syntax_on")
      syntax off
   else
      syntax enable
   endif
endfu
fu! EditSyntax (...)
    let file = findfile('syntax/'. &ft . '.vim', &rtp)
    exe 'edit ' . file
endfu
fu! QuickReload ()
    doautocmd Syntax
    exe 'source ' . $vim . '/after/ftplugin/' . &ft . '.vim'
endfu

function! HL_SpName ()
    let id = 1
    while (hi#exists(id))
        let name = synIDattr(id, 'name')
        if (!hi#islink(name) && !empty(name))
            exec 'hi ' . name . ' guisp=.' . tolower(name)
        end
        let id += 1
    endwhile
endfunc

function! Now()
    return strftime("%H:%M")
endfunc
function! Today()
    return strftime("%e %B %Y")
endfunc
function! LastMod()
    let saved_pos = getpos('.')
    let saved_ei = &ei
    let &ei = 'all'

    call cursor(1, 1)

    let max_line = (line("$") > 20) ? 20 : line("$")
    let res = search('\v\c(((Date)|(Last [Mm]odified)):\s*)@<=.*', '', max_line)
    if (res != 0)
        Pp getpos('.')
        ":s//\= Today() /
        exe ':substitute//' . strftime("%e %B %Y") . ' ' . Now() '/'
    end
    "call setpos('.', saved_pos)
    let &ei = saved_ei
endfun

" C
fu! ToggleHeader ()
    if expand('%:e') == 'h'
        let fname = expand('%<') . '.cc'
        if filereadable(fname)
            call Edit(fname)
            return | end
        let fname = expand('%<') . '.cpp'
        if filereadable(fname)
            call Edit(fname)
            return | end
        call Warn('Couldnt find source.')
    else
        let hname = expand('%<') . '.h'
        if filereadable(hname)
            exe 'Edit ' . hname
        else
            call Warn(hname . ' doesnt exist.')
        end
    end
endfu

com! -bar          Hold   call GetChar()
com! -bar          Redraw call Redraw()
com! -nargs=* -bar Reset  call Reset(<args>)
fu! Redraw()
    redraw | echo '' | redraw
endfu
fu! Reset(...)
    exe 'normal! ' . "\<Esc>"
    if (a:0 == 1)
        call setpos('.', a:1)
    end
endfu
fu! CharAt(...)
    if a:0 == 1
        let pos = a:1
    else
        let pos = [a:1, a:2]
    end
    return getline(pos[0])[pos[1]]
endfu
fu! GetChar(...) "                                                           {{{
    if (a:0 == 1)
        echon a:1
    elseif (a:0 == 2)
        call EchonHL(a:1, a:2)
        echohl None
    end
    let c = getchar()
    if (c =~ '^\d\+$')
        let c = nr2char(c)
    end
    return c
endfu "                                                                      }}}

" @params msg
"         (hi, msg)
fu! Input(...) "                                                             {{{
    let [hlgroup, msg] = a:0 && _#isArray(a:1)
                \ ? [a:1[0], a:1[1]]
                \ : ['Question', a:1]

    exec 'echohl ' . hlgroup
    call inputsave()
    let res = call('input', [msg] + a:000[1:2])
    call inputrestore()
    echohl None

    unlet! g:_input
    let g:_input = res

    return res
endfu "                                                                      }}}
