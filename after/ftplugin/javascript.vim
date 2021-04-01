" setlocal fdm=syntax


let b:syng_str = ''
let b:syng_strcom = ''

nnoremap <buffer> <F4>       :e %<.scss<CR>

nnoremap <buffer> <leader>fi :JsFileImport<CR>


finish

if &ft ==# 'javascript.jsx'
  finish
end

function! s:set_jsx()
  if &ft ==# 'javascript'
    setfiletype javascript.jsx
  end
endfunc
call timer_start(0, {->s:set_jsx()})

function! s:detect_jsx()
  let filename = expand('%:t')
  if (match(filename, '\U') > -1) && (&ft ==# 'javascript')
    setfiletype javascript.jsx
  end
  " echom [filename, match(filename, '\U'), &ft]
endfunc

call s:detect_jsx()
