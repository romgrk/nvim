
let s:winhl = 'Normal:TabLine,EndOfBuffer:TabLine,SignColumn:TabLineFill,CursorLine:CursorLineInverted'

function! s:open_window()
  let windows = win_findbuf(bufnr('LuaTree'))

  if len(windows) > 0
    let side_window = windows[0]
    call win_gotoid(side_window)
    call nvim_win_set_width(0, 55)
    call nvim_win_set_option(0, 'winhl', s:winhl)
    return
  end

  aboveleft vsplit
  call nvim_win_set_width(0, 55)
  call nvim_win_set_option(0, 'winhl', s:winhl)
endfunction

let searchReplace = {
\ 'edit_command': 'Edit',
\ 'close_on_exit': v:false,
\ 'open_window': function('s:open_window'),
\}
