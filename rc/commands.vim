" !::exe [So]

command! -bar   So      so % | echo '' | call Warn('sourced')
command! -bar   SO      w|So
command! -bar   DD      silent! exe 'normal! ggVGd'
command! -bar   Clear   silent! exe 'normal! ggVGd'

command! -bar W         write !sudo tee % >/dev/null
command! -bar Sudo      write !sudo tee % >/dev/null

"command! -range -nargs=1 -complete=file             Replace     <line1>-pu_|<line1>,<line2>d|r <args>|<line1>d
command! -bar -range DeleteTrailingWS noautocmd silent! exe '<line1>,<line2>s/\s\+$//g'


command! -bar        UpdateTerminalSize silent resize +1 | silent resize -1

" Printing & debug
" com! -nargs=* -bar Pq call pp#print(expand(<q-args>))
" com! -nargs=* -bar Pf call pp#print(<f-args>)
" com! -nargs=* -bar Pa call pp#print(<args>)
command! -nargs=1 -bar -range Mapa Pp maparg(<q-args>, '',  0, 1)
command! -nargs=1 -bar -range Mapc Pp maparg(<q-args>, 'c', 0, 1)
command! -nargs=1 -bar -range Mapv Pp maparg(<q-args>, 'v', 0, 1)
command! -nargs=1 -bar -range Mapn Pp maparg(<q-args>, 'n', 0, 1)



" External commands
command!                                       Top     tab terminal htop
command! -count=0 -nargs=+ -complete=shellcmd  Man     call man#get_page(<count>, <f-args>)



" Highlight
command! -bar -nargs=* -range                         HlClear     match None
command! -bar -nargs=* -range   -complete=highlight   HlLine      match <args> /\v%<line1>l\_.*%<line2>l/
command! -bar -nargs=* -range=0 -complete=highlight   HlChar      match <args> /\v%#./



" Windows etc
command! -bar -nargs=0 WindowYank       :let _yw=[bufnr('%'), winsaveview()]
command! -bar -nargs=0 WindowPaste      if exists('g:_yw') | exe _yw[0] . 'buffer' | call winrestview(_yw[1]) | end
command! -bar -nargs=0 WindowCopyView   WindowYank | GoNextListedWindow | WindowPaste



" Tabs
command! -bar Tabview    tab sview
command! -bar TabviewRO  tab sview +setlocal\ nomodifiable



" Others

command! -bar TraceurCompile !traceur --modules commonjs --out %<.js %

command! -complete=help -nargs=* ZeavimSearch call zeavim#SearchFor(' ' . <q-args> )

command! CppHL exec "Success 'cpp-enhanced'"

