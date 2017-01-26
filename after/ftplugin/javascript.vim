setlocal foldmethod=syntax

" let b:used_javascript_libs = ''

nmap <buffer> --d   i/***/<Left><Left><CR>
nmap <buffer> +s    ggO'use strict';<ESC>

nmap <buffer>       <F2>  :YcmCompleter RefactorRename<CR>
nmap <buffer>        \r   :YcmCompleter RefactorRename<CR>
nmap <buffer>        gd   :YcmCompleter GoTo<CR>
nmap <buffer>        gD   :YcmCompleter GoToDefinition<CR>
nmap <buffer> <leader>r   :YcmCompleter GoToReferences<CR>
nmap <buffer> <leader>d   :YcmCompleter GetDoc<CR>
nmap <buffer> <leader>w   :YcmCompleter GetType<CR>

if !filereadable('.tern-project') && filereadable('~/templates/tern-project')
    silent !cp ~/templates/tern-project .tern-project
    Warn 'Created ' . fnamemodify('.tern-project', ':p')
end
