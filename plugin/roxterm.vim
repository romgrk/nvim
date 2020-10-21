
if $NVIM_IN_ROXTERM != '1'
  finish
end

augroup roxterm
  au VimLeave * :call roxterm#save_dimensions()
augroup end

function! roxterm#save_dimensions () abort
    let saved_dimensions = []
    let saved_dimensions += roxterm#get_dimension()
    let saved_dimensions += roxterm#get_position()
    call system('mkdir -p ~/.cache/nvim')
    call writefile(saved_dimensions, $HOME . '/.cache/nvim/dimensions.sh')
endfunc

function! roxterm#get_dimension() abort
  return [
      \ 'export LINES=' . &lines,
      \ 'export COLUMNS=' . &columns,
  \ ]
endfunc

function! roxterm#get_position() abort
  try
    let id = trim(system('xprop -root | awk ''/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}'''))
    let info = trim(system('xwininfo -id ' . id))
    let absolute = filter(split(info, "\n"), {_, line -> line =~ 'Absolute'})

    let x = matchstr(absolute[0], '\v:\s*\zs\S+')
    let y = matchstr(absolute[1], '\v:\s*\zs\S+')

    if x == '0'
      let x = 100
    end
    if y == '0'
      let y = 100
    end

    return [
        \ 'export X=' . x,
        \ 'export Y=' . y,
    \ ]
  catch
    return []
  endtry
endfunc
" ')
" xprop -root | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}'
