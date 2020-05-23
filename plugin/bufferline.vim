" File: bufferline.vim
" Author: romgrk
" Description: Buffer line
" Date: Fri 22 May 2020 02:22:36 AM EDT
" !::exe [So]


augroup bufferline
    au!
    " Modified-buffer styling
    au BufReadPost,BufNewFile * call BufferReadHandler()
augroup END


command! BufferNext     call s:goto_buffer_relative(+1)
command! BufferPrevious call s:goto_buffer_relative(-1)

command! -nargs=1 BufferJump  call s:goto_buffer(<f-args>)
command!          BufferLast  call s:goto_buffer(-1)

command! BufferMoveNext     call s:move_current_buffer(+1)
command! BufferMovePrevious call s:move_current_buffer(-1)

" Hl groups used for coloring
let s:hl_groups = ['Buffer', 'BufferActive', 'BufferCurrent']

" Current buffers in tabline (ordered)
let s:buffers = []

fu! TabLineUpdate ()
    let &tabline = BufferLine() . '%=' . TablineSession() . Tabpages()
endfu

let s:SPACE = '%( %)'

fu! BufferLine ()
    let bufferNames = {}
    let bufferDetails = map(s:get_updated_buffers(), {k, number -> { 'number': 0+number, 'name': s:get_buffer_name(number) }})

    for i in range(len(bufferDetails))
      let buffer = bufferDetails[i]

      if !has_key(bufferNames, buffer.name)
        let bufferNames[buffer.name] = i
      else
        let other = bufferNames[buffer.name]
        let name = buffer.name
        let results = s:get_unique_name(bufname(buffer.number), bufname(bufferDetails[other].number))
        let newName = results[0]
        let newOtherName = results[1]
        let buffer.name = newName
        let bufferDetails[other].name = newOtherName
        let bufferNames[buffer.name] = buffer
        let bufferNames[bufferDetails[other].name] = bufferDetails[other]
        call remove(bufferNames, name)
      end
    endfor

    let currentnr = bufnr()

    let result = ''

    for i in range(len(bufferDetails))
        let buffer = bufferDetails[i]
        let type = buf#activity(0+buffer.number)
        let isCurrent = currentnr == buffer.number

        let hl  = s:hl_groups[type]
        let hl .= buf#modF(0+buffer.number) ? 'Mod' : ''

        let numberPrefix = s:hl('BufferSign' . (isCurrent ? 'Current' : ''), i + 1)

        let hlprefix   = '%#'. hl .'#'
        let bufExpr = '%{"' . buffer.name .'"}'
        let result .= hlprefix . s:SPACE . numberPrefix . s:SPACE . hlprefix . bufExpr . s:SPACE
    endfor

    let result .= s:hl('TabLineFill')

    return result
endfu
fu! TablineSession (...)
    let name = ''

    if exists('*xolox#session#find_current_session')
        let name = xolox#session#find_current_session()
    end

    if empty(name)
        let name = substitute(getcwd(), $HOME, '~', '')
    end

    return '%#StatusLinePart#%( ' . name . ' %)'
endfunc
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

function! BufferReadHandler()
   if (&bt == '')
      augroup BUFFER_MOD
      au!
      au BufWritePost <buffer> call BufferModChanged()
      au TextChanged  <buffer> call BufferModChanged()
      au TextChangedI <buffer> call BufferModChanged()
      augroup END
   end
endfunc

function! BufferModChanged()
   if (&modified != get(b:,'checked'))
      let b:checked = &modified
      call TabLineUpdate()
   end
endfunc

" Buffer movement

function! s:move_current_buffer (direction)
    call s:get_updated_buffers()

    let currentnr = bufnr('%')
    let idx = index(s:buffers, currentnr)

    if idx == 0 && a:direction == -1
        return
    end
    if idx == len(s:buffers)-1 && a:direction == +1
        return
    end

    let othernr = s:buffers[idx + a:direction]
    let s:buffers[idx] = othernr
    let s:buffers[idx + a:direction] = currentnr

    call TabLineUpdate()
endfunc

function! s:goto_buffer (number)
    call s:get_updated_buffers()

    if a:number == -1
        let idx = len(s:buffers)-1
    else
        let idx = a:number - 1
    end

    silent execute 'buffer' . s:buffers[idx]
endfunc

function! s:goto_buffer_relative (direction)
    call s:get_updated_buffers()

    let currentnr = bufnr('%')
    let idx = index(s:buffers, currentnr)

    if idx == 0 && a:direction == -1
        let idx = len(s:buffers)-1
    elseif idx == len(s:buffers)-1 && a:direction == +1
        let idx = 0
    else
        let idx = idx + a:direction
    end

    silent execute 'buffer' . s:buffers[idx]
endfunc

" Helpers

function! s:get_updated_buffers ()
   if exists('g:session.buffers')
      let s:buffers = g:session.buffers
   elseif exists('g:session')
      let g:session.buffers = []
      let s:buffers = g:session.buffers
   end

    let current_buffers = buf#filter('&buflisted')
    let new_buffers =
        \ filter(
        \   copy(current_buffers),
        \   {i, bufnr -> !s:contains(s:buffers, bufnr)}
        \ )
    " Remove closed buffers
    call filter(s:buffers, {i, bufnr -> s:contains(current_buffers, bufnr)})
    " Add new buffers
    call extend(s:buffers, new_buffers)
    return copy(s:buffers)
endfunc

function! s:contains(list, value)
    for element in a:list
        try
            if element == a:value
                return 1
            end
        catch /.*/
            echom string(element)
            echom string(a:value)
            throw 'Invalid comparison'
        endtry
    endfor
    return 0
endfunction

function! s:get_buffer_name (number)
    if empty(bufname(a:number))
        return '[buffer ' . a:number . ']'
    end
    return buf#tail(a:number)
endfunc

function! s:get_unique_name (first, second)
    let first_parts  = path#Split(a:first)
    let second_parts = path#Split(a:second)

    let length = 1
    let first_result  = path#Join(first_parts[-length:])
    let second_result = path#Join(second_parts[-length:])
    while first_result == second_result && length < max([len(first_parts), len(second_parts)])
        let length = length + 1
        let first_result  = path#Join(first_parts[-min([len(first_parts), length]):])
        let second_result = path#Join(second_parts[-min([len(second_parts), length]):])
    endwhile

    return [first_result, second_result]
endfunc

function! s:hl (...)
    let str = '%#' . a:1 . '#'
    if a:0 > 1
        let str .= join(a:000[1:], '')
    end
    return str
endfu


fu! IsGit (dir)
    let res = system('cd ' . a:dir . ' && git show-branch')
    return (res !~? '^fatal')
endfu
let s:cache  = {}
let s:remote = {}
fu! IsGithub (...)
    let dir = fnamemodify((a:0 ? a:1 : @%), ':p:h')
    if exists('s:cache[dir]')
        return s:cache[dir]
    end

    let out = system('cd ' . dir . ' && git remote show origin')
    if out[0:4] ==# '^fatal'
        let s:cache[dir] = 0
    else
        let s:remote[dir] = matchstr(out, 'Fetch.\+$')
        if out =~# 'github.com'
            let s:cache[dir] = 1
        else
            let s:cache[dir] = 0
        end
    end
    return s:cache[dir]
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

let g:buffer_line = s:
