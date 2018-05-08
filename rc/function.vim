" File: function.vim
" Author: romgrk
" Date: 7 May 2016
" Exec: !::exe [redraw | echo 'sourced' | source %]

" Printing/logging
com! -bar -nargs=* -complete=highlight EchoHL  call EchoHL(<f-args>)
com! -bar -nargs=* -complete=highlight EchonHL call EchonHL(<f-args>)
com! -bar -nargs=* -complete=highlight Echon   call Echon(<f-args>)

" Syntax-editing/Filetype specific files
com! -bar -nargs=+ -complete=file Edit call Edit(<f-args>)
com! -bar -nargs=1 -complete=file PreviewEdit call PreviewEdit(<f-args>)
com! -bar EditFtplugin                 call Edit(FindFtPlugin())
com! -bar EditFtsyntax                 call Edit(FindFtSyntax())

func! Edit(...) "                                                             {{{
  if !(win#info().listed)
    call GoFirstListedWindow()
  end
  for element in a:000
    if type(element) == 1 " string
      let files = split(glob(element), '\n')
    elseif type(element) == 3 " list
      let files = element
    else
      throw 'Unsupported type'
    end
    if len(files) > 0
      call map(files, 'execute("edit " . v:val)')
    else
      execute 'edit ' . element
    end
  endfor
endfu "                                                                      }}}
func! PreviewEdit(file)
    let saved_previewheight = &previewheight
    let &previewheight = 10
    execute 'pedit ' . a:file
    let &previewheight = saved_previewheight
    wincmd P
    nmap <silent><buffer> <Esc><Esc> :BufferClose <Bar> wincmd z<CR>
    "silent normal! g;
endfunc

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


function! ExecTerminal(command, arguments)
  let quoted_arguments = join(map(copy(a:list), {key, val -> expand(val)}), ' ')
  split
  wincmd j
  15wincmd _
  execute 'term ' . a:command . ' ' . s:quote_arguments(a:arguments)
  normal! i
endfunction


com! -nargs=* GitOpenUnmergedFiles call GitOpenUnmergedFiles(<f-args>)
com! -nargs=* GitPush              call GitPush(<f-args>)
com! -nargs=* GitStatus            call GitStatus(<f-args>)
com! -nargs=* GitDiff              call GitDiff(<f-args>)
function! GitOpenUnmergedFiles()
  " let cd = system('git rev-parse --show-cdup')[:-2]
  let files = systemlist('git diff --name-only --diff-filter=U')
  if len(files) == 0
    echo 'No unmerged files to open'
    return
  end
  call Edit(files)
endfunction
function! GitPush(...)
  call ExecTerminal('git push', a:000)
endfunction
function! GitStatus(...)
  call ExecTerminal('git status', a:000)
endfunction
function! GitDiff(...)
  call ExecTerminal('git diff', a:000)
endfunction


com! -nargs=1 NewProject   call NewProject(<f-args>)
fu! NewProject(name)
  wall!
  CloseSession

  let dir = $HOME . '/projects/' . a:name
  let out = system('mkdir ' . dir)
  if out != ''
    echoerr out
  end

  execute 'cd ' . dir
  execute 'SaveSession ' . a:name
endfu


com! -bar FileDelete       call FileDeleteCurrent()
com! -bar BufferClose      call BufferCloseCurrent()
com! -bar BufferReopen     call BufferReopenClosed()
com! -bar BufferWipeReopen call BufferWipeReopen()
com! -bar BufferTabview    tab sview %
fu! FileDeleteCurrent()
  let file = fnamemodify(bufname('%'),':p')
  BufferClose
  if !bufloaded(file) && delete(file)
    echoerr 'Failed to delete "'.file.'"'
  endif
  unlet file
endfu
fu! BufferCloseCurrent ()
    let bufnum = bufnr("%")
    let altnum = bufnr("#")

    if buflisted(altnum)
        buffer #
    else
        bnext | end

    if bufnum==bufnr('%')
        enew | end

    if bufexists(bufnum)
        exe "bdelete! " . bufnum | end

    doautocmd BufEnter
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
        normal! zz
        silent! normal! zO
    end
endfunc


let g:termsize = 10

com! -bang OpenTerminal            call OpenTerminal()
com! -bang OpenTerminalHere        call OpenTerminal(1)
com! -bang GoFirstTerminalWindow   call GoFirstTerminalWindow()
com! -bang ToggleTerminalWindow    call ToggleTerminalWindow('<bang>'==#'!')
fu! OpenTerminal(...) "                                                      {{{
    if (a:0 != 0 && a:1 == 1)
        noautocmd cd %:h
        call GetNewTerminalWindow()
        noautocmd cd -
    else
        call GetNewTerminalWindow()
    end
endfu "                                                                      }}}
fu! GoFirstTerminalWindow(...) "                                              {{{
    let terms = win#filter('&bt=="terminal"')
    if !empty(terms)
        execute terms[0] . 'wincmd w'
        return
    end

    let terms = buf#filter('&bt=="terminal"')
    if !empty(terms)
        execute 'buffer ' . terms[0]
        return
    end

    if len(a:000) != 0
        let fallback = get(a:000, 1)
        execute fallback
        return
    end

    call GetNewTerminalWindow()
endfu "                                                                      }}}
fu! ToggleTerminalWindow(nofocus,...) "                                                 {{{
    if &buftype ==# 'terminal'
        let termwin = win#(0)
    elseif exists('w:termwin') && w:termwin.exists()
        let termwin = get(w:, 'termwin')
    else
        let thiswin = win#(0)
        let w:termwin = GetNewTerminalWindow()
        " let w:termwin.parent = win#(0)
    end

    if exists('l:termwin') && termwin.height() > 0
        call termwin.blur()
        call termwin.height(0)
        return | end

    let size = w:termwin.w('&winheight')
    if (!size || size <= 5)
        let size = get(g:,'termheight',10)
    end

    if w:termwin.height() == 0
        call w:termwin.height(size) | end

    if _#isFalse(a:nofocus)
        call w:termwin.focus() | end

endfu "                                                                      }}}
fu! GetTerminalWindow(...) "                                                 {{{
" com! GetTerminalWindow       call GetTerminalWindow()
    let terms = buf#filter('&bt=="terminal"')
    if !empty(terms)
        let cmd = 'b' . terms[0]
    else
        let cmd = 'term'
    end
    let size = get(g:, 'termsize', 10)
    let win  = win#split('', [cmd])
    call win.height(size)
    let &winheight = size
    return win
endfu "                                                                      }}}
fu! GetNewTerminalWindow(...) "                                              {{{
    let saved_eventignore = &eventignore
    let saved_winnr = winnr()
    let &eventignore = 'all'

    let win    = win#split('below split', ['term'])
    let w:parent = saved_winnr
    let height = get(g:,'termheight',10)
    call win.height(height)
    let &winheight = height

    doautocmd TermOpen

    exec saved_winnr.'wincmd w'

    let &eventignore = saved_eventignore
    return win
endfu "                                                                      }}}


com! -bar NextBuffer     bnext
com! -bar PreviousBuffer bprevious

com! -bar NextTerminalBuffer     call GoNextTerminalBuffer()
com! -bar PreviousTerminalBuffer call GoNextTerminalBuffer(1)
fu! GoNextTerminalBuffer (...)                                              "{{{
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
endfu                                                                       "}}}


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
        let nr = windows[0]['winnr']
    else
        let idx = index(windows, win#())   " if   idx   == -1
        let idx = (idx + 1) % len(windows) " then idx+1 == 0
        let nr = windows[idx].winnr        " thus idx   >= 0
    end

    execute (nr == winnr() ? '' : nr) . 'wincmd w'
endfu "                                                                      }}}
fu! GoNextVimfilerWindow() "                                                 {{{
    let n = win#next('&ft=="vimfiler"')
    if (n != winnr())
        execute n . 'wincmd w'
    else
        execute 'wincmd w'
    endif
endfu "                                                                      }}}


" Window-resize
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
function! ToggleWindows ()
    let currentWindow = winnr()

    let windows = win#filter('&bt ==# "quickfix" || &pvw')

    if len(windows) == 0
        try
            :lopen
        catch /.*/
            try
                :copen
            catch /.*/
            endtry
        endtry
        if (currentWindow != winnr())
            " Go back
            wincmd p
        end
    else
        call _#eachx(windows,
                \ 'call win#close(v:val - v:key)')
    end
endfunc


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
        " execute 'Helptags'
        return
    end

    if !_#isList(g:session.last_help[1])
        call Warn('last_help == ', g:session.last_help)
    end

    exe 'vertical view ' . g:session.last_help[0]

    call cursor(g:session.last_help[1][1], 0)
    "set filetype=help
    doautocmd Syntax
endfu "                                                                      }}}


function! ForAllMatches (command, options)
    " Remember where we parked...
    let orig_pos = getpos('.')

    " Work out the implied range of lines to consider...
    let in_visual = get(a:options, 'visual', 0)
    let start_line = in_visual ? getpos("'<'")[1] : 1
    let end_line   = in_visual ? getpos("'>'")[1] : line('$')

    " Are we inverting the selection???
    let inverted = get(a:options, 'inverse', 0)

    " Are we modifying the buffer???
    let deleting = a:command == 'delete'

    " Honour smartcase (which :lvimgrep doesn't, by default)
    let sensitive = &ignorecase && &smartcase && @/ =~ '\u' ? '\C' : ''

    " Identify the lines to be operated on...
    exec 'silent lvimgrep /' . sensitive . @/ . '/j %'
    let matched_line_nums
    \ = reverse(filter(map(getloclist(0), 'v:val.lnum'), 'start_line <= v:val && v:val <= end_line'))

    " Invert the list of lines, if requested...
    if inverted
        let inverted_line_nums = range(start_line, end_line)
        for line_num in matched_line_nums
            call remove(inverted_line_nums, line_num-1)
        endfor
        let matched_line_nums = reverse(inverted_line_nums)
    endif

    " Filter the original lines...
    let yanked = ""
    for line_num in matched_line_nums
        " Remember yanks or deletions...
        let yanked = getline(line_num) . "\n" . yanked

        " Delete buffer lines if necessary...
        if deleting
            exec line_num . 'delete'
        endif
    endfor

    " Make yanked lines available for putting...
    call setreg(v:register, yanked)

    " Return to original position...
    call setpos('.', orig_pos)

    " Report results...
    redraw
    let match_count = len(matched_line_nums)
    if match_count == 0
        unsilent echo 'Nothing to ' . a:command . ' (no matches found)'
    elseif deleting
        unsilent echo match_count . (match_count > 1 ? ' fewer lines' : ' less line')
    else
        unsilent echo match_count . ' line' . (match_count > 1 ? 's' : '') . ' yanked'
    endif
endfunction

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


com! SynStack              call SyntaxStack()
com! GetCurrentSyntaxGroup Pp GetCurrentSyntaxGroup()
com! SynCurrentEdit        call SynCurrentEdit()
com! ToggleSyntax          call ToggleSyntax()
com! EditSyntax            call EditSyntax()
fu! GetCurrentSyntaxGroup()
    return synIDattr(synID(line("."), col("."), 1), "name")
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


function! Now()
    return strftime("%H:%M")
endfunc
function! Today()
    return strftime("%e %B %Y")
endfunc


function! GetArgs()
  let args = []
  for i in range(argc())
    call add(args, argv(i))
  endfor
  return args
endfunction
function! ClearArgs()
  let argsLength = argc()
  for i in range(argsLength)
    exe 'argdel ' . argv(argsLength - i - 1)
  endfor
endfunction


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
fu! Compare(i1, i2)
    return a:i1 == a:i2 ? 0 : a:i1 > a:i2 ? 1 : -1
endfunc
fu! Input(...) " @params msg | (hi, msg)                                     {{{
    let [hlgroup, msg] = a:0 && _#isList(a:1)
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
