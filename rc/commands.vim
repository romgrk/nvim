" !::exe [so %]


com! -bar   So      so %
com! -bar   SO      w|so %
com! -bar   DD      silent! exe 'normal! ggVGd'
com! -bar   Clear   silent! exe 'normal! ggVGd'

com! -bar -bang W       write !sudo tee % >/dev/null
com! -bar -bang Sudo    write !sudo tee % >/dev/null

"command! -range -nargs=1 -complete=file             Replace     <line1>-pu_|<line1>,<line2>d|r <args>|<line1>d
command! -bar -range DeleteTrailingWS k' |silent! exe '<line1>,<line2>s/\s\+$//g'|''


" Printing & debug

com! -nargs=* -bar Pq call pp#print(expand(<q-args>))
com! -nargs=* Pf call pp#print(<f-args>)
com! -nargs=* Pa call pp#print(<args>)

command! -nargs=1 -bar -range Map Pp maparg(<q-args>, '', 0, 1)
command! -nargs=1 -bar -range Mapc Pp maparg(<q-args>, 'c', 0, 1)
command! -nargs=1 -bar -range Mapv Pp maparg(<q-args>, 'v', 0, 1)
command! -nargs=1 -bar -range Mapn Pp maparg(<q-args>, 'n', 0, 1)

" Job control
command! -nargs=1 Start if (!has_key(job, <q-args>) || get(job[<q-args>], 'id', 0) == 0)
                     \|    call Info('Starting: <q-args>')
                     \|    let job[<q-args>] = Job.new(cmd[<q-args>])
                     \|    call Success(job[<q-args>])
                     \| end
command! -nargs=1  Stop if (has_key(job, <q-args>) && get(job[<q-args>], 'id', 0) != 0)
                     \|    call Warn('Stopping: <q-args>')
                     \|    call pp#print(job[<q-args>].stop())
                     \| end

" External commands
command!                                       Top     vertical terminal htop
command! -count=0 -nargs=+ -complete=shellcmd  Man     call man#get_page(<count>, <f-args>)


command! -bar TraceurCompile !traceur --modules commonjs --out %<.js %


" Highlight
command! -bar -nargs=* -range                         HlClear     match None
command! -bar -nargs=* -range   -complete=highlight   HlLine      match <args> /\v%<line1>l\_.*%<line2>l/
command! -bar -nargs=* -range=0 -complete=highlight   HlChar      match <args> /\v%#./



" Windows etc
command! -bar  WindowYank  let _yw=[bufnr('%'), winsaveview()]
command! -bar  WindowPaste exe _yw[0] . 'buffer' | call winrestview(_yw[1])



" Tabs
command! -bar Tabview    tab sview
command! -bar TabviewRO  tab sview +setlocal\ nomodifiable



" Others

command! -complete=help -nargs=* ZHelp call zeavim#SearchForCurrent(' ' . <f-args>)
