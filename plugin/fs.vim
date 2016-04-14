" !::exe [so %]

com! -bar -bang -nargs=1 Delete call <SID>deleteFile<bang>(<q-args>)
com! -bar -bang -nargs=* Rename call <SID>renameFile<bang>(<q-args>)

fu! s:deleteFile (...)
    if a:0 > 0 || a:bang
        let file = expand('%:p')
        BufferClose
        call EchoHL('Warning', delete(file))
    end
endfu

fu! s:renameFile (...)
    let from = expand('%:p')
    let head = expand('%:h')
    let dir  = head . '/'
    let tail = expand('%:t')
    let base = expand('%:t:r')
    let ext = expand('%:e')
    let parts = [
    \['TextInfo',     head . '/',],
    \['TextWarning',  tail,],
    \]

    redraw
    for part in parts
        call EchonHL(part[0], part[1])
    endfor

    echohl Question
    let newname = input('rename to? ')
    echohl Normal

    if (strlen(newname) == 0)
        call EchoHL('TextWarning', 'cancelled.')
        return
    end

    let to = resolve(dir . '/' . newname)

    if filereadable(to) && !get(a:, 'bang', 0)
        call EchoHL('TextWarning', 'file exists. overwrite?')

        let c = GetChar()
        if c == "\<Esc>"
            call EchoHL('TextWarning', 'cancelled')
            return
        end
    end

    let res = rename(from, to)
    if (res)
        call EchoHL('TextSuccess', to, ' written')
    else
        echo ''
        call EchoHL('TextError', 'Error: ', res, ' writing ', to)
    end
    sleep 1500ms
endfu

