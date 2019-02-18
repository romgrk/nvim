setlocal foldmethod=syntax

" let b:used_javascript_libs = ''

nmap <buffer> --d   i/***/<Left><Left><CR>
nmap <buffer> +s    ggO'use strict';<ESC>

nnoremap <buffer> g<A-'> I{/* <Esc>A */}<Esc>

" if !exists('*tern#Complete')
  " nmap <buffer>       <F2>  :YcmCompleter RefactorRename<CR>
  " nmap <buffer>        gd   :YcmCompleter GoTo<CR>
  " nmap <buffer>        gD   :YcmCompleter GoToDefinition<CR>
  " nmap <buffer> <leader>r   :YcmCompleter GoToReferences<CR>
  " nmap <buffer> <leader>d   :YcmCompleter GetDoc<CR>
  " nmap <buffer> <leader>w   :YcmCompleter GetType<CR>
" else
  " nmap <buffer>       <F2>  :TernRename<CR>
  " nmap <buffer>       <F3>  :call tern#Disable()<CR>
  " nmap <buffer>       <F4>  :call tern#Enable()<CR>
" end


" nnoremap <buffer> K   :YcmCompleter GetDoc<CR>

" nnoremap <buffer><silent> gK    :call LanguageClient#textDocument_hover()<CR>
" nnoremap <buffer><silent> gd    :call LanguageClient#textDocument_definition()<CR>
" nnoremap <buffer><silent> <F2>  :call LanguageClient#textDocument_rename()<CR>
" nnoremap <buffer><silent> <F3>  :call LanguageClient#textDocument_references()<CR>

inoremap <A-8> /*<CR><CR>/<Up>


iabbrev <buffer> cosnt const


let b:syng_str = ''
let b:syng_strcom = ''
