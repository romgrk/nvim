setlocal conceallevel=0

nnoremap <buffer> <expr><CR>  'ciw' . (expand('<cword')=='false' ? 'true' : 'false') . "\<Esc>"

nmap <buffer> <TAB> /\v("[^"]+")\|true\|false\|\{<CR><ESC>
nmap <buffer> <S-TAB> ?\v("[^"]+")\|true\|false\|\{<CR><ESC>

nmap <buffer> ]] h/"[^"]*"<CR><Esc><right>
nmap <buffer> [[ h?"[^"]*"<CR><Esc><right>

nnoremap <buffer> <Tab>        :call <SID>nextField()<CR>
vnoremap <buffer> <Tab>   <Esc>:call <SID>nextField()<CR>
inoremap <buffer> <A-tab> <Esc>:call <SID>nextField()<CR>
nnoremap <buffer> <S-Tab>      :call <SID>nextField(1)<CR>
inoremap <buffer><A-S-Tab> <Esc>:call <SID>nextField(1)<CR>
vnoremap <buffer> <S-Tab> <Esc>`<:call <SID>nextField(1)<CR>

fu! s:nextField (...)
    let flags = (a:0 > 0 ? 'b' : '')
    let field = '"\zs([^"]|\\")*\ze"\s*:'
    let pos = searchpos('\v' . field, flags)
    call pp#print(pos)
    normal! vi"
endfu
