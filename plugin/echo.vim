" !::exe [so %]

command! -bar -nargs=* Log      call Info(<args>)
command! -bar -nargs=* Debug    call Debug(<args>)
command! -bar -nargs=* Warn     call Warn(<args>)
command! -bar -nargs=* Error    call Error(<args>)
command! -bar -nargs=* Success  call Success(<args>)
command! -bar -nargs=* Info     call Info(<args>)

fu! Echon(...) " {{{
    echon join(a:000)
endfu " }}}
fu! EchoHL(hlgroup, ...) " {{{
    exe ':echohl ' . a:hlgroup
    echo join(a:000)
    exe ':echohl None'
endfu " }}}
fu! EchonHL(hlgroup, ...) " {{{
    exe ':echohl ' . a:hlgroup
    echon join(a:000)
endfu " }}}

fu! Log(hl, ...)
    silent! echom string(a:000)
    let args = a:000
    if (a:0 == 1 && _#isList(a:1))
        let args = a:1
    end

    for idx in range(len(args))
        if _#isString(args[idx])
            call EchonHL(a:hl, args[idx])
        else
            call pp#dump( args[idx] )
        end
        echon ' '
    endfor
    echohl None
endfu
fu! Debug (...)
    call Log('Debug', a:000)
endfu
fu! Warn (...)
    call Log('WarningMsg', a:000)
endfu
fu! Warning (...)
    call Log('WarningMsg', a:000)
endfu
fu! Err (...)
    call Log('ErrorMsg', a:000)
endfu
fu! Error (...)
    call Log('ErrorMsg', a:000)
endfu
fu! Info (...)
    call Log('TextInfo', a:000)
endfu
fu! Success (...)
    call call('Log', ['TextSuccess'] + a:000)
endfu
