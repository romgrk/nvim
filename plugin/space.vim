" space.vim - Smart Space key
" Author:       Henrik Öhman <speeph@gmail.com>
" URL:          http://github.com/spiiph/vim-space/tree/master
" Version:      1.8
" ReleaseDate:  2011 jun 09
"
" Licensed under the same terms as Vim itself.
"
" NOTE: Using this script has some problems with 'foldopen', since vim won't
"       open folds if a command is part of a mapping. This is possible to
"       emulate in Normal mode, and in most cases in Visual mode. Only for
"       searches using '/' and '?' have I been unsuccessful in finding a
"       solution.
" ============================================================================

if exists("g:space_debug")
    let g:space_no_character_movements = 0
    let g:space_no_search = 0
    let g:space_no_jump = 0
    let g:space_no_diff = 0
    let g:space_no_brace = 0
    let g:space_no_method = 0
    let g:space_no_section = 0
    let g:space_no_folds = 0
    let g:space_no_quickfix = 0
    let g:space_no_undolist = 0
    let g:space_no_tags = 0
    let g:space_no_git_hunk = 0
    if !has('vim_starting')
        echomsg "Running space.vim in debug mode."
    end
elseif exists("g:space_loaded")
    finish
end
let g:space_loaded = 1

augroup Space
    au!
    autocmd VimEnter * SpaceMakeMappings
augroup END

let s:Space = {}

function! s:Space.new () dict
    let space = copy(self)
    let space.type = ''
    let space.cmd_type = ''
    let space.is_command = 0
    let space.is_spacing = 0
    let space.dir = 1
    let space.next = ''
    let space.prev = ''
    return space
endfunc

