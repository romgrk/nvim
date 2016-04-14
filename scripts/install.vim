
let s:patt = '\v([^/]+)/([^/]+)$'
"let q = system('xclip -selection clipboard -o')
let q = getreg('+')
let m = matchlist(q, s:patt)

if empty(m)
    let q = _#Input(':Plug ')
end

let m = matchlist(q, s:patt)

if empty(m)
    echo ''
    call Warn('Empty match for: ', q)
    finish
end

let cmd_p = "Plug '" . m[0] . "'"
let cmd_i = "PlugInstall " . m[2] . ""
try
    edit +/@plugins $MYVIMRC
    call append('.', [cmd_p])

    execute cmd_p
    execute cmd_i
catch /.*/
    echohl Error
    echom v:exception . ':' . cmd_p . ':' . cmd_i
    echohl None
    edit $MYVIMRC
    undo
endtry
