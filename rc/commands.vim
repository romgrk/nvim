" !::exe [So]

command! -bar   Bnext   bnext
command! -bar   Bprev   bprevious

command! -bar   So      so % | echo '' | call Warn('sourced')
command! -bar   SO      w|So
command! -bar   DD      silent! exe 'normal! ggVGd'
command! -bar   Clear   silent! exe 'normal! ggVGd'

command! -bar   Sudo    write !sudo tee % >/dev/null

command! -bar   Scratch        vnew | setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile

" Generics
command! -nargs=1    Explore          :VimFiler <args>
"command! -nargs=1    Edit             :VimFiler <args>

"command! -range -nargs=1 -complete=file             Replace     <line1>-pu_|<line1>,<line2>d|r <args>|<line1>d
command! -bar -range DeleteTrailingWS noautocmd silent! exe '<line1>,<line2>s/\s\+$//g'

command! -bar        UpdateTerminalSize silent resize +1 | silent resize -1


command! -nargs=1    Nwhich    :Pp maparg(<q-args>, 'n', 0, 1)



" External commands
command!             Top   tab terminal htop
command! -count=0 -nargs=+ -complete=shellcmd
            \ Man     call man#get_page(<count>, <f-args>)


" Highlight
command! -bar -nargs=* -range                         HlClear     match None
command! -bar -nargs=* -range   -complete=highlight   HlLine      match <args> /\v%<line1>l\_.*%<line2>l/
command! -bar -nargs=* -range=0 -complete=highlight   HlChar      match <args> /\v%#./

command! -bar -nargs=1 -complete=highlight Fullfill Pp hi#fullfill(<q-args>)

"command! -bar ConcealLeadingSP :let _leading_sp = matchadd('Conceal', '\v(^\s*)@<=\s', 0, -1, {'conceal': '·'})
"command! -bar ClearLeadingSP   :if matchdelete(get(g:, '_leading_sp')) == -1 | call clearmatches() | end


" Windows etc
command! -bar -nargs=0 WindowYank       :let _yw=[bufnr('%'), winsaveview()]
command! -bar -nargs=0 WindowPaste      :if exists('g:_yw') | exe _yw[0] . 'buffer' | call winrestview(_yw[1]) | end
command! -bar -nargs=0 WindowCopyView   :WindowYank | GoNextListedWindow | WindowPaste
command! -bar -nargs=0 WindowFitText    :call win#().width(&fdc + &nuw + &tw)



" Tabs
command! -bar Tabview    tab sview
command! -bar TabviewRO  tab sview +setlocal\ nomodifiable



" Others
command! -nargs=*    Gcc     !gcc % <args>
command!             GccRun  :execute '!gcc % -o %<' | execute '!./%<'


command! -complete=help -nargs=* ZeavimSearch call zeavim#SearchFor(' ' . <q-args> )

