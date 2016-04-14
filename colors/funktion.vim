" File: funktion.vim
" Author: romgrk
" Description: light colorscheme
" Last Modified: March 04, 2015

set background=light

" General colors {{{

hi Normal guifg=#0a0a0a guibg=#fbfbfb

hi CursorLine guifg=NONE guibg=#e8e8e8
hi CursorColumn guifg=NONE guibg=#e8e8e8 

hi Cursor guifg=NONE guibg=#79beff gui=none 
hi Visual guifg=NONE guibg=#79beff  

hi PmenuSel guifg=#e8e8e8 guibg=#599eff gui=bold 
hi Pmenu guifg=#a0a8b0  guibg=#384048  

hi WildMenu guifg=#e8e8e8 guibg=#599eff gui=bold 

hi LineNr guifg=#605958 guibg=#c8c8c8
hi CursorLineNr guifg=#e8e8e8 guibg=#989898 gui=bold

hi IndentGuidesOdd guifg=NONE guibg=#fbfbfb
hi IndentGuidesEven guifg=NONE guibg=#fbfbfb

hi StatusLine guifg=#a0a8b0  guibg=#989898  
hi StatusLineNC guifg=#000000 guibg=#989898  
hi VertSplit guifg=#989897 guibg=#989898 

hi AirlineB guifg=#E5E5E5 guibg=#787878
hi AirlineC guifg=#080808 guibg=#989898  
hi AirlineNormal guifg=#F9F9FF guibg=#345FD8
hi AirlineInsert guifg=#DEFEBE guibg=#439019
hi AirlineReplace guifg=#DEFBBE guibg=#439019
hi AirlineVisual guifg=#FEFEDE guibg=#B03019
hi AirlineInactive guifg=#484848 guibg=#b8b8b8

hi Folded guifg=#605958 guibg=#c8c8c8 gui=italic  
hi FoldColumn guifg=#535D66 guibg=#c8c8c8  

hi SignColumn guifg=NONE guibg=#c8c8c8 
hi ColorColumn guifg=NONE guibg=#c8c8c8  

hi Search guifg=NONE guibg=#f9f945 gui=none
hi MatchParen guifg=#ff0000 gui=bold 

hi TabLine guifg=#000000 guibg=#c8c8c8 gui=italic  
hi TabLineFill guifg=#c8c8c8 guibg=NONE  
hi TabLineSel guifg=#000000 guibg=#f0f0f0 gui=italic,bold 

" Types colors {{{
hi Comment          guifg=#509028 

hi Constant         guifg=#bf3a2c  gui=bold
hi Number           guifg=#ff0000  gui=none  
hi String           guifg=#497eef
hi StringDelimiter  guifg=#497eef

hi Special          guifg=#04388b guibg=#ebebff gui=bold 
hi SpecialChar      guifg=#04388b gui=bold 
hi Delimiter        guifg=#0000FF gui=bold

hi Identifier guifg=#7b387b guibg=NONE  
hi Function guifg=#04388b guibg=NONE  

hi Type guifg=#df6f00 guibg=NONE gui=NONE
hi Structure guifg=#599eff guibg=NONE  

hi Statement guifg=#7f0055 gui=bold
"hi Keyword guifg=#0000FF gui=NONE
hi Operator guifg=#04388b guibg=NONE  

hi PreProc guifg=#ab78ab guibg=NONE gui=bold 


hi Title guifg=#70b950  gui=bold 

hi Pink guifg=#f92672 guibg=NONE

hi NonText guifg=#606060 guibg=#151515  
hi SpecialKey guifg=#444444 guibg=#1c1c1c  
hi Directory guifg=#9a9045 guibg=NONE  

hi Todo guifg=#080808 guibg=NONE gui=bold 
hi ErrorMsg guifg=NONE guibg=#902020  
hi! link Error ErrorMsg
hi! link MoreMsg Special
hi Question guifg=#65C254 guibg=NONE  

hi DiffAdd guifg=#D2EBBE guibg=#437019  
hi DiffDelete guifg=#40000A guibg=#700009  
hi DiffChange guifg=NONE guibg=#2B5B77  
hi DiffText guifg=#8fbfdc guibg=#000000 gui=reverse
hi! link diffRemoved Constant
hi! link diffAdded String

" PHP " {{{
hi StorageClass guifg=#c59f6f
hi! link phpFunctions Function
hi! link phpSuperglobal Identifier
hi! link phpQuoteSingle StringDelimiter
hi! link phpQuoteDouble StringDelimiter
hi! link phpBoolean Constant
hi! link phpNull Constant
hi! link phpArrayPair Operator
hi! link phpOperator Normal
hi! link phpRelation Normal
hi! link phpVarSelector Identifier

" Python {{{
hi! link pythonOperator Statement

" RUBY {{{
hi rubyClass guifg=#447799
hi rubyIdentifier guifg=#c6b6fe
hi rubyInstanceVariable guifg=#c6b6fe
hi rubySymbol guifg=#7697d6
hi rubyControl guifg=#7597c6
hi rubyRegexpDelimiter guifg=#540063
hi rubyRegexp guifg=#dd0093
hi rubyRegexpSpecial guifg=#a40073
hi rubyPredefinedIdentifier guifg=#de5577

hi! link rubySharpBang Comment
hi! link rubyConstant Type
hi! link rubyFunction Function
hi! link rubyGlobalVariable rubyInstanceVariable
hi! link rubyModule rubyClass
hi! link rubyString String
hi! link rubyStringDelimiter StringDelimiter
hi! link rubyInterpolationDelimiter Identifier


" Erlang {{{
hi! link erlangAtom rubySymbol
hi! link erlangBIF rubyPredefinedIdentifier
hi! link erlangFunction rubyPredefinedIdentifier
hi! link erlangDirective Statement
hi! link erlangNode Identifier

" JavaScript {{{
hi! link javaScriptValue Constant
hi! link javaScriptRegexpString rubyRegexp

" CoffeeScript {{{
hi! link coffeeRegExp javaScriptRegexpString

" Lua {{{
hi! link luaOperator Conditional

" C {{{
hi! link cFormat Identifier
hi! link cOperator Constant

" Objective-C/Cocoa {{{
hi! link objcClass Type
hi! link cocoaClass objcClass
hi! link objcSubclass objcClass
hi! link objcSuperclass objcClass
hi! link objcDirective rubyClass
hi! link cocoaFunction Function
hi! link objcMethodName Identifier
hi! link objcMethodArg Normal
hi! link objcMessageName Identifier

" Vimscript {{{
hi! link vimOper Normal

" Debugger.vim {{{
hi DbgCurrent guifg=#DEEBFE
hi DbgBreakPt guifg=NONE guibg=#4F0037

" Plugins, etc. {{{
hi! link TagListFileName Directory
hi PreciseJumpTarget guifg=#B9ED67 guibg=#405026

