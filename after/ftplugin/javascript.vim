setlocal foldmethod=syntax
setlocal foldmarker=/*,*/

nnoremap <buffer> <F2>   :SyntasticCheck<CR>
nnoremap <buffer> <F3>   :SyntasticSetLoclist<CR>

nmap <buffer> --d i/***/<Left><Left><CR>
"nnoremap <buffer> -i  A<space>// jshint ignore:line<Esc>

if !filereadable('.tern-project')
    silent !cp ~/templates/tern-project .tern-project
end

" TODO tern config  => see b:ternProjectDir = expand('%:p:h')
if get(g:, 'tern', 0) && filereadable('.tern-project')
    call tern#Enable()
    nmap <buffer> <C-]>      :TernDef<CR>
    nmap <buffer> <C-w><C-]> :TernDefSplit<CR>
    nmap <buffer> <A-p><A-]> :TernDefPreview<CR>
    nmap <buffer> <A-p><A-o> :TernDoc<CR>
    nmap <buffer> <A-v>      :TernRefs<CR>
    nmap <buffer> =r         :TernRefs<CR>
    nmap <buffer> <C-r>      :TernRename<CR>

    nmap <buffer> <C-i> :TernType<CR>
end

nmap <buffer> <C-A-d> :exe 'au! TernAutoCmd' \| call tern#Disable()<CR>

