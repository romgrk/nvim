
hi clear
set background=dark

let colors_name = "jellybeans"
" Jellybeans setup & funcs {{{
" Color approximation functions by Henry So, Jr. and David Liang
" Added to jellybeans.vim by Daniel Herbert

if exists("syntax_on")
  syntax reset
endif

if has("gui_running") || &t_Co == 88 || &t_Co == 256
  let s:low_color = 0
else
  "let s:low_color = 1
  let s:low_color = 0
endif

" returns an approximate grey index for the given grey level
fun! s:grey_number(x) " {{{
  if &t_Co == 88
    if a:x < 23
      return 0
    elseif a:x < 69
      return 1
    elseif a:x < 103
      return 2
    elseif a:x < 127
      return 3
    elseif a:x < 150
      return 4
    elseif a:x < 173
      return 5
    elseif a:x < 196
      return 6
    elseif a:x < 219
      return 7
    elseif a:x < 243
      return 8
    else
      return 9
    endif
  else
    if a:x < 14
      return 0
    else
      let l:n = (a:x - 8) / 10
      let l:m = (a:x - 8) % 10
      if l:m < 5
        return l:n
      else
        return l:n + 1
      endif
    endif
  endif
endfun " }}}

" returns the actual grey level represented by the grey index
fun! s:grey_level(n) " {{{
  if &t_Co == 88
    if a:n == 0
      return 0
    elseif a:n == 1
      return 46
    elseif a:n == 2
      return 92
    elseif a:n == 3
      return 115
    elseif a:n == 4
      return 139
    elseif a:n == 5
      return 162
    elseif a:n == 6
      return 185
    elseif a:n == 7
      return 208
    elseif a:n == 8
      return 231
    else
      return 255
    endif
  else
    if a:n == 0
      return 0
    else
      return 8 + (a:n * 10)
    endif
  endif
endfun " }}}

" returns the palette index for the given grey index
fun! s:grey_color(n) " {{{
  if &t_Co == 88
    if a:n == 0
      return 16
    elseif a:n == 9
      return 79
    else
      return 79 + a:n
    endif
  else
    if a:n == 0
      return 16
    elseif a:n == 25
      return 231
    else
      return 231 + a:n
    endif
  endif
endfun " }}}

" returns an approximate color index for the given color level
fun! s:rgb_number(x) " {{{
  if &t_Co == 88
    if a:x < 69
      return 0
    elseif a:x < 172
      return 1
    elseif a:x < 230
      return 2
    else
      return 3
    endif
  else
    if a:x < 75
      return 0
    else
      let l:n = (a:x - 55) / 40
      let l:m = (a:x - 55) % 40
      if l:m < 20
        return l:n
      else
        return l:n + 1
      endif
    endif
  endif
endfun " }}}

" returns the actual color level for the given color index
fun! s:rgb_level(n) " {{{
  if &t_Co == 88
    if a:n == 0
      return 0
    elseif a:n == 1
      return 139
    elseif a:n == 2
      return 205
    else
      return 255
    endif
  else
    if a:n == 0
      return 0
    else
      return 55 + (a:n * 40)
    endif
  endif
endfun " }}}

" returns the palette index for the given R/G/B color indices
fun! s:rgb_color(x, y, z) " {{{
  if &t_Co == 88
    return 16 + (a:x * 16) + (a:y * 4) + a:z
  else
    return 16 + (a:x * 36) + (a:y * 6) + a:z
  endif
endfun " }}}

" returns the palette index to approximate the given R/G/B color levels
fun! s:color(r, g, b) " {{{
  " get the closest grey
  let l:gx = s:grey_number(a:r)
  let l:gy = s:grey_number(a:g)
  let l:gz = s:grey_number(a:b)

  " get the closest color
  let l:x = s:rgb_number(a:r)
  let l:y = s:rgb_number(a:g)
  let l:z = s:rgb_number(a:b)

  if l:gx == l:gy && l:gy == l:gz
    " there are two possibilities
    let l:dgr = s:grey_level(l:gx) - a:r
    let l:dgg = s:grey_level(l:gy) - a:g
    let l:dgb = s:grey_level(l:gz) - a:b
    let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
    let l:dr = s:rgb_level(l:gx) - a:r
    let l:dg = s:rgb_level(l:gy) - a:g
    let l:db = s:rgb_level(l:gz) - a:b
    let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
    if l:dgrey < l:drgb
      " use the grey
      return s:grey_color(l:gx)
    else
      " use the color
      return s:rgb_color(l:x, l:y, l:z)
    endif
  else
    " only one possibility
    return s:rgb_color(l:x, l:y, l:z)
  endif
