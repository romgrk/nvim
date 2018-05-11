" !::exe [So]


command! -bar   So      so % | echo '' | call Warn('sourced')
command! -bar   SO      w|So

command! -bar   Sudo    write !sudo tee % >/dev/null
command! -bar   Scratch        vnew | setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile

" Generics

command! -bar -range DeleteTrailingWS noautocmd silent! exe '<line1>,<line2>s/\s\+$//g'
command! -bar        UpdateTerminalSize silent resize +1 | silent resize -1
command! -nargs=1    Nwhich    :Pp maparg(<q-args>, 'n', 0, 1)


" Highlight
command! -bar -nargs=1 -complete=highlight Fullfill call hi#fullfill(<q-args>)


" Windows etc
command! -bar -nargs=0 WindowYank       :let _yw=[bufnr('%'), winsaveview()]
command! -bar -nargs=0 WindowPaste      :if exists('g:_yw') | exe _yw[0] . 'buffer' | call winrestview(_yw[1]) | end
command! -bar -nargs=0 WindowCopyView   :WindowYank | GoNextListedWindow | WindowPaste
command! -bar -nargs=0 WindowFitText    :call win#().width(&fdc + &nuw + &tw)


" Tabs
command! -bar Tabview    tab sview
command! -bar TabviewRO  tab sview +setlocal\ nomodifiable
