" File: get.vim
" Author: romgrk
" Date: 02 Feb 2016
" Description: here
" !::exe [so %]


" @args: (region)   OR   (reg, ion)
function! get#text(...)
    let [start, end] = (a:0 == 1) ? [ [a:1[0], a:1[1]], [a:1[2], a:1[3]]]
                    \: (a:0 == 2) ? [ a:1,        a:2]
                                 \: [[a:1, a:2], [a:3, a:4]]
    if ((start[0] > end[0]) || (start[0] == end[0] && (start[1] > end[1])))
        let [start, end] = [end, start]
    end
    let lines = getline(start[0], end[0])
    let lines[0]  = lines[0][start[1] - 1 :]
    let lines[-1] = lines[-1][: end[1] - 1]
    return join(lines, "\n")
endfunc


let s:session_file = path#Join([user#CacheDir(), 'session.json'])

fu! get#Save (...)
    "let file = (a:0 ? a:1 : )
    "let cacheDir  = fnamemodify(file, ':h')
    "if !isdirectory(cacheDir)
        "call Info('Created dir: ', cacheDir, mkdir(cacheDir, "p"))
    "end
    let file = get(g:session, 'session_file', s:session_file)
    let json = json#Format(g:session)
    let content = split(json, "\n")
    call writefile(content, file)
    call Success('file written: ', file)
endfu

fu! get#Load (file)
    unlet! g:session
    let g:session = {}
    let file = fnamemodify(a:file, ":p")
    let g:session.session_file = file
    try
        let lines = readfile(file)
        call extend(g:session, json#Parse(join(lines, "\n")))
    catch /.*/
        call Error('Error loading session-file: ' . v:exception)
    endtry
    return g:session
endfu

