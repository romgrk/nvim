let Nodejs = {}

function! Nodejs.eval (...)
    let cmd = 'node -e '

    for argv in a:000
        cmd .= shellescape(argv) . ' '
    endfor

    return system(cmd)
endfunc

