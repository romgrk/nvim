" File: colors.vim
" Author: romgrk
" Description: colors' definitions
" Date: 14 Sep 2015
" !::exe [so % ]

augroup colors.vim
    au!
    autocmd ColorScheme * exec 'source ' . expand('<sfile>')
augroup end


" Colors {{{

unlet! colors
let colors = {}

let colors.base03 = '#151515'
let colors.base02 = '#30302a'
let colors.base01 = '#4e4e48'
let colors.base00 = '#666660'

let colors.base0 = '#808078'
let colors.base1 = '#949489'
let colors.base2 = '#a8a89e'
let colors.base3 = '#e8e8d7'
let colors.baseF = '#f8fbf1'

let colors._black     = '#000000'
let colors.black      = '#070707'
let colors.darkgray   = '#1f1f1f'
let colors.gray       = '#2c2c2c'
let colors.lightgray  = '#404040'
let colors.brightgray = '#515151'
let colors.white      = '#f4fbfe'

let colors.beige           = '#bab075'
let colors.darkyellow      = '#c59000'
let colors.yellow          = '#eab700'
let colors.brightyellow    = '#ffe914'
let colors.darkorange      = '#c7800a'
let colors.orange          = '#f5871f'
let colors.mediumorange    = '#ff8700'
let colors.brightorange    = '#ffb700'
let colors.brightestorange = '#ffaf00'
let colors.darkestred      = '#5f0000'
let colors.darkred         = '#870000'
let colors.mediumred       = '#af0000'
let colors.brightred       = '#df0000'
let colors.brightestred    = '#ff0000'
let colors.red             = '#dc322f'
let colors.lightred        = '#ff9a9c'
let colors.pink            = '#f92672'
let colors.darkestpurple   = '#5f00af'
let colors.mediumpurple    = '#875fdf'
let colors.magenta         = '#8959a8'
let colors.darkestblue     = '#121448'
let colors.darkblue        = '#052350'
let colors.blue            = '#345fa8'
let colors.blue2           = '#10479f'
let colors.brightblue      = '#599eff'
let colors.lightblue       = '#94afff'
let colors.darkteal        = '#005f5f'
let colors.tealblue        = '#005f87'
let colors.teal            = '#0087af'
let colors.lightteal       = '#80d3f2'
let colors.brightteal      = '#87dfff'
let colors.darkestgreen    = '#005f00'
let colors.darkgreen       = '#008700'
let colors.green           = '#209f20'
let colors.mediumgreen     = '#5faf00'
let colors.brightgreen     = '#afdf00'

for k in keys(colors)
    let c = colors[k]
    if _#isString(c)
        call hi#('fg_' . k  ,  c   ,  ''  ,  '')
        call hi#('bg_' . k  ,  ''  ,  c   ,  '')
        call hi#('b_'  . k  ,  c   ,  ''  ,  'bold')
    end
    unlet c
endfor

let text_colors = {}
let text_colors.Info    = "#599eff"
let text_colors.Success = "#42E968"
let text_colors.Warning = "#efa025"
let text_colors.Debug   = "#F9FA00"
let text_colors.Error   = "#ef2021"
let text_colors.Special = "#9c5fff"
for key in keys(text_colors)
    call hi#('Text' . key, text_colors[key], '', '')
    call hi#('Bold' . key, text_colors[key], '', 'bold')
endfor

" hi! link Msg        TextSuccess
" hi! link MoreMsg    TextInfo
" hi! link WarningMsg TextWarning
" hi! link ErrorMsg   TextError
" hi! link ModeMsg    BoldSpecial