endfun " }}}

" returns the palette index to approximate the 'rrggbb' hex string
fun! s:rgb(rgb) " {{{
  let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
  let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
  let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0
  return s:color(l:r, l:g, l:b)
endfun " }}}

let g:hlDump = ''
function! s:addData(s)
    let g:hlDump = g:hlDump . "" . a:s
    exec a:s
endfunction

" sets the highlighting for the given group
fu! s:X(group, ...) " {{{
  " fg, bg, attr, lcfg, lcbg
  let hl = type(a:1)==type([]) ? a:1 : a:000

  let group = a:group
  let fg   = get(hl, 0, '')
  let bg   = get(hl, 1, '')
  let attr = get(hl, 2, '')
  let lcfg = get(hl, 3, '')
  let lcbg = get(hl, 4, '')

  if !empty(fg) && fg =~ '#'
      let fg = strpart(fg, 1) | end
  if !empty(bg) && bg =~ '#'
      let bg = strpart(bg, 1) | end

  if s:low_color
    let l:fge = empty(lcfg)
    let l:bge = empty(lcbg)

    if !l:fge && !l:bge
      call s:addData( "hi ".group." ctermfg=".lcfg." ctermbg=".lcbg)
    elseif !l:fge && l:bge
      call s:addData( "hi ".group." ctermfg=".lcfg." ctermbg=NONE")
    elseif l:fge && !l:bge
      call s:addData( "hi ".group." ctermfg=NONE ctermbg=".lcbg)
    endif
  else
    let l:fge = empty(fg)
    let l:bge = empty(bg)

    if !l:fge && !l:bge
      call s:addData( "hi ".group." guifg=#".fg." guibg=#".bg." ctermfg=".s:rgb(fg)." ctermbg=".s:rgb(bg))
    elseif !l:fge && l:bge
      call s:addData( "hi ".group." guifg=#".fg." guibg=NONE ctermfg=".s:rgb(fg)." ctermbg=NONE")
    elseif l:fge && !l:bge
      call s:addData( "hi ".group." guifg=NONE guibg=#".bg." ctermfg=NONE ctermbg=".s:rgb(bg))
    endif
  endif

  if attr == ""
    call s:addData( "hi ".group." gui=none cterm=none")
  else
    let l:noitalic = join(filter(split(attr, ","), "v:val !=? 'italic'"), ",")
    if empty(l:noitalic)
      let l:noitalic = "none"
    endif
    call s:addData( "hi ".group." gui=".attr." cterm=".l:noitalic)
  endif
endfun " }}}

" highlights group with [fg, [bg, attr]]
fu! s:hi (name, ...) " {{{
    let name = a:name
    let group = []
    if type(a:1) == 1 " String
        let group = a:000
    else
        let group = a:1
    end

    let fg = get(group, 0, '')
    let bg = get(group, 1, '')
    let attr = get(group, 2, '')
    "call s:X(name, fg, bg, attr, '', '')
    try
        exe 'hi '.name .' guifg='. fg .' guibg='. bg .
        \ (attr!='' ? ' gui='.attr : '')
    catch /.*/
        echom 'HI ERROR: ' . v:exception
        echom name . string(group)
    endtry
endfunction " end }}}
"}}}

if !exists('g:ui')
    let g:ui = {}
    let g:ui.border   = ['#666660', '#666660']
    let g:ui.wildmenu = ['#f4fbfe', '#345fa8']
    let g:ui.selected = ['#f4fbfe', '#599eff']
    let g:ui.popup    = ['#e8e8d7', '#4e4e48']
    let g:ui.tabline  = ['#a8a89e', '#666660']
    let g:ui.tabsep   = ['#4e4e48', '#4e4e48']
    let g:ui.active   = ['#f4fbfe', '#808078']
end

" General UI colors {{{
if !exists("g:jellybeans_background_color")
    let g:jellybeans_background_color = "#151515"  | endif
if !exists("g:jellybeans_use_lowcolor_black") || g:jellybeans_use_lowcolor_black
    let s:termBlack = "Black" | else
    let s:termBlack = "Grey"  | endif

call s:X("Normal",  "#e8e8d3",  "#151515",  "",  "White",  "")
"set background=dark

call s:X("Cursor",        "",  "#202020",  "reverse",  "",  s:termBlack)
call s:X("CursorLine",    "",  "#202020",  "",         "",  s:termBlack)
call s:X("CursorColumn",  "",  "#202020",  "",         "",  s:termBlack)

