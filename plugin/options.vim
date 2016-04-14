" !::exe [so %]
set pastetoggle=<F22>
"map  <F10> :set paste<CR>
"map  <F22> :set nopaste<CR>
imap <F10> <C-O>:set paste<CR>
imap <F22> <NOP>

"nmap <silent>=<Esc> :set hls!<CR>
nmap <silent>=c     :ColorHighlight<CR>
nmap <silent>=t     :call AutodetectShiftWidth()<CR>

nnoremap coGG :call git#Enable()<CR>
nnoremap coGg :call git#Disable()<CR>

nmap cosw :setlocal sw=
nmap cots :setlocal ts=
nmap coft :setlocal ft=
"nmap cov  :setlocal verbose=
nmap cobl :set buflisted!<CR>

nmap cogg :GitGutterToggle<CR>
nmap cogs :GitGutterSignsEnable<CR>
nmap cos  :SyntasticToggleMode<CR>
nmap con  :set nu!<CR>
nmap cow  :set wrap!<CR>
nmap coL  :set list!<CR>
nmap col  :setlocal list!<CR>
nmap cocl :set cursorline!<CR>
nmap cocc :set cursorcolumn!<CR>
nmap cop  :call <SID>pulseMap()<CR>
nmap cov  :call <SID>setVerbose()<CR>

nmap <expr>cosl ':set laststatus=' . (&laststatus==2 ? '0' : '2') . '<CR>'
nmap <expr>cotl ':set showtabline=' . (&showtabline==2 ? '0' : '2') . '<CR>'

nmap <expr>cobl ':let tagbar_left=' . !tagbar_left . '<CR>'
nmap <expr>coat ':let tagbar_autoshowtag=' . !tagbar_autoshowtag . '<CR>'
nmap <expr>coap ':let tagbar_autopreview=' . !tagbar_autopreview . '<CR>'

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
