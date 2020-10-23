" Usage: copy URL to clipboad & `:source scripts/install.vim`


let s:start_pattern = "^Plug"


let s:patt = '\v([^/]+)/([^/]+)$'
let s:q = getreg('+')
let s:m = matchlist(s:q, s:patt)

if empty(s:m)
    let s:q = input(':Plug ')
end

let s:m = matchlist(s:q, s:patt)

if empty(s:m)
    echo ''
    echohl WarningMsg
    echo 'Empty match for: ' s:q
    echohl None
    finish
end

let cmd_p = "Plug '" . s:m[0] . "'"
let cmd_i = "PlugInstall " . s:m[2] . ""
try
    execute "edit +/" s:start_pattern  " " $MYVIMRC

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