"call s:X("Visual",  "",  "#404040",  "",  "",  s:termBlack)
call s:X("Visual",  "#ffffff",  "#215d9c",  "",  "",  s:termBlack)

"call s:X("Term",         "#e8e8d3", "#000000", "",        "", s:termBlack)
call s:X("TermCursor",   "",        "#202020", "reverse", "", s:termBlack)
call s:X("TermCursorNC", "",        "#7e7e7e", "",        "", s:termBlack)

call s:hi('WildMenu',      g:ui.wildmenu)
call s:X('StatusLine',    "#e8e8d3", "#666660", "NONE", "", "")
call s:X('StatusLineNC',  "#1f1f1f", "#666660", "NONE", "", "")
"call s:hi('StatusLineNC',  g:ui.border)
call s:X('VertSplit',     "#666660", "#1f1f1f", "", "", "")
"call s:hi('VertSplit',    g:ui.border)

call s:hi("Pmenu",      g:ui.popup)
call s:hi("PmenuSel",   g:ui.selected)
call s:hi("PmenuSbar",  g:ui.border)
call s:hi("PmenuThumb", g:ui.selected)

call s:hi("TabLineFill",  g:ui.tabsep)
call s:X("TabLine",      g:ui.active[0], g:ui.active[1], 'NONE', '', '')
call s:hi("TabLineSel",   g:ui.selected)
call s:hi("Separator",    g:ui.tabsep)

call s:hi("Buffer",         g:ui.tabline)
call s:hi("BufferActive",   g:ui.active)
call s:hi("BufferCurrent",  g:ui.selected[0], g:ui.selected[1])
call s:hi("BufferIcon",         "#deded0", g:ui.tabline[1])
call s:hi("BufferActiveIcon",   "#efaa2c", g:ui.active[1])
call s:hi("BufferCurrentIcon",  "#efaa2c", g:ui.selected[1])

call s:X("LineNr"      , "#605958", "#1f1f1f", "none", s:termBlack, "")
call s:X("CursorLineNr", "#ccc5c4", "#1f1f1f", "bold", "White", "")

call s:X("Folded"     , "#999999"      , "#252525", "",s:termBlack, "")
call s:X("FoldColumn" , "#535D66"      , "#1f1f1f", ""            , "" ,s:termBlack)
call s:X("SignColumn" , "#777777"      , "#333333", ""            , "" ,s:termBlack)
call s:X("ColorColumn", ""       ,       "#333333", ""            , "" ,s:termBlack)

call s:X("Search",           "",         "#505021",  "",         "",  "")
call s:X("IncSearch",        "#afdf00",  "",         "reverse",  "",  "")
call s:X("IncSearchCursor",  "#500000",  "#ffb700",  "bold",     "",  "")

call s:X("TextInfo",    "#599eff" , "" , "" , "" , "")
call s:X("TextSuccess", "#42E968" , "" , "" , "" , "")
call s:X("TextWarning", "#efa025" , "" , "" , "" , "")
call s:X("TextError",   "#ef2021" , "" , "" , "" , "")
call s:X("TextSpecial", "#f92672","","","","")

hi! link Msg        TextSuccess
hi! link MoreMsg    TextInfo
hi! link WarningMsg TextWarning
hi! link ErrorMsg   TextError

call s:X("Error" , "",  "#901010" , "" , "" , "")
call s:X("NonText"   ,  "#606060", "#151515", "", s:termBlack, "")
call s:X("EndOfBuffer", "#606060", "#151515", "", s:termBlack, "")
call s:X("MatchParen" , "#ff0000" , "" , "bold" , ""      , "DarkCyan")

" }}}
" Lang {{{

call s:X("SpecialKey",  "#868680", "#2e2e2e", "", s:termBlack, "")

call s:X("Question" , "#65C254", ""       , "", "Green" , "")
call s:X("Directory", "#dad085", ""       , "", "Yellow", "")

call s:X("Title",   "#70b950","","bold","Green","")
call s:X("Title2",  "#f0e930","","bold","Green","")
"call s:X("Label", "377edd",  "",  "",  "Blue",      "") link Statement

" TODO update this
call s:X("Comment"    , "#888888" , "" , ""     , "Grey"  , "")
call s:X("Todo"       , "#c7c7c7" , "" , "bold" , "White" , s:termBlack)

call s:X("Lock",        "#ff0000", "", "", "Red"    ,            "")
call s:X("Global",      "#d06d4c", "", "", "Red",   "")
call s:X("ModConst",    "#af0000", "", "", "Red",   "")

