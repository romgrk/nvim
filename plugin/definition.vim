" !::exe [so %]

command! -nargs=* -complete=expression Goto call <SID>goto(<q-args>)
function! s:goto (str)
    try
        let out = command#GetOutput('verbose ' . a:str)
    catch /.*/
        call Warn(v:exception)
        return
    endtry
    let lastset = matchstr(out, 'Last set from \zs\f\+')

    exe 'Edit ' . lastset

    let what = map(split(_#Trim(a:str), " "), '".*".v:val')
    let pattern = '\v' . join(what, '&')
    call search(pattern)
    echo pattern
endfu
