" File: bugger-line.vim
" Author: romgrk
" Description: Buffer line
" Date: 10 Sep 2015
" !::exe [So]

fu! s:hl (...)
    let str = '%#' . a:1 . '#'
    if a:0 > 1
        let str .= join(a:000[1:], '')
    end
    return str
endfu

let s:bufHL = ['Buffer', 'BufferActive', 'BufferCurrent']

fu! TabLineUpdate ()
    let &tabline = BufferLine() . '%=' . TablineSession() . Tabpages()
endfu

fu! BufferLine ()
    let result = []

    let bufferNames = {}
    let buffers = buf#filter('&buflisted', '!empty(bufname(v:val))')
    let buffers = map(buffers, {k, number -> { 'number': number, 'name': buf#tail(number) }})
    for i in range(len(buffers))
      let buffer = buffers[i]
      if !has_key(bufferNames, buffer.name)
        let bufferNames[buffer.name] = i
      else
        let other = bufferNames[buffer.name]
        let name = buffer.name
        let buffer.name = bufname(buffer.number)
        let buffers[other].name = bufname(buffers[other].number)
        let bufferNames[buffer.name] = buffer
        let bufferNames[buffers[other].name] = buffers[other]
        call remove(bufferNames, name)
      end
    endfor

    for buffer in buffers
        let type = buf#activity(0+buffer.number)

        let hl  = s:bufHL[type]
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
