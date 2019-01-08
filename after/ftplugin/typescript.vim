let NERDDelimiterMap['typescript'] =
        \ {'rightAlt': '*/', 'leftAlt': '/*', 'left': '//'}
" let tsuquyomi_disable_quickfix = 1
setlocal foldmethod=syntax
" setlocal omnifunc=tsuquyomi#complete
setlocal completeopt=menu,menuone,preview

nnoremap <buffer> K :YcmCompleter GetDoc<CR>
nnoremap <buffer> <leader>w :YcmCompleter GetType<CR>

vmap <buffer> <A-'>         <Plug>NERDCommenterSexy
nmap <buffer> <A-'>         <Plug>NERDCommenterToggle


" nnoremap <buffer> <C-R>     :YcmCompleter RefactorRename<space>

" inoremap <buffer> <A-h>     <Esc>:YcmCompleter GetType<CR>a

nnoremap <buffer> gd                    :YcmCompleter GoToDefinition<CR>
nnoremap <buffer> <C-W>d    <C-W>v<C-W>l:YcmCompleter GoToDefinition<CR>
nnoremap <buffer> <C-W>]    <C-W>v<C-W>l:YcmCompleter GoToType<CR>

inoremap <buffer> <A-i><A-i> this.<C-X><C-O>
inoremap <buffer> <A-i>s     ${}<Left>
inoremap <buffer> <A-i>p     private<space>
inoremap <buffer> <A-i>d     document.
inoremap <buffer> <A-o>      ()<left>

nmap     <buffer> -e        m'F{Iexport<space><Esc>''
nnoremap <buffer> -d        O/** TODO doc */<Esc>3Bv2e

" inoremap <buffer>
" let s:c_pat = '\v\{((\n\s*.*;)|(\n))*(\n\s*)\s*\n'
" let s:d_pat = '\v\{((\n\s*.*;)|(\n))*(\n\s*)%#\s*\n'

" augroup ts_I
" au!
" " au InsertEnter <buffer> call <SID>ts_test()
" augroup END

function! s:ts_test()
    if search(s:d_pat, 'n')
        vnoremap <buffer><Tab> :<C-U>call <SID>tab_insertion()<CR>
        imap     <buffer><Tab> <C-R>=<SID>tab_insertion()<CR>
        vnoremap <buffer><Esc> <Esc>:call <SID>end_insertion()<CR>
        inoremap <buffer><Esc> <Esc>:call <SID>end_insertion()<CR>
        call feedkeys("m:\<C-R>=Ulti_expand()\<CR>")
    end
endfunc

function! s:tab_insertion ()
    call Ulti_jump(1)
    if (!Ulti_canJump())
        call feedkeys("\<CR>m:")
        call Ulti_expand()
    end
    return ''
endfunc
function! s:end_insertion ()
    vunmap <buffer><Esc>
    iunmap <buffer><Esc>
    vunmap <buffer><Tab>
    iunmap <buffer><Tab>
endfunc

" let p = '\v\{((\n\s+.*;)|(\n\s*))*%#((\n\s+.*;)|(\n\s*))*\n'
" let p = '\v\{((\n\s+\i+\??:\s*\i+;)|(\n\s*))*[\i\s:<>;]*%#[\i\s:<>;\n]+((\n\s+.*;)|(\n\s*))*'
" if search('\v\{(\n\s*.*;)*(\n\s*)%#', 'e') ? ':<Tab>'
" call matchadd('AutoHL', d_pat)
