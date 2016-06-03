" File: colors.vim
" Author: romgrk
" Description: colors' definitions
" Date: 14 Sep 2015
" !::exe [so % ]

augroup Colors
    au!
    " this one is which you're most likely to use?
    autocmd ColorScheme * exec 'source ' . expand('<sfile>')
augroup end

" Colors {{{

let s:base03 = '#151515'
let s:base02 = '#30302a'
let s:base01 = '#4e4e48'
let s:base00 = '#666660'

let s:base0 = '#808078'
let s:base1 = '#949489'
let s:base2 = '#a8a89e'
let s:base3 = '#e8e8d7'
let s:baseF = '#f8fbf1'

let s:_black     = '#000000'
let s:black      = '#070707'
let s:darkgray   = '#1f1f1f'
let s:gray       = '#2c2c2c'
let s:lightgray  = '#404040'
let s:brightgray = '#515151'
let s:white      = '#f4fbfe'

let s:beige           = '#bab075'
let s:darkyellow      = '#c59000'
let s:yellow          = '#eab700'
let s:brightyellow    = '#ffe914'
let s:darkorange      = '#c7800a'
let s:orange          = '#f5871f'
let s:mediumorange    = '#ff8700'
let s:brightorange    = '#ffb700'
let s:brightestorange = '#ffaf00'
let s:darkestred      = '#5f0000'
let s:darkred         = '#870000'
let s:mediumred       = '#af0000'
let s:brightred       = '#df0000'
let s:brightestred    = '#ff0000'
let s:red             = '#dc322f'
let s:lightred        = '#ff9a9c'
let s:pink            = '#f92672'
let s:darkestpurple   = '#5f00af'
let s:mediumpurple    = '#875fdf'
let s:magenta         = '#8959a8'
let s:darkestblue     = '#121448'
let s:darkblue        = '#052350'
let s:blue            = '#345fa8'
let s:blue2           = '#10479f'
let s:brightblue      = '#599eff'
let s:lightblue       = '#94afff'
let s:darkteal        = '#005f5f'
let s:tealblue        = '#005f87'
let s:teal            = '#0087af'
let s:lightteal       = '#80d3f2'
let s:brightteal      = '#87dfff'
let s:darkestgreen    = '#005f00'
let s:darkgreen       = '#008700'
let s:green           = '#209f20'
let s:mediumgreen     = '#5faf00'
let s:brightgreen     = '#afdf00'

unlet! colors
let colors = {}
"call pp#print(s:)
"finish
for k in keys(s:)
    let g:colors[k] = s:{k}

    let c = s:{k}
    if _#isString(c)
        call hi#('fg_' . k  ,  c   ,  ''  ,  '')
        call hi#('bg_' . k  ,  ''  ,  c   ,  '')
        call hi#('b_'  . k  ,  c   ,  ''  ,  'bold')
    end
    unlet c
endfor

call hi#("hl_1", "#202020", "#ffb700", "")
call hi#("hl_2", "#202020", "#65C254", "")
call hi#("hl_3", "#202020", "#9c5fff", "")

let log = {}
let log.Info    = "#599eff"
let log.Success = "#42E968"
let log.Warning = "#efa025"
let log.Debug   = "#F9FA00"
let log.Error   = "#ef2021"
let log.Special = "#9c5fff"
for key in keys(log)
    call hi#('Text' . key, log[key], '', '')
    call hi#('Bold' . key, log[key], '', 'bold')
    call hi#link(key,      'Text' . key)
endfor

hi! link Msg        TextSuccess
hi! link MoreMsg    TextInfo
hi! link WarningMsg TextWarning
hi! link ErrorMsg   TextError
hi! link ModeMsg    BoldSpecial

