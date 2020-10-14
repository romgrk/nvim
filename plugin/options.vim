"===========================================================================
" File: options.vim
" Author: romgrk
" Date: 04 Jun 2016
" Description: options toggling
" !::exe [So]
"===========================================================================

let g:togglekey = 'co'
let g:togglemap = { }

command! -bar OptionsWidget call <SID>show_toggle_input()

command! -bar -nargs=+ ToggleMap :call <SID>toggle_map(<args>)
command! -bar -nargs=+ AlternMap :call <SID>map_alternating(<args>)
command! -bar   EditVerboseLevel :call <SID>setVerbose()

function! s:toggle_map (...)
    if type(a:000[1]) == 1 && len(a:000) == 2
        call s:map_toggle_cmd(
                    \ a:000[0],
                    \ a:000[1])

    elseif has_key(a:000[1], 'cmd')
        call s:map_toggle_cmd(
                    \ a:000[0],
                    \ a:000[1]['cmd'],
                    \ a:000[2:])

    elseif has_key(a:000[1], 'value')
        call call('s:map_toggle_value',
                    \  [a:000[0]]
                    \+ [a:000[1]['value']]
                    \+  a:000[2:] )

    elseif len(a:000) == 3
        call s:map_toggle_value(
                    \ a:000[0],
                    \ a:000[1],
                    \ a:000[2])
    end
endfunc
function! s:map_toggle_cmd (trigger, cmd, ... )
    let m = { }
    let m['trigger'] = a:trigger
    let m['what'] = a:cmd
    let m['lhs'] = printf('%s%s', g:togglekey, a:trigger)
    let m['rhs'] = printf(":\<C-U>%s\<CR>", a:cmd)
    let m['cmd'] = a:cmd
    if (a:0)
        call extend(m, type(a:1) == 3 ? a:1 : a:000 ) " list
    end

    let g:togglemap[a:trigger] = a:cmd

    exe 'nnoremap ' . m['lhs'] . ' ' . m['rhs']
endfunc
function! s:map_toggle_value (trigger, what, ...)
    let m = { }
    let m['trigger'] = a:trigger
    let m['what']    = a:what
    let m['values']  = []
    let m['lhs']     = printf('%s%s', g:togglekey, a:trigger)
    let m['rhs']     = printf(":call \<SID>toggle(%s)\<CR>", string(a:trigger))

    if (a:0 == 0)
        " <nop>
    elseif (a:0 == 1 && type(a:1) == 4) " object
        call extend(m, a:1)

    elseif type(a:1) == 3 " list
        let m['values'] = (a:1)
    end

    if (a:0 == 2 && type(a:2) == 4) " object
        call extend(m, a:2)
    end

    let g:togglemap[a:trigger] = l:m

    exe 'nnoremap ' . m['lhs'] . ' ' . m['rhs']
endfunc
function! s:map_alternating (trigger, what, values, ...)
    let m = { }
    let m['trigger'] = a:trigger
    let m['what'] = a:what
    let m['values']  = a:values " : String[]
    let m['next']    = 0
    let m['lhs'] = printf('%s%s', g:togglekey, a:trigger)
    let m['rhs'] = printf(":call \<SID>altern(%s)\<CR>", string(a:trigger))
    if (a:0)
        call extend(m, a:1) | end

    let g:togglemap[a:trigger] = l:m
    execute 'nnoremap <silent>' . m['lhs'] . ' ' . m['rhs']
endfunc

