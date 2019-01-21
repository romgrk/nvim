" File: bugger-line.vim
" Author: romgrk
" Description: Buffer line
" Date: 10 Sep 2015
" !::exe [So]


command! BufferNext     call s:goto_buffer(+1)
command! BufferPrevious call s:goto_buffer(-1)

command! BufferMoveNext     call s:move_current_buffer(+1)
command! BufferMovePrevious call s:move_current_buffer(-1)

" Hl groups used for coloring
let s:hl_groups = ['Buffer', 'BufferActive', 'BufferCurrent']

" Current buffers in tabline (ordered)
let s:buffers = []

fu! TabLineUpdate ()
    let &tabline = BufferLine() . '%=' . TablineSession() . Tabpages()
endfu
fu! BufferLine ()
    let result = []

    let bufferNames = {}
    let bufferDetails = map(s:get_updated_buffers(), {k, number -> { 'number': number, 'name': buf#tail(number) }})

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

    for buffer in bufferDetails
        let type = buf#activity(0+buffer.number)

        let hl  = s:hl_groups[type]
        let hl .= buf#modF(0+buffer.number) ? 'Mod' : ''

        let hlprefix   = '%#'. hl .'#'
        let bufExpr = '%{"'. buffer.name .'"}'
        let sep = '%( %)'
        let result += [hlprefix . sep . bufExpr . sep]
    endfor

    let part = join(result, '') . s:hl('TabLineFill')

    return part
endfu
fu! TablineSession (...)
    let name = ''

    if exists('*xolox#session#find_current_session')
        let name = xolox#session#find_current_session()
    end

    if empty(name)
        let name = substitute(getcwd(), $HOME, '~', '')
    end

    return '%#SessionTab#%( ' . name . ' %)'
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

function! s:goto_buffer (direction)
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

    echom 'buffer' . s:buffers[idx]
    execute 'buffer' . s:buffers[idx]
endfunc

" Helpers

function! s:get_updated_buffers ()
    let current_buffers = buf#filter('&buflisted', '!empty(bufname(v:val))')
    let new_buffers =
        \ filter(
        \   current_buffers,
        \   {i, bufnr -> !s:contains(s:buffers, bufnr)}
        \ )
    " Remove closed buffers
    let s:buffers =
        \ filter(s:buffers, {i, bufnr -> !s:contains(current_buffers, bufnr)})
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

function! s:get_unique_name (first, second)
    let first_parts  = split(a:first, '/')
    let second_parts = split(a:second, '/')

    let length = 1
    let first_result  = first_parts[-length:]
    let second_result = second_parts[-length:]
    while first_result == second_result && length < max([len(first_parts), len(second_parts)])
        let length = length + 1
        let first_result  = join(first_parts[-min([len(first_parts), length]):], '/')
        let second_result = join(second_parts[-min([len(second_parts), length]):], '/')
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
