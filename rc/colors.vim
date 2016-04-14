" File: colors.vim
" Author: romgrk
" Description: colors' definitions
" Date: 14 Sep 2015
" !::exe [so % ]
" Statusline Modes {{{

let s:mode = [
            \ 'normal', 'inactive', 'insert',
            \ 'replace', 'visual', 'select',
            \ 'tabline', 'terminal' ]
for mx in s:mode
    let s:{mx} = {}
endfor

for key in keys(g:colors)
    let s:{key} = g:colors[key]
endfor

function! s:mod1 (color)
    return [s:base2, a:color]
endfunc
function! s:mod2 (color)
    return [s:base2, a:color]
endfunc

let s:normal.left     = [ s:mod1(s:blue), s:part1, s:part2 ]
let s:normal.right    = [ s:mod2(s:blue), s:part1b ]
let s:normal.middle   = [ s:part3 ]

let s:normal.error    = [ [ s:darkred, s:base02, 'bold' ] ]
let s:normal.warning  = [ [ s:darkorange, s:base2 ] ]
let s:normal.modified = [ [ s:darkorange, s:base2 ] ]

let s:insert.left     = [ [ s:darkred, s:brightorange ],  s:part1, s:part2 ]
let s:insert.right    = [ [ s:darkred, s:brightorange ], s:part1b ]
"let s:insert.middle   = [ [ s:black, s:brightorange ] ]

let s:replace.left     = [ [ s:darkred, s:brightorange ], [ color#Lighten(s:mediumorange, '0.8'), color#Darken(s:orange, '0.3') ] ]
let s:replace.right    = [ [ s:darkred, s:brightorange ], [ s:darkred, s:mediumorange ] ]
let s:replace.middle   = [ [ color#Darken(s:orange, '0.0'), color#Darken(s:orange, '0.6') ] ]
"let s:replace.left    = [ s:mod1(s:green), s:part1, s:part2 ]
"let s:replace.right   = [ s:mod2(s:green), s:part1b ]
"let s:replace.middle = [ s:part3 ]

let s:visual.left     = [ s:mod1(s:red), s:mod1(s:mediumred) ]
let s:visual.right    = [ s:mod2(s:red), s:mod1(s:mediumred) ]
let s:visual.middle   = [ [ s:red, color#Darken(s:mediumred, '0.3') ] ]

let s:select.left     = [ s:mod1(s:lightteal), s:mod1(s:teal) ]
let s:select.right    = [ s:mod2(s:lightteal), s:mod1(s:teal) ]
let s:select.middle   = [ [ s:lightteal, s:teal ] ]

let s:p_purple = [s:darkestpurple, s:white ]
let s:terminal.left   = [ s:p_purple, s:mod1(s:mediumpurple) ]
let s:terminal.right  = [ [s:darkestpurple, s:white ], s:mod2(s:mediumpurple) ]
let s:terminal.middle = [ s:mod2(s:darkestpurple) ]
let s:terminal.icon   = [ s:term ]

" Inactive
let s:inactive.left   = [ hl_high, hl_med0, hl_low ]
let s:inactive.right  = [ s:part00b, s:part01b ]
let s:inactive.middle = [ s:part02 ]

" }}}
" Tabline {{{
let s:tabline.left   = [ [s:base2,  s:base00] ]
let s:tabline.right  = [ [ s:brightblue, s:base01 ], [ s:base2, s:base01 ] ]
let s:tabline.middle = [ [s:base2,  s:base00] ]

"let s:tabline.tabsel   = [ [ s:white, s:brightblue,   'bold' ] ]
"let s:tabline.tabsel   = [ [ s:base2, s:base02,       'none' ] ]
"let s:tabline.tabtitle = [ [ s:white, s:brightorange, 'bold' ] ]

if exists('*lightline#colorscheme') && exists('g:lightline')     "                                    {{{
    let lightline.colorscheme = 'powerline'
    call lightline#init()
    call lightline#colorscheme()

    let s:dp = g:lightline#colorscheme#powerline#palette
    "let s:dp.inactive.left   = [ hl_high, hl_med0, hi.low(s:darkorange)]
    "let s:dp.inactive.right  = [ s:dp.normal.right[1], s:part01b ]
    "let s:dp.inactive.middle = [ s:part02 ]
    let s:normal.left[0]  = s:dp.normal.left[0]
    "let s:normal.left[1]  = s:dp.normal.right[0]
    let s:normal.right[0] = s:dp.normal.right[0]
    let s:insert = s:dp.insert
    call lightline#colorscheme#fill(s:p)

    "for k in keys(s:tabline)
        "let s:dp.tabline[k] = s:tabline[k]
    "endfor
    let s:dp.tabline = deepcopy(s:tabline)
    let s:dp.replace = deepcopy(s:replace)
    call lightline#highlight()
end
