" !::exe [So]
if !has('vim_starting')
    redraw | echo ''
end

let settings = get(g:, 'settings', {})

call s:togglemap('ve',  '&ve', ['all', 'block,onemore'])
call s:togglemap('btl', 'g:buftabline_show', [2, 0])

function! s:togglemap (trigger, what, values)
    if !has('vim_starting') && !empty(maparg('co'.a:trigger,'n'))
        echon ':'.a:trigger.' '
    end
    let g:settings[a:trigger] = [a:what, a:values]
    exe 'nnoremap co' . a:trigger .
                \ " :call \<SID>toggle('" . a:trigger . "')<CR>"
endfunc
function! s:get_what (trigger)
    return get(g:settings, a:trigger, [a:trigger])[0]
endfunc
function! s:get_values (trigger)
    return get( get(g:settings, a:trigger), 1 )
endfunc
function! s:toggle (trigger, ...)
    let what   = s:get_what(a:trigger)
    let values = s:get_values(a:trigger)

    if _#isString(values)
        let cmd = values
    elseif empty(values)
        let cmd = what
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

    echohl ModeMsg
    echo cmd
    echohl None

    execute cmd

    return ''
endfunc

"nmap <silent>=<Esc> :set hls!<CR>
nnoremap <silent>=c     :ColorHighlight<CR>
nnoremap <silent>=t     :call AutodetectShiftWidth()<CR>

nnoremap coGG :call git#Enable()<CR>
nnoremap coGg :call git#Disable()<CR>

nnoremap cosw :setlocal sw=
nnoremap cots :setlocal ts=
nnoremap coft :setlocal ft=
nnoremap cobl :set buflisted!<CR>

nnoremap con  :set nu!<CR>
nnoremap cow  :set wrap!<CR>
nnoremap coL  :set list!<CR>
nnoremap col  :setlocal list!<CR>
nnoremap cocl :set cursorline!<CR>
nnoremap cocc :set cursorcolumn!<CR>
nnoremap covl :call <SID>setVerbose()<CR>
nnoremap cogg :GitGutterToggle<CR>
nnoremap cogs :GitGutterSignsEnable<CR>
nnoremap cosy :SyntasticToggleMode<CR>

nmap <expr>cosl ':set laststatus=' . (&laststatus==2 ? '0' : '2') . '<CR>'

nmap <expr>coaw ':let autowidth=' . !get(g:, 'autowidth', 1) . '<CR>'

nmap <expr>cosl ':set laststatus=' . (&laststatus==2 ? '0' : '2') . '<CR>'
nmap <expr>cotl ':set showtabline=' . (&showtabline==2 ? '0' : '2') . '<CR>'

nmap <expr>cotL ':let tagbar_left=' . !tagbar_left . '<CR>'
nmap <expr>coat ':let tagbar_autoshowtag=' . !tagbar_autoshowtag . '<CR>'
nmap <expr>coap ':let tagbar_autopreview=' . !tagbar_autopreview . '<CR>'

nnoremap <expr>coh  ':let high_contrast=' . !get(g:, 'high_contrast', 0) . '<CR>:silent! syn enable<CR>'

" Foldmethod
nmap z;m :setlocal fdm=marker<CR>
nmap z;s :setlocal fdm=syntax<CR>
nmap z;i :setlocal fdm=indent<CR>
nmap z;I :setlocal fdm=expr<CR>:setlocal foldexpr=GetIndentFold(v:lnum)<CR>
nmap z;e :setlocal fdm=expr<CR>:setlocal foldexpr=
"for level in range(6)
    "exe 'nmap <C-L>' . (level+1) . ' :setl foldlevel=' . level . '<CR>'
"endfor

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
    let verbose = _#Input(['Info', 'set verbose='])
    if !empty(verbose) | let &verbose = verbose | end
endfunc

