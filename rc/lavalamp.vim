" !::exe [so %]

"#F7AAEF  #FFEBEE
"#A04FA5  #FFCDD2
"#A04FA5  #EF9A9A
"#EB95ED  #E57373
"#B50DAE  #EF5350
"#a755df  #F44336
"         #E53935
"         #C62828
"         #B71C1C
"

fu! LavaLampColors ()
    let keys = keys(g:)
    for k in keys
        if (k =~ '\v^(red|green|yellow|orange|brown|purple|blue)_')
            exe 'hi! ' . k . ' guifg=' get(g:, k, '')
        end
    endfor
    source $rc/lavalamp.vim
endfu
call LavaLampColors()

call hi#('red_bdark',   hi#fg('red_xdark'),   '', 'bold')
call hi#('red_bmed',    hi#fg('red_med'),     '', 'bold')
call hi#('red_blight',  hi#fg('red_light'),   '', 'bold')
call hi#('green_bdark', hi#fg('green_xdark'), '', 'bold')

hi! Number guifg=#FF6F00

hi! link jsonNumber  WarningMsg
hi! link jsonKeyword String4
hi! link jsonBoolean red_med

hi! link typescriptIdentifierName red_light
hi! link typescriptIdentifier     red_bdark
hi! link typescriptStatement      red_bdark
hi! link typescriptVariable       red_bdark
hi! link typescriptFuncKeyword    red_bdark
hi! link typescriptOperator       red_blight
hi! link typescriptOpSymbol       red_xdark

hi! link typeScriptReserved       red_bdark

hi! link typescriptEndColons      Comment
hi! link typescriptNull           yellow_light

hi! link javascriptIdentifierName green_light
hi! link javascriptReturn         green_bdark
hi! link javascriptVariable       green_bdark
hi! link javascriptFuncKeyword    green_bdark
hi! link javascriptOpSymbol       green_xdark
hi! link javaScriptReserved       green_bdark
hi!      javascriptString guifg=#A5FFA4

" HTMLSassCssMd                                                              {{{
"
hi! htmlString       guifg=#CACBFF
"hi! htmlTagName      guifg=#2c23ff gui=bold
hi! link htmlTagName htmlSpecialTagName
hi! link htmlTagN    htmlTagName

hi! link mkdNonListItemBlock Delimiter

hi! link                    cssBraces Delimiter
hi! cssDefinition           guifg=#EB95ED
hi! cssGeneratedContentProp guifg=#EB95ED
hi! cssUnitDecorators       guifg=#A04FA5

hi! sassMixinName  guifg=#FFCDD2
hi! sassMixin      guifg=#EF5350 gui=bold
hi! sassMixing     guifg=#EF5350 gui=bold
hi! sassProperty   guifg=#EF5350
hi! sassDefinition guifg=#D32F2F
hi! sassAmpersand  guifg=#D32F2F
hi! sassVariable   guifg=#f04020 gui=bold

hi! link EndOfBuffer Normal

