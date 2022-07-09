setlocal isk+=-

nnoremap <buffer> <F4> :e %<.js<CR>

inoremap <expr><buffer>: <SID>insert_colon()
inoremap <expr><buffer>; <SID>insert_semicolon()

function! s:insert_colon()
  if col(".") == col("$")
    return ":;\<Left>"
  end

  return ":"
endfu

function! s:insert_semicolon()
  let next_col = col('.')-1
  let next_char = getline('.')[next_col]

  if next_char == ';'
    return "\<Right>\<CR>"
  end

  return ";\<CR>"
endfu
