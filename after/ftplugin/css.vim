setlocal isk+=-

setlocal fdm=marker
setlocal foldmarker={,}

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
  let next_char = getline(line('.'))[next_col]

  if next_char == ';'
    return "\<Right>\<CR>"
  end

  let next_line = getline(line('.') + 1)
  if next_line[len(next_line) - 1] == ';'
    return ';'
  end

  return ";\<CR>"
endfu
