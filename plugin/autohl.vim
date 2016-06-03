" !::exe [Redraw | So | Error 'ha']


command! AutoHLToggle call AutoHLToggle()

augroup autohl
    au!
    au ColorScheme,VimEnter * call <SID>init()
augroup END

nnoremap <silent>       =a       :let &hls=AutoHLToggle()<CR>
nnoremap <silent>       =A       :let &hls=AutoHLToggle(1)<CR>
nnoremap <silent><expr> =h       HighlightWord(1) . CheckCword('')
nnoremap <silent><expr> <S-Home> HighlightWord(1) . CheckCword('')


" Section: Variables {{{1

"let autoHL        = hi#('AutoHL')
"let searchHL      = hi#('Search')
"call hi#("hl_word", searchHL)
let autohl_active = 0
let hl_active     = 0
let s:ignoreESC   = 0

function! s:init ()
    call hi#("AutoHL",   "none",    "#404040", "")
    let g:autoHL   = hi#('AutoHL')
    let g:searchHL = hi#('Search')

    for it in range(9)
        exec 'hi default link hl_'.it.'  Search '
    endfor
endfu
call s:init()


" Section: Functions {{{1

func! HighlightWord(...) "   word, delete, num
    let word = _#isString(a:1) ? a:1 : expand('<cword>')
    let pat = '\<'.word.'\>'

    let num = get(a:, 3, v:count)
    if get(a:, 2, 0) && _#isNumber(get(a:, 2, 0))
        if (num) && get(a:, 2, 0)
            silent! let g:hl_{num} = matchdelete(g:hl_{num})
        else
            call clearmatches()
            let g:hl_{num} = 0
        end
    end
    let g:hl_{num} = matchadd('hl_'.num, pat)
    if _#isNumber(a:1) && (a:1 == 1)
        let @/=pat
    end
    return ''
endfu
func! CheckCword(...)
    let tags = taglist('^'.expand('<cword>').'$')
    if len(tags) == 1
        let match = tags[0]
        if !exists('tags[0].name') | return | end
        redraw

        call EchonHL('TextSpecial', match.name . ' ')
        if exists('match.kind')
            call EchonHL('StorageClass',      match.kind . ' ')
        end
        call EchonHL('Comment',     fnamemodify(match.filename, ':~'))
        echon "\n"
        call EchonHL('Type',      match.cmd[1:-2] . ' ')
    else
        " nop
    end
    return join(a:000, '')
endfu
function! ClearHighlights (...)
    if get(a:000, 1) && _#isNumber(a:1)
        let pattern = '^hl_'.(a:1)
    else
        let pattern = get(a:000, 1, '^hl_\d')
    end

    let result = 0
    for hl in getmatches()
        if (hl.group =~# pattern)
            call matchdelete(hl.id)
            let result = 1
        end
    endfor
    return result
endfunc

fu! AutoHLToggle(...)
    if get(g:, 'autohl_active', 0)
        if s:ignoreESC && !a:0
            return g:autohl_active
        end
        return StopAutoHL(1)
    else
        return StartAutoHL(a:0 ? 1 : 0) | end
endfu
fu! StopAutoHL (...)
    if !get(g:, 'autohl_active', 0)

        if get(g:, 'hl_active', 0) || &hls
            let g:hl_active = 0
            return "m':nohlsearch\<CR>`'"
        else
            return "\<Esc>"
        end
    end
    if s:ignoreESC == 1 && !(a:0 > 0)
        return g:autohl_active
    end
    let g:autohl_active = 0
    let s:ignoreESC = 0
    au! auto_highlight
    set updatetime=4000
    let @/ = ''
    call hi#('Search', g:searchHL)
    call EchoHL('TextError',  'Auto-Highlight: OFF')
    set nohlsearch
    return ""
endfu
fu! StartAutoHL(...)
    let g:autohl_active = 1
    let @/ = ''
    augroup auto_highlight
        au!
        au CursorMoved * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
        au CursorMoved * call CheckCword()
    augroup end
    if (a:0 && a:1 == 1)
        let s:ignoreESC = 1
        "set updatetime=500
    else
        let s:ignoreESC = 0
        "set updatetime=70
    end

    let g:searchHL = hi#('Search')
    call hi#('Search', g:autoHL)

    Success 'Auto-Highlight: ON'

    return g:autohl_active
endfu

"doautocmd B