call s:X("Constant",    "#ef6a4c", "", "",     "Red"    ,            "")
call s:X("Number",      "#ef6a4c", "", "",     "Red"    ,            "")
call s:X("Boolean",     "#ef6a4c", "", "",      "Yellow"    ,            "")
call s:X("Enum",        "#efaa2c", "", "",     "Red"    ,            "")
call s:X("Special",     "#799d6a", "", "",     "Green", "")
call s:X("SpecialChar", "#799d6a", "", "bold",     "Green", "")
call s:X("Delimiter",   "#668799", "", "",     "Grey"   ,            "")
call s:X("Structure",   "#599eff", "", "",        "LightBlue", "")

call s:X("ModString"       ,"#70d640","","","Green","")
call s:X("String"          ,"#acd279","","","Green","")
call s:X("StringDelimiter" ,"#799033","","","DarkGreen","")
"call s:X("String"         ,"#58F040","","","Green","")
"call s:X("Char"           ,"SeaGreen","","","Green","")

call s:X("ModType", "#40cf00", "", "", "Green", "")
call s:X("ModVar",  "#5faf00", "", "", "Green", "")

call s:X("PreProc", "#8fbfdc", "", "bold", "LightBlue", "")
call s:X("Macro",   "#8fbfdc", "", "bold", "LightBlue", "")

call s:X("Function"  , "#fad07a", "", ""    , "Yellow"   , "")
call s:X("Identifier", "#bb88bb", "", ""    , "LightCyan", "")
call s:X("ModId",      "#a755df", "", ""    , "LightCyan", "")
call s:X("ModKey",     "#a040af", "", "", "LightCyan", "")
call s:X("DKeyword",   "#70009f", "", "bold", "LightCyan", "")

call s:X("Operator",   "#599eff", "", ""    , "LightBlue", "")
call s:X("Repeat",     "#599eff", "", ""    , "LightBlue" , "")
call s:X("Keyword",    "#599eff", "", ""    , "LightBlue" , "")
call s:X("Statement",  "#599eff", "", ""    , "LightBlue" , "")
call s:X("BStatement", "#345fa8", "", ""    , "LightBlue" , "")
call s:X("BKeyword",   "#2a40dd", "", "bold", "LightBlue" , "")
call s:X("DStatement", "#0000af", "", ""    , "LightBlue" , "")

call s:X("Type",         "#ffb964", "", "", "Yellow","")
call s:X("Class",        "#c59f6f", "", "", "DarkBlue",  "")
call s:X("StorageClass", "#c59f6f", "", "", "Red","")
call s:X("MedKey",       "#dfb700", "", "", "Red","")
call s:X("HighKey",      "#ffd700", "", "", "Red","")
call s:X("HighType",     "#ff8700", "", "", "Red","")

call s:X( "Symbol",                "#447799",  "",  "",  "Blue",      "")
call s:X( "Control",               "#7597c6",  "",  "",  "Blue",      "")
call s:X( "PredefinedIdentifier",  "#c6b6fe",  "",  "bold",  "Cyan",  "")

call s:X("Variable",     "#ffaf70", "", "", "Red", "")
call s:X("Variable2",    "#de5577", "", "", "Red", "")
call s:X("DVariable",    "#d30977", "", "", "Red", "")
call s:X("DHyper",       "#ff0087", "", "", "Red", "")
call s:X("Instance",     "#ee7567", "", "", "Red", "")
call s:X("KInstance",    "#ffff88", "", "", "Red", "")
call s:X("DInstance",    "#dea537", "", "", "Red", "")

call s:X("RegexpDelimiter",      "#540063", "","bold","Magenta","")
call s:X("RegexpSpecial",        "#a40073", "","",    "Magenta","")
call s:X("Regexp",               "#dd0093", "","",    "DarkMagenta","")

