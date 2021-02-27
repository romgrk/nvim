setlocal fdm=marker
setlocal foldmarker={,}
setlocal formatprg=cssbeautify-cli\ -s\ -i\ '\ \ '

nnoremap <buffer> <F4> :e %<.js<CR>

" nnoremap <buffer><silent> K     :call LanguageClient#textDocument_hover()<CR>
" nnoremap <buffer><silent> gd    :call LanguageClient#textDocument_definition()<CR>
" nnoremap <buffer><silent> <F2>  :call LanguageClient#textDocument_rename()<CR>

inoremap <expr><buffer>: <SID>insert_colon()
inoremap <expr><buffer>; <SID>insert_semicolon()

function! s:insert_colon()
  if col('.') != col('$')
    return ':'
  end

  if getline('.') !~ '\v^\s*(\w|-)+'
    return ':'
  end

  return ":;\<Left>"
endfu

function! s:insert_semicolon()
  let next_col = col('.')-1
  let next_char = getline('.')[next_col]

  if next_char == ';'
    return "\<Right>"
  end

  return ';'
endfu