function! s:show_toggle_input ()
    let buffer = ''
    let char = ''
    let remaining_options = keys(g:togglemap)
    let match = -1
    while (1 == 1)
        redraw
        call Log('Question', 'Change option: ')
        call Log('Normal', buffer . repeat(' ', 5 - len(buffer)))

        if (match != -1)
            let km = remaining_options[match]
            call Log('MoreMsg', printf("( %s )", g:togglemap[km]['what']))
        end

        call Info("\n\t")
        for l:idx in range(len(remaining_options))
            let hl = (match == l:idx) ? 'Visual' : 'Keyword'
            call Log(hl, remaining_options[l:idx])
        endfor

        let char = GetChar()
        if (char ==# "\<Esc>")
            return
        elseif (char ==# "\<Tab>")
            let match +=1
            if (match == len(remaining_options))
                let match = -1
            end
        elseif (char ==# "\<S-Tab>")
            let match -= 1
            if (match == -1)
                let match = len(remaining_options)
            end
        elseif (char ==# "\<CR>")
            let remaining_options = [ get(remaining_options, match, '') ]
        else
            let buffer .= char
            let match = 1
        end

        let condition = printf('v:val =~# "^%s"', escape(buffer, '\"'))
        let remaining_options = filter(remaining_options, condition)

        if empty(remaining_options)
            call Debug(condition, buffer, char)
            return
        elseif (len(remaining_options) == 1)
            redraw
            exe 'normal ' . g:togglekey . remaining_options[0]
            return
        end
    endwhile
endfunc
function! s:altern (trigger)
    let km = g:togglemap[a:trigger]
    let n   = km['next']
    let cmd = km['values'][l:n]
    let km['next'] = (n + 1) % len(km['values'])

    if has_key(km, 'pre')
        execute km['pre'] | end

    execute cmd

    if has_key(km, 'post')
        execute km['post'] | end

    call Log('MoreMsg', 'Toggled: ')
    call Log('Normal', km['what'])
    call Log('Comment', "(" . cmd . ")")

    return ''
endfunc
function! s:toggle (trigger, ...)
    let m = g:togglemap[a:trigger]
    let what   = m['what']
    let values = m['values']

    if empty(values)
        let cmd = 'let ' . what . '=' . !eval(what)
    else
        let current = eval(what)
        let newval = values[0]
        for key in range(len(values))
            let val = values[key]
            if (current == val)
                let newval = get(values, key+1, newval)
                break
            end
        endfor
        let cmd = 'let '.what.' = '.string(newval)
    end

    if has_key(m, 'pre')
        execute m['pre'] | end

    execute cmd

    if has_key(m, 'post')
        execute m['post'] | end

    call Log('MoreMsg', 'Toggled: ')
    call Log('Normal', what . "\n")
    call Log('Comment', cmd)

    return ''
endfunc


" Toggle by values

ToggleMap 'cl',  { 'value': '&cul' }
ToggleMap 'cc',  { 'value': '&cuc' }
ToggleMap 'l',   { 'value': '&list' }
ToggleMap 'n',   { 'value': '&number' }
ToggleMap 've',  { 'value': '&virtualedit' }, ['all', 'block,onemore']
ToggleMap 'le',  { 'value': '&conceallevel' },      [0,     2]

ToggleMap 'h',   { 'value': '&hlsearch' },         [0,     1]
ToggleMap 'sl',  { 'value': '&laststatus' },       [0,     2]
ToggleMap 'tl',  { 'value': '&showtabline' },      [0,     2]
ToggleMap 'bl',  { 'value': '&buflisted' },        [0,     1]
ToggleMap 'w',   { 'value': '&l:wrap' },           [0,     1]
ToggleMap 'sn',  { 'value': 'g:sneak#streak' },    [0,     1]
ToggleMap 'sw',  { 'value': '&shiftwidth' },       [2,     4], { 'post': 'let &ts = &sw' }

ToggleMap 'cn',  'ContextToggle'
ToggleMap 'hl',  'HexokinaseToggle'
ToggleMap 'ft',  'call feedkeys(\":setfiletype \", \"t\")'
ToggleMap 'gs',  'GitGutterSignsEnable'
ToggleMap 'gu',  'GitGutterToggle'
ToggleMap 'id',  'IndentLinesToggle'
ToggleMap 'il',  'IlluminationToggle'
ToggleMap 'jn',  'setfiletype javascript.node'
ToggleMap 'js',  'setfiletype javascript'
ToggleMap 'jx',  'setfiletype javascript.jsx'
ToggleMap 'vl',  'EditVerboseLevel'
ToggleMap 'vm',  'VimadeToggle'

AlternMap 'gg',  'Git integration', ['GitGutterEnable', 'GitGutterDisable']
AlternMap 'al',  'ALE Linter',      ['ALEEnable', 'ALEDisable']
AlternMap 'lc',  'Language Client', ['LanguageClientStop', 'LanguageClientStart']
AlternMap 'coc', 'CoC',             ['CocDisable', 'CocEnable']



" Foldmethod
nmap z;m :setlocal fdm=marker<CR>
nmap z;s :setlocal fdm=syntax<CR>
nmap z;i :setlocal fdm=indent<CR>
nmap z;I :setlocal fdm=expr<CR>:setlocal foldexpr=GetIndentFold(v:lnum)<CR>
nmap z;e :setlocal fdm=expr<CR>:setlocal foldexpr=


" Cool widget
" Verbose options reference
let s:verboseHelp = [
    \[1,	'When the shada file is read or written.' ],
    \[2,	'When a file is ":source"''ed.' ],
    \[5,	'Every searched tags file and include file.' ],
    \[8,	'Files for which a group of autocommands is executed.' ],
    \[9,	'Every executed autocommand.' ],
    \[12,	'Every executed function.' ],
    \[13,	'When an exception is thrown, caught, finished, or discarded.' ],
    \[14,	'Anything pending in a ":finally" clause.' ],
    \[15,	'Every executed Ex command (truncated at 200 characters).']
    \]
function! s:setVerbose ()
    for line in s:verboseHelp
        call pp#dump(line[0])
        echon "\t"
        call pp#dump(line[1])
        echo ''
    endfor
    let verbose = Input(['Info', 'set verbose='])
    if !empty(verbose) | let &verbose = verbose | end
endfunc

" vim: fdm=syntax