" }}}
" Diff " {{{1

hi! link diffRemoved Constant
hi! link diffAdded   String

" VimDiff

call s:X("DiffAdd",    "#D2EBBE" , "#437019" , ""        , "White"   , "DarkGreen")
call s:X("DiffDelete", "#40000A" , "#700009" , ""        , "DarkRed" , "DarkRed")
call s:X("DiffChange", ""        , "#2B5B77" , ""        , "White"   , "DarkBlue")
call s:X("DiffText",   "#8fbfdc" , "#000000" , "reverse" , "Yellow"  , "")

" PHP " {{{1

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

" Python " {{{1

hi! link pythonOperator Operator

" Ruby " {{{1

hi! link rubyRegexpDelimiter       RegexpDelimiter
hi! link rubyRegexp                Regexp
hi! link rubyRegexpSpecial         RegexpSpecial
hi! link rubyPredefinedIdentifier  PredefinedIdentifier

hi! link rubyClass              Class
hi! link rubyIdentifier         Identifier
hi! link rubyInstanceVariable   InstanceVariable
hi! link rubySymbol             Symbol
hi! link rubyControl            Control

hi! link rubySharpBang Comment
hi! link rubyConstant  Type
hi! link rubyFunction  Function

hi! link rubyGlobalVariable rubyInstanceVariable
hi! link rubyModule         rubyClass

hi! link rubyString                 String
hi! link rubyStringDelimiter        StringDelimiter
hi! link rubyInterpolationDelimiter Identifier


" Erlang " {{{1

hi! link erlangAtom rubySymbol
hi! link erlangBIF rubyPredefinedIdentifier
hi! link erlangFunction rubyPredefinedIdentifier
hi! link erlangDirective Statement
hi! link erlangNode Identifier

" JavaScript " {{{1

hi! link javaScriptValue Constant
hi! link javaScriptRegexpString rubyRegexp

" CoffeeScript " {{{1

hi! link coffeeRegExp javaScriptRegexpString

" Lua " {{{1

hi! link luaOperator Conditional

" C " {{{1

hi! link cFormat Identifier
hi! link cOperator Constant

" Objective-C/Cocoa " {{{1

hi! link objcClass Type
hi! link cocoaClass objcClass
hi! link objcSubclass objcClass
hi! link objcSuperclass objcClass
hi! link objcDirective rubyClass
hi! link cocoaFunction Function
hi! link objcMethodName Identifier
hi! link objcMethodArg Normal
hi! link objcMessageName Identifier

" Vimscript " {{{1

hi! link vimUserFunc Normal
hi! link vimOper     Operator

" Debugger {{{1

call s:X("DbgCurrent","#DEEBFE","#345FA8","","White","DarkBlue")
call s:X("DbgBreakPt","","#4F0037","","","DarkMagenta")

" Indent guides " {{{1

if !exists("g:indent_guides_auto_colors")
  let g:indent_guides_auto_colors = 0
endif
call s:X("IndentGuidesOdd","","#151515","","","")
call s:X("IndentGuidesEven","","#1b1b1b","","","")

" Other " {{{1

call s:X("PreciseJumpTarget","#B9ED67","#405026","","White","Green")

hi! link TagbarHighlight    Visual

" Manual overrides for 256-color terminals. Dark colors auto-map badly.{{{1
if !exists("g:jellybeans_background_color_256")
  let g:jellybeans_background_color_256=233
end
if !s:low_color
  hi StatusLine       ctermbg=235
  hi StatusLineNC     ctermbg=235
  hi Folded           ctermbg=236
  hi FoldColumn       ctermbg=234
  hi SignColumn       ctermbg=236
  hi CursorColumn     ctermbg=234
  hi CursorLine       ctermbg=234
  hi SpecialKey       ctermbg=234
  exec "hi Normal     ctermbg=".g:jellybeans_background_color_256
  exec "hi NonText    ctermbg=".g:jellybeans_background_color_256
  exec "hi LineNr     ctermbg=".g:jellybeans_background_color_256
  hi DiffText         ctermfg=81
  hi DbgBreakPt       ctermbg=53
  hi IndentGuidesOdd  ctermbg=235
  hi IndentGuidesEven ctermbg=234
endif

if exists("g:jellybeans_overrides") " {{{1
  fun! s:load_colors(defs)
    if len(a:defs) == 0
        return
    end
    for [l:group, l:v] in items(a:defs)
      call s:X(l:group, get(l:v, 'guifg', ''), get(l:v, 'guibg', ''),
      \                 get(l:v, 'attr', ''),
      \                 get(l:v, 'ctermfg', ''), get(l:v, 'ctermbg', ''))
      if !s:low_color
        for l:prop in ['ctermfg', 'ctermbg']
          let l:override_key = '256'.l:prop
          if has_key(l:v, l:override_key)
            exec "hi ".l:group." ".l:prop."=".l:v[l:override_key]
          endif
        endfor
      endif unlet l:group
      unlet l:v
    endfor
  endfun
  call s:load_colors(g:jellybeans_overrides)
  delf s:load_colors
endif

" delete functions {{{
fu! s:rm_functions ()
    delf s:X
    delf s:rgb
    delf s:color
    delf s:rgb_color
    delf s:rgb_level
    delf s:rgb_number
    delf s:grey_color
    delf s:grey_level
    delf s:grey_number
endfu
" }}}
"