command! SpaceMakeMappings call <SID>make_space_mappings()
function! s:make_space_mappings ()
    let g:space = s:Space.new()

    " Mapping of <Space>/<S-Space> and possibly <BS>
    " nnoremap <expr><silent> <space>                  SpaceDo()
    " nnoremap <expr><silent> <M-space>                SpaceReverse(1)
    nnoremap <expr><silent> <Plug>(space-do)         SpaceDo()
    nnoremap <expr><silent> <Plug>(space-next)       SpaceDo(1)
    nnoremap <expr><silent> <Plug>(space-prev)       SpaceDo(0)
    nnoremap <expr><silent> <Plug>(space-reverse)    SpaceReverse(1)
    " nmap g<space> <Plug>(space-do)

    " character movement commands
    "if !exists("g:space_no_character_movements") || !g:space_no_character_movements
        "noremap <expr> <silent> f g:space.setup("char", "f")
        "noremap <expr> <silent> F g:space.setup("char", "F")
        "noremap <expr> <silent> t g:space.setup("char", "t")
        "noremap <expr> <silent> T g:space.setup("char", "T")
        "noremap <expr> <silent> ; g:space.setup("char", ";")
        "noremap <expr> <silent> , g:space.setup("char", ",")
    "endif

    " search commands
    if !exists("g:space_no_search") || !g:space_no_search

        nnoremap <expr> <silent> * g:space.setup("search", "*", 1)
        nnoremap <expr> <silent> # g:space.setup("search", "#", 0)

        nnoremap <expr> <silent> g* g:space.setup("search", "g*", 1)
        nnoremap <expr> <silent> g# g:space.setup("search", "g#", 0)
        nnoremap <expr> <silent> n  g:space.setup("search", "n", 1)
        nnoremap <expr> <silent> N  g:space.setup("search", "N", 0)

        let s:search_mappings = 1
    else
        let s:search_mappings = 0
    endif

    " jump commands
    " NOTE: Jumps are not motions. They can't be used in Visual mode.
    if !exists("g:space_no_jump") || !g:space_no_jump
        nnoremap <expr> <silent> g, g:space.setup("cjump", "g,")
        nnoremap <expr> <silent> g; g:space.setup("cjump", "g;")
        nnoremap <expr> <silent> H  g:space.setup("jump", "\<C-O>")
        nnoremap <expr> <silent> L  g:space.setup("jump", "\<C-I>")
    endif

    " previous/next unmatched ( or [
    if !exists("g:space_no_brace") || !g:space_no_brace
        nnoremap <expr> <silent> ]) g:space.setup("paren", "])")
        nnoremap <expr> <silent> [( g:space.setup("paren", "[(")

        nnoremap <expr> <silent> } g:space.setup("curly", "}", 1)
        nnoremap <expr> <silent> { g:space.setup("curly", "{", 0)
    endif

    " start/end of a method
    if !exists("g:space_no_method") || !g:space_no_method
        nnoremap <expr> <silent> ]m g:space.setup("method_start", "]m")
        nnoremap <expr> <silent> [m g:space.setup("method_start", "[m")

        nnoremap <expr> <silent> ]M g:space.setup("method_end", "]M")
        nnoremap <expr> <silent> [M g:space.setup("method_end", "[M")
    endif

    " previous/next section or '}'/'{' in the first column
    if !exists("g:space_no_section") || !g:space_no_section
        nnoremap <expr> <silent> [[ g:space.setup("section_start", "[[")
        nnoremap <expr> <silent> ]] g:space.setup("section_start", "]]")
        nnoremap <expr> <silent> ][ g:space.setup("section_end", "][")
        nnoremap <expr> <silent> [] g:space.setup("section_end", "[]")
    endif

    " previous/next fold
    if !exists("g:space_no_folds") || !g:space_no_folds
        nnoremap <expr> <silent> zj g:space.setup("fold_next", "zj", 1)
        nnoremap <expr> <silent> zk g:space.setup("fold_next", "zk", 0)
        nnoremap <expr> <silent> ]z g:space.setup("fold_start", "]z", 1)
        nnoremap <expr> <silent> [z g:space.setup("fold_start", "[z", 1)
    endif

    " tag movement
    if !exists("g:space_no_tags") || !g:space_no_tags
        nnoremap <expr> <silent> <C-]> g:space.setup("tag", "\<C-]>")
        let s:tag_mappings = 1
    else
        let s:tag_mappings = 0
    endif

    " undolist movement
    if !exists("g:space_no_undolist") || !g:space_no_undolist
        nnoremap <expr> <silent> g- g:space.setup("undo", "g-")
        nnoremap <expr> <silent> g+ g:space.setup("undo", "g+")
        nnoremap <expr> <silent> u g:space.setup("undo", "u")
        nnoremap <expr> <silent> U g:space.setup("undo", "\<C-R>")
    endif

    " quickfix and location list commands
    if !exists("g:space_no_quickfix") || !g:space_no_quickfix
        " cnoremap <expr> <CR> g:space.parse_cmd_line()
        nnoremap <expr> ]l   g:space.setup("lf", "lne")
        nnoremap <expr> [l   g:space.setup("lf", "lN")
        nnoremap <expr> ]L   g:space.setup("lf", "lfirst")
        nnoremap <expr> [L   g:space.setup("lf", "llast")
        nnoremap <expr> ]c   g:space.setup("qf", "cne")
        nnoremap <expr> [c   g:space.setup("qf", "cN")
        nnoremap <expr> ]C   g:space.setup("qf", "cfirst")
        nnoremap <expr> [C   g:space.setup("qf", "clast")

        let s:quickfix_mappings = 1
    else
        let s:quickfix_mappings = 0
    endif

    " diff next/prev
    "if !exists("g:space_no_diff") || !g:space_no_diff
        "nnoremap <expr> <silent> ]d g:space.setup("diff", "]d")
        "nnoremap <expr> <silent> [d g:space.setup("diff", "[d")
    "endif

    " GitHunk jumps
    if !exists("g:space_no_git_hunk") || !g:space_no_git_hunk
        nnoremap <expr> <silent> ]h g:space.setup("git_hunk", 1)
        nnoremap <expr> <silent> [h g:space.setup("git_hunk", 0)
    endif

endfunc

if (1 == 1 || define_the_regexps)

" TODO: Checkif the '\>!\=' part of the pattern fails when 'iskeyword'
"       contains '!'
" NOTE: Since Vim allows commands like ":'k,'lvim /foo/ *", it's a little
"       tedious to write a perfect regexp.

let s:pre_re = '^\%(' .
    \   '\%(noa\%[utocmd]\s\+\)\=' .
    \   '\%(' .
    \     '\%(' .
    \       '\%(\d\+\)\|' .
    \       '\%(''[0-9a-zA-Z><.]\)\|' .
    \       '\%(\\[/?&]\)\|' .
    \       '[%$.]' .
    \     '\)' .
    \     '\%([-+]\d*\)\=' .
    \   '\)\=' .
    \   ',\=' .
    \   '\%(' .
    \     '\%(' .
    \       '\%(\d\+\)\|' .
    \       '\%(''[0-9a-zA-Z><.]\)\|' .
    \       '\%(\\[/?&]\)\|' .
    \       '[%$.]' .
    \     '\)' .
    \     '\%([-+]\d*\)\=' .
    \   '\)\=' .
    \ '\)\='

let s:qf_re = '\%(' .
    \ 'mak\%[e]\|' .
    \ 'v\%[imgrep]\|' .
    \ 'gr\%[ep]\|' .
    \ 'c\%(' .
    \   'c\|' .
    \   'p\%[revious]\|' .
    \   '[nN]\%[ext]\|' .
    \   '\(fir\|la\)\%[st]\|' .
    \   'r\%[ewind]\|' .
    \   '\(f\|nf\|Nf\|pf\)\%[ile]' .
    \   '\)' .
    \ '\)\>!\='

let s:lf_re = 'l\%(' .
    \ 'mak\%[e]\|' .
    \ 'v\%[imgrep]\|' .
    \ 'gr\%[ep]\|' .
    \ 'l\|' .
    \ 'p\%[revious]\|' .
    \ 'ne\%[xt]\|N\%[ext]\|' .
    \ '\(fir\|la\)\%[st]\|' .
    \ 'r\%[ewind]\|' .
    \ '\(f\|nf\|Nf\|pf\)\%[ile]' .
    \ '\)\>!\='

let s:ta_re = 't\%(' .
    \ 'a\%[g]\|' .
    \ 'n\%[ext]\|' .
    \ 'p\%[revious]\|' .
    \ 'N\%[ext]\|' .
    \ 'r\%[ewind]\|' .
    \ 'f\%[irst]\|' .
    \ 'l\%[ast]\|' .
    \ '\)\>!\='

end

function! s:Space.parse_cmd_line () dict
    let cmd = getcmdline()
    let type = getcmdtype()

    if s:search_mappings && (type == '/' || type == '?')
        return g:space.setup("search", cmd)
    elseif type == ':'
        if s:quickfix_mappings
            if cmd =~ s:pre_re . s:lf_re
                return g:space.setup("lf", cmd)
            elseif cmd =~ s:pre_re . s:qf_re
                return g:space.setup("qf", cmd)
            endif
        endif
        if s:tag_mappings && cmd =~ s:pre_re . s:ta_re
            return g:space.setup("tag", cmd)
        endif
    end
    return "\<CR>"
endfunc

function! s:Space.reset () dict
    if has_key(self, 'check') | unlet! self.check   | end
    if has_key(self, 'postfix') | unlet! self.postfix | end

    let g:space.type = 'undef'
    let g:space.next = ''
    let g:space.prev = ''
    let g:space.dir  = -1
    let g:space.is_command  = 0
endfunc

function! SpaceSetup (type, cmd, ...) " (next, prev, dir)
    call g:space.reset()
    let g:space.type = a:type
    let g:space.next = get(a:000, 1, '')
    let g:space.prev = get(a:000, 2, g:space.next)
    let g:space.dir  = get(a:000, 3, _#isNumber(a:cmd) ? a:cmd : 1 )
    let g:space.is_command  = get(a:000, 4, 0)

    if _#isString(a:cmd)
        let cmd = a:cmd
    else
        let cmd = (g:space.dir == 1 ? next : prev)
    end

    if !empty(cmd)
        let cmd = <SID>maybe_open_fold(cmd)
    end

    let g:space.is_spacing = 2
    augroup SpaceSetup
        au!
        autocmd CursorMoved * call SpaceClear()
    augroup END

    call <SID>debug_msg("SpaceSetup ( type = ".a:type.", command = ".cmd.", dir = ".g:space.dir .")")
    return cmd
endfunc

function! s:Space.setup (type, command, ...) dict
    call g:space.reset()
    let g:space.cmd_type = a:type

    let cmd = a:command
    if a:type == "char"
        let g:space.next = ";"
        let g:space.prev = ","
        let g:space.type = "hor"
        let g:space.dir = get(a:, 1, 1)
        if cmd =~ "[;,]$"
            let cmd = <SID>maybe_open_fold(cmd)
        endif
    elseif a:type == "diff"
        let g:space.next = "]c"
        let g:space.prev = "[c"
        let g:space.dir = get(a:, 1, 1)
    elseif a:type == "method_start"
        let g:space.next = "]m"
        let g:space.prev = "[m"
        let g:space.type = "block"
        let cmd = <SID>maybe_open_fold(cmd)
        let g:space.dir = get(a:, 1, 1)
    elseif a:type == "method_end"
        let g:space.next = "]M"
        let g:space.prev = "[M"
        let g:space.type = "block"
        let cmd = <SID>maybe_open_fold(cmd)
        let g:space.dir = get(a:, 1, 1)
    elseif a:type == "section_start"
        let g:space.next = "]]"
        let g:space.prev = "[["
        let g:space.type = "block"
        let cmd = <SID>maybe_open_fold(cmd)
        let g:space.dir = get(a:, 1, 1)
    elseif a:type == "section_end"
        let g:space.next = "]["
        let g:space.prev = "[]"
        let g:space.type = "block"
        let cmd = <SID>maybe_open_fold(cmd)
        let g:space.dir = get(a:, 1, 1)
    elseif a:type == "paren"
        let g:space.next = "])"
        let g:space.prev = "[("
        let g:space.type = "block"
        let cmd = <SID>maybe_open_fold(cmd)
    elseif a:type == "curly"
        let g:space.next = "}"
        let g:space.prev = "{"
        let g:space.type = "block"
        let cmd = <SID>maybe_open_fold(cmd)
        let g:space.dir = get(a:, 1, ((cmd == '}') ? 1 : 0))
    elseif a:type == "fold_next"
        let g:space.next = "zj"
        let g:space.prev = "zk"
        "let g:space.dir = (cmd == "zj")
        let g:space.type = "fold"
        let g:space.dir = (cmd == "zj" ? 1 : 0)
    elseif a:type == "fold_start"
        let g:space.next = "]z"
        let g:space.prev = "[z"
        let g:space.type = "fold"
        let g:space.dir = (cmd == "]z" ? 1 : 0)
    elseif a:type == "search"
        let g:space.next = "n"
        let g:space.prev = "N"
        let g:space.type = "search"
        let cmd = <SID>maybe_open_fold(cmd)
    elseif a:type == "cjump"
        let g:space.next = "g,"
        let g:space.prev = "g;"
        let g:space.type = "jump"
        let cmd = <SID>maybe_open_fold(cmd)
    elseif a:type == "jump"
        let g:space.next = "\<C-I>"
        let g:space.prev = "\<C-O>"
        let g:space.type = "jump"
        let cmd = <SID>maybe_open_fold(cmd)
    elseif a:type == "tag"
        let g:space.next = "tn"
        let g:space.prev = "tp"
        let g:space.type = "tag"
        if getcmdtype() == ':'
            let cmd = <SID>maybe_open_fold(cmd)
        endif
    elseif a:type == "qf"
        let g:space.next = "cn"
        let g:space.prev = "cN"
        let g:space.type = "quickfix"
        let cmd = <SID>maybe_open_fold(cmd)
    elseif a:type == "lf"
        let g:space.next = "lne"
        let g:space.prev = "lN"
        let g:space.type = "quickfix"
        let cmd = <SID>maybe_open_fold(cmd)
    elseif a:type == "undo"
        if (cmd[0] == "g")
            let g:space.next = "g-"
            let g:space.prev = "g+"
        else
            let g:space.next       = "u"
            let g:space.prev = "\<C-R>"
        end
        let g:space.type = "undo"
        let g:space.type = "undo"
        let cmd = <SID>maybe_open_fold(cmd)
    elseif a:type == "git_hunk"
        let g:space.is_command = 1
        let g:space.next = "GitGutterNextHunk"
        let g:space.prev = "GitGutterPrevHunk"
        let g:space.dir = cmd
        let g:space.type = "jump"
        let cmd = <SID>maybe_open_fold(cmd ? g:space.next : g:space.prev)
    else
        let g:space.type = a:type
    endif
    let g:space.last_cmd = cmd

    if (g:space.dir == -1)
        let g:space.dir =
                    \ (a:command == g:space.prev ? 0 : 1)
    end

    let g:space.is_spacing = 2
    augroup SpaceSetup
        au!
        autocmd CursorMoved * call SpaceClear()
    augroup END

    call <SID>debug_msg("setup_space(type = ".a:type.", command = ".cmd.", dir = ".g:space.dir .")")
    return cmd
endfunc

function! SpaceClear ()
    if (g:space.is_spacing > 1)
        let g:space.is_spacing -= 1
        return
    end
    let g:space.is_spacing = 0
    augroup SpaceSetup
        au!
    augroup END
    " Warn 'space end'
endfunc

function! SpaceDo(...)
    let dir = (a:0 != 0) ? a:1 : g:space.dir
    let cmd = (dir == 1) ? g:space.next : g:space.prev
    let cmd = <SID>maybe_open_fold(cmd)

    if has_key(g:space, 'check')
        let cmd = call(g:space['check'], [cmd, dir] + a:000)
    end

    if has_key(g:space, 'postfix')
        let cmd = cmd . g:space.postfix
    end

    let g:space.is_spacing = 2
    augroup SpaceSetup
        au!
        autocmd CursorMoved * call SpaceClear()
    augroup END

    call <SID>debug_msg("SpaceDo(cmd = " . cmd . ")")
    return cmd
endfunc

function! SpaceShiftDo(...)
    return SpaceDo(!g:space.dir)
endfunc

function! s:Space.maybe_open_fold (cmd)
    return <SID>maybe_open_fold(a:cmd)
endfunc

function! s:maybe_open_fold(cmd)
    if (&foldopen =~ g:space.type && v:operator != "c")
        " special treatment of :ex commands
        if g:space.type == "quickfix" || g:space.type == "tag"
            if getcmdtype() == ':'
                return "\<CR>zvzz"
            else
                return ":\<C-u>" . (v:count ? v:count : "") . a:cmd . "\<CR>zvzz"
            endif
        " special treatment of /foo and ?foo commands
        elseif g:space.type == "search" && getcmdtype() =~ "[/?]"
            return "\<CR>zvzz"
        else
            if mode() =~ "[vV]"
                " NOTE: That this works is probably a bug in vim.  Let's hope
                "       it stays that way. ;)
                return ":\<C-u>normal! gv" . (v:count ? v:count : "")
                    \ . a:cmd . "zvzz\<CR>"
                "return a:cmd . "zv"
            elseif g:space.is_command == 1
                return ":" . a:cmd . "\<CR>zvzz"
            else
                return a:cmd . "zvzz"
            endif
        end
    else
        if g:space.type == "quickfix" || g:space.type == "tag"
            if getcmdtype() == ':'
                return "\<CR>"
            else
                return ":\<C-u>" . (v:count ? v:count : "") . a:cmd . "\<CR>"
            endif
        elseif g:space.type == "search" && getcmdtype() =~ "[/?]"
            return "\<CR>"
        elseif g:space.is_command == 1
            return ":" . a:cmd . "\<CR>"
        else
            return a:cmd
        end
    end
endfunc

function! SpaceReverse(and_jump)
    let g:space.dir = !get(g:, 'space_direction', 0)
    "if (a:and_jump == 1)
    return SpaceDo(g:space.dir)
endfunc

function! s:debug_msg(string)
    Debug a:string
endfunc

function! GetSpaceType()
    return g:space.cmd_type
endfunc

function! GetSpaceMovement()
    if (g:space.dir == 1)
        let cmd = get(g:space, 'next_name', g:space.next)
    else
        let cmd = get(g:space, 'prev_name', g:space.prev)
    end
    return substitute(cmd, '\v[^[:graph:]]+', '', 'g')
endfunc

if exists('g:space_debug')
    SpaceMakeMappings
end

" SETTINGS                                                                   {{{
"
" Set this variable to disable space.vim
"
"   let g:space_loaded = 1
"
" Set this variable to disable select mode mappings
"
"   let g:space_disable_select_mode = 1
"
" These variables disables the usage of <Space> for groups of different
" movement commands
"
" Disable <Space> for character movements, e.g. fFtT;,
"   let g:space_no_character_movements = 1
"
" Disable <Space> for searches, e.g. /?#*nN
"   let g:space_no_search = 1
"
" Disable <Space> for jump commands, e.g. Ctrl-O, Ctrl-I, g, and g;
"   let g:space_no_jump = 1
"
" Disable <Space> for diff commands, e.g. [c and ]c
"   let g:space_no_diff = 1
"
" Disable <Space> for brace movement commands, e.g. [(, ]), [{ and ]}
"   let g:space_no_brace = 1
"
" Disable <Space> for method movement commands, e.g. [m, ]m, [M and ]M
"   let g:space_no_method = 1
"
" Disable <Space> for section movement commands, e.g. [[, ]], [] and ][
"   let g:space_no_section = 1
"
" Disable <Space> for fold movement commands, e.g. [z, ]z, zj and zk
"   let g:space_no_folds = 1
"
" Disable <Space> for tag movement commands, e.g. Ctrl-], :tag, etc.
"   let g:space_no_tags = 1
"
" Disable <Space> for quickfix and location list commands, e.g. :cc, :ll, etc.
"   let g:space_no_quickfix = 1
"
" Disable <Space> for undolist movements, e.g. g- and g+
"   let g:space_no_undolist = 1
"
" Disable <Space> for githunks movements
"   let g:space_no_git_hunk = 1

" It is possible to display the current command assigned to <Space> in the
" status line using the GetSpaceMovement() function. Here's an example:
"
"   function! SlSpace()
"       if exists("*GetSpaceMovement")
"           return "[" . GetSpaceMovement() . "]"
"       else
"           return ""
"       endif
"   endfunc
"   set statusline+=%{SlSpace()}
"                                                                            }}}
" TODO: Make the mapping assignments more dynamical, and allow user defined
"       commands?

" vim: et sts=4 sw=4
