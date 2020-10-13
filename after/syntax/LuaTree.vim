
if exists(':VimadeBufDisable')
  VimadeBufDisable
end

if exists(':IndentLinesDisable')
  IndentLinesDisable
end

" winhl is hijacked for now
" setl signcolumn=no
" au BufEnter <buffer> setl signcolumn=no
" au WinEnter <buffer> setl signcolumn=no

set winhl=Normal:TabLine,EndOfBuffer:TabLine,SignColumn:TabLineFill,CursorLine:CursorLineInverted

