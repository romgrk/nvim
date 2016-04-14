exe 'source ' . expand('<sfile>:h') . '/vim.vim'
let NERDDelimiterMap['vifm'] = {'left': '"' }
doautocmd FileType vim
"let b:current_syntax = 'vim'
if empty(matchlist(&rtp, 'vifm'))
    set rtp+=/usr/share/vifm/vim
end
