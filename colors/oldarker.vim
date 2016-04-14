"hi clear
set background=dark
" Setup & funcs {{{
let colors_name = "darker"
let s:termBlack = 'black'
let s:low_color = 0

if exists("syntax_on")
  syntax reset
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
fun! s:rgb_color(x,                          y, z) " {{{
  if &t_Co == 88
    return 16 + (a:x * 16) + (a:y * 4) + a:z
  else
    return 16 + (a:x * 36) + (a:y * 6) + a:z
  endif
endfun " }}}

" returns the palette index to approximate the given R/G/B color levels
fun! s:color(r,                              g, b) " {{{
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
      return s:rgb_color(l:x,                l:y, l:z)
    endif
  else
    " only one possibility
    return s:rgb_color(l:x,                  l:y, l:z)
  endif
endfun " }}}

" returns the palette index to approximate the 'rrggbb' hex string
fun! s:rgb(rgb) " {{{
  let l:r = ("0x" . strpart(a:rgb,           0, 2)) + 0
  let l:g = ("0x" . strpart(a:rgb,           2, 2)) + 0
  let l:b = ("0x" . strpart(a:rgb,           4, 2)) + 0
  return s:color(l:r,                        l:g, l:b)
endfun " }}}

" sets the highlighting for the given group
fu! s:X(group,                               ...) " {{{
  " fg, bg, attr, lcfg, lcbg
  let hl = type(a:1)==type([]) ? a:1 : a:000

  let group = a:group
  let fg   = get(hl,                         0, '')
  let bg   = get(hl,                         1, '')
  let attr = get(hl,                         2, '')
  let lcfg = get(hl,                         3, '')
  let lcbg = get(hl,                         4, '')

  if !empty(fg) && fg =~ '#'
      let fg = strpart(fg,                   1) | end
  if !empty(bg) && bg =~ '#'
      let bg = strpart(bg,                   1) | end

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
fu! s:hi (name,                              ...) " {{{
    let name = a:name
    let group = []
    if type(a:1) == 1 " String
        let group = a:000
    else
        let group = a:1
    end

    let fg = get(group,                      0, '')
    let bg = get(group,                      1, '')
    let attr = get(group,                    2, '')
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
" Colors {{{
let theme = {}
"let theme.base                 = '#282828'
let theme.base                  = '#202020'
let theme.insensitive_base      = '#282828'

let theme.fg                    = '#ffffff'
let theme.bg                    = '#282828'
let theme.bg_dark               = '#151515'

let theme.text                  = '#dddddc'
let theme.hover                 = '#333636'

let theme.selected              = '#215d9c'
let theme.selected_fg           = '#ffffff'

"let theme.insensitive          = '#515a5a'
let theme.insensitive_bg        = '#333636'
let theme.insensitive_fg        = '#949796'

let theme.unfocused_fg          = '#949796'
let theme.unfocused_text        = '#eeeeec'
let theme.unfocused_bg          = '#393f3f'
let theme.unfocused_base        = '#2c2c2c'
let theme.unfocused_selected_bg = '#215d9c'
let theme.unfocused_selected_fg = '#ffffff'

let theme.border                = '#1c1f1f'
let theme.unfocused_border      = '#1f2222'

let theme.folded_bg             = '#252525'
let theme.folded_fg             = '#999999'

" previous colors {{{
if !exists('g:ui')
    let g:ui = {}
    let g:ui.border   = ['#666660', '#666660']
    let g:ui.wildmenu = ['#f4fbfe', '#345fa8']
    let g:ui.selected = ['#f4fbfe', '#599eff']
    let g:ui.popup    = ['#e8e8d7', '#4e4e48']
    let g:ui.tabline  = ['#a8a89e', '#666660']
    let g:ui.tabsep   = ['#4e4e48', '#4e4e48']
    let g:ui.active   = ['#f4fbfe', '#808078']
end " }}}

" }}}
" General UI {{{
call hi#("Normal",       theme.fg,             theme.bg,             "")
call hi#("EndOfBuffer",  theme.base,           theme.bg,             "")
call hi#("Cursor",       "",                   theme.base,           "reverse")
call hi#("CursorLine",   "",                   theme.hover)
call hi#("CursorColumn", "",                   theme.hover)
call hi#("LineNr",       theme.insensitive_fg, theme.insensitive_bg, "none")
call hi#("CursorLineNr", theme.text,           theme.base,           "none")
call hi#("Visual",       theme.selected_fg,    theme.selected)
call hi#("TermCursor",   "",                   theme.base,           "reverse")
call hi#("TermCursorNC", "",                   theme.unfocused_base, "")

call hi#('WildMenu',     theme.fg,             theme.selected)
call hi#('StatusLine',   theme.fg,             "#666660",    "NONE", "", "")
call hi#('StatusLineNC', "#1f1f1f",            "#666660",    "NONE", "", "")
call hi#('VertSplit',    theme.insensitive_bg, theme.border, "",     "", "")

call hi#("Pmenu",      ['#e8e8d7', '#4e4e48'])
call hi#("PmenuSel",   ['#f4fbfe', '#599eff'])
call hi#("PmenuSbar",  ['#666660', '#666660'])
call hi#("PmenuThumb", ['#f4fbfe', '#599eff'])

call hi#("Folded",      "#c9c9c0",            "#404040",            "")
call hi#("FoldColumn",  "#535D66",            "#1f1f1f",            "", "", s:termBlack)
call hi#("SignColumn",  "",                   theme.insensitive_bg, "", "", s:termBlack)
call hi#("ColorColumn", "",                   theme.insensitive_bg, "", "", s:termBlack)
call hi#("LineNr",      theme.insensitive_fg, theme.insensitive_bg, "none")

call hi#("TabLine",      '#f4fbfe', g:ui.active[1], 'NONE', '', '')
call hi#("TabLineFill", ['#4e4e48', '#4e4e48'])
call hi#("TabLineSel",  ['#f4fbfe', '#599eff'])
call hi#("Separator",   ['#4e4e48', '#4e4e48'])

call hi#("Buffer",            '#a8a89e', '#666660')
call hi#("BufferActive",      '#f4fbfe', '#808078')
call hi#("BufferCurrent",     '#f4fbfe', '#599eff')
call hi#("BufferM",           '#a8a89e')
call hi#("BufferActiveM",     '#f4fbfe', '#808078', 'italic')
call hi#("BufferCurrentM",    '#f4fbfe', '#599eff', 'italic')
call hi#("BufferIcon",        "#deded0", '#666660')
call hi#("BufferActiveIcon",  "#efaa2c", '#808078')
call hi#("BufferCurrentIcon", "#efaa2c", '#599eff')

call hi#("Search",          "", "#505050", "")
call hi#("IncSearch",       "",     "#5b5b5b", "")
call hi#("IncSearchCursor", "",     "#ffb700", "")

call hi#("NonText",    "#606060", "#151515", "")
call hi#("MatchParen", "#efefef", "#345fa8", "")

call hi#("Todo",    "#397edf", "none", "bold")
call hi#("Section", "#F9FA00", "none", "bold")

let log = {}
let log.Info    = "#599eff"
let log.Success = "#42E968"
let log.Warning = "#efa025"
let log.Debug   = "#F9FA00"
let log.Error   = "#ef2021"
let log.Special = "#9c5fff"

for k in keys(log)
    call hi#('Text'.k, log[k], '', '')
    call hi#('Bold'.k, log[k], '', 'bold')
    call hi#link(k, 'Text' . k)
endfor

hi! link Msg        TextSuccess
hi! link MoreMsg    TextInfo
hi! link WarningMsg TextWarning
hi! link ErrorMsg   TextError
hi! link ModeMsg    BoldSpecial

call hi#("Key",        "#799d6a", "",        "")
call hi#("SpecialKey", "#868680", "#2e2e2e", "")

call hi#("Question",   "#65C254", "",        "",     "Green",     "")
call hi#("Question2",  "#70b950", "",        "bold", "Green",     "")

call hi#("Directory",  "#bab075", "",        "",     "Yellow",    "")
call hi#("Directory2", "#dad085", "",        "",     "Yellow",    "")
call hi#("Title",      "#bab075", "",        "bold")
call hi#("Title2",     "#f0e930", "",        "bold")

call hi#("Bold", "", "", "bold")

" }}}
" Definitions: {{{1
" *Comment	any comment                                                       {{{
"
" *Constant	any constant
"  String		a string constant: "this is a string"
"  Character	a character constant: 'c', '\n'
"  Number		a number constant: 234, 0xff
"  Boolean	a boolean constant: TRUE, false
"  Float		a floating point constant: 2.3e10
"
" *Identifier	any variable name
"  Function	function name (also: methods for classes)
"
" *Statement	any statement
"  Conditional	if, then, else, endif, switch, etc.
"  Repeat		for, do, while, etc.
"  Label		case, default, etc.
"  Operator	"sizeof", "+", "*", etc.
"  Keyword	any other keyword
"  Exception	try, catch, throw
"
" *PreProc	generic Preprocessor
"  Include	preprocessor #include
"  Define		preprocessor #define
"  Macro		same as Define
"  PreCondit	preprocessor #if, #else, #endif, etc.
"
" *Type		int, long, char, etc.
"  StorageClass	static, register, volatile, etc.
"  Structure	struct, union, enum, etc.
"  Typedef	A typedef
"
" *Special	any special symbol
"  SpecialChar	special character in a constant
"  Tag		you can use CTRL-] on this
"  Delimiter	character that needs attention
"  SpecialComment	special things inside a comment
"  Debug		debugging statements
"
" *Underlined	text that stands out, HTML links
"
" *Ignore		left blank, hidden  |hl-Ignore|
"
" *Error		any erroneous construct
"
" *Todo		anything that needs extra attention; mostly the
" 		keywords TODO FIXME and XXX
" Lang {{{1

call hi#("Tag",  "#80a0ff", "", "underline")
call hi#("Link", "#80a0ff", "", "underline")
call hi#("URL",  "#80a0ff", "", "underline")

call hi#("Comment"   ,      "#888888" ,  "" ,  ""     ,  "Grey")
call hi#("SpecialComment",  "#7597c6",   "",   "bold",   "Green")
call hi#("SpecialComment2", "#799d6a",   "",   "bold",   "Green")

call hi#("Global",    "#668799", "", "bold")
call hi#("PreProc",   "#7597c6", "", "bold")
call hi#("Macro",     "#7597c6", "", "bold")
call hi#("Define",    "#7597c6", "", "bold")
call hi#("PreCondit", "#7597c6", "", "bold")
call hi#("Include",   "#7597c6", "", "bold")

call hi#("Operator",   "#599eff", "", ""    , "LightBlue", "")
call hi#("Repeat",     "#599eff", "", ""    , "LightBlue" , "")
call hi#("Keyword",    "#599eff", "", ""    , "LightBlue" , "")
call hi#("Statement",  "#599eff", "", ""    , "LightBlue" , "")
call hi#("Label",      "#377edd",   "",         "",      "Blue",       "")

call hi#("Statement2", "#397edf", "", ""    , "LightBlue" , "")
call hi#("Statement3", "#195ebf", "", ""    , "LightBlue" , "")
call hi#("Keyword2",   "#2a40dd", "", "bold", "LightBlue" , "")
call hi#("Keyword3",   "#7597c6",  "",  "",  "Blue",      "")

call hi#("Constant", "#ef6a4c", "", "bold")
call hi#("Number",   "#ff5f00", "", "")
call hi#("Float",    "#ff5f00", "", "")
"call hi#("Boolean",  "#f0f000", "", "")
call hi#("Boolean",  "#ef6a4c", "", "")
call hi#("Enum",     "#efaa2c", "", "")

call hi#("Delimiter",   "#668799", "", "",     "Grey",  "")
call hi#("Delimiter2",  "#799033", "", "",     "Grey",  "")
call hi#("SpecialChar", "#799d6a", "", "bold", "Green", "")

" FIXME remove
call hi#("OldSpecial",  "#799d6a", "", "",     "Green", "")

call hi#("String1",         "#acd279", "", "", "Green",     "")
call hi#("String2",         "#58F040", "", "", "Green",     "")
call hi#("String3",         "#70d640", "", "", "Green",     "")
call hi#("String4",         "#40cf00", "", "", "Green",     "")
call hi#("String5",         "#5faf00", "", "", "Green",     "")
call hi#("StringDelimiter", "#799033", "", "", "DarkGreen", "")

call hi#("String", "#70d640", "", "")
call hi#("Character", "#5faf00", "", "bold")

"call hi#("htmlString", "#0077aa", "", "", "Blue", "")
"call hi#("htmlTagName","#990055", "", "", "Blue", "")
"call hi#("htmlArg",    "#669900", "", "", "Blue", "")

call hi#("violet",  "#9c5fff", "", "", "LightCyan", "")
call hi#("Purple",  "#a755df", "", "", "LightCyan", "")
call hi#("Purple2", "#a040af", "", "", "LightCyan", "")
call hi#("Purple3", "#EB95ED", "", "", "LightCyan", "")
hi! link SpecialIdentifier  Purple
"hi! link Special            Purple

"call hi#("Identifier",  "#f0eeff",  "",  "")
call hi#("Identifier",  "#ffe790",  "",  "")
call hi#("Variable",    "#ffe790",  "",  "")
call hi#("Argument",    "#dea537",  "",  "")
call hi#("Var1",        "#dea537",  "",  "",  "Red",  "")
call hi#("Var2",        "#c59f6f",  "",  "",  "Red",  "")
call hi#("Var3",        "#b58f5f",  "",  "",  "Red",  "")
call hi#("Var4",        "#a57f4f",  "",  "",  "Red",  "")

" func name
call hi#("Function"  ,  "#fad07a",  "",  ""    ,  "Yellow"   ,  "")
call hi#("Method"  ,    "#fad07a",  "",  "bold"    ,  "Yellow"   ,  "")

call hi#("Structure",   "#599eff", "", "",        "LightBlue", "")

call hi#("Symbol",               "#447799", "", "",     "Blue",   "")
call hi#("Control",              "#7597c6", "", "",     "Blue",   "")
call hi#("PredefinedIdentifier", "#7597c6", "", "bold", "Cyan",   "")
call hi#("Predefined",           "#c6b6fe", "", "bold", "Yellow", "")

call hi#("StaticFunc", "#ffb964", "", "")
call hi#("Property1",  "#d5af7f", "", "")
call hi#("Property2",  "#c59f6f", "", "")
call hi#("Property3",  "#b58f5f", "", "")
call hi#("Property4",  "#a57f4f", "", "")
call hi#("Property5",  "#956f3f", "", "")
hi def link Property Property1

call hi#("StorageClass", "#d5af7f", "", "")
call hi#("Class",        "#c59f6f", "", "", "darkyellow", "")

call hi#("Type",  "#ffb964", "", "")
call hi#("Type1", "#ffaf70", "", "", "Red", "")
call hi#("Type2", "#ee7567", "", "", "Red", "")
call hi#("Type3", "#de5577", "", "", "Red", "")
call hi#("Type4", "#d30977", "", "", "Red", "")
call hi#("Type5", "#ff0087", "", "", "Red", "")

call hi#("Regexp",          "#dd0093", "", "")
call hi#("RegexpSpecial",   "#a40073", "", "")
call hi#("RegexpDelimiter", "#540063", "", "bold")
call hi#("RegexpKey",       "#fefdfc", "#5f0041", "")

" }}}
" Diff                                                                       {{{

call hi#("DiffAdd",      "#38ad2c", "",          "")
call hi#("DiffDelete",   "#e04242", "",          "bold")
call hi#("DiffChange",   "#ddcf00", "",          ""        )
call hi#("DiffModified", "#3c43c2", "",          ""        )
call hi#("DiffText",     "#363BA9", theme.hover, "" )
hi! link diffAdded   DiffAdd
hi! link diffRemoved DiffDelete
"                                                                            }}}
" Debugger {{{1

call hi#("DbgCurrent",   "#DEEBFE", "#345FA8")
call hi#("DbgBreakPt",   "",        "#4F0037")

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

" CoffeeScript " {{{1

hi! link coffeeRegExp rubyRegexp

" Lua " {{{1

hi! link luaOperator Conditional

" Moonscript {{{1
hi! link moonObject     Type
hi! link moonSpecialOp  StringDelimiter
hi! link moonSpecialVar Identifier
hi! link moonObjAssign  StorageClass
hi! link moonObjAssign  StorageClass
hi! link moonConstant   Global

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

" 1}}}

call hi#("PreciseJumpTarget","#B9ED67","#405026","","White","Green")
hi! link helpHyperTextJump Purple

" Indent guides
"if !exists("g:indent_guides_auto_colors")
  "let g:indent_guides_auto_colors = 0
"endif

" Manual overrides for 256-color terminals. Dark colors auto-map badly.{{{1
if !exists("g:darker_background_color_256")
  let g:darker_background_color_256=233
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
  exec "hi Normal     ctermbg=".g:darker_background_color_256
  exec "hi NonText    ctermbg=".g:darker_background_color_256
  exec "hi LineNr     ctermbg=".g:darker_background_color_256
  hi DiffText         ctermfg=81
  hi DbgBreakPt       ctermbg=53
  hi IndentGuidesOdd  ctermbg=235
  hi IndentGuidesEven ctermbg=234
endif

if exists("g:darker_overrides") " {{{1
  fun! s:load_colors(defs)
    if len(a:defs) == 0
        return
    end
    for [l:group, l:v] in items(a:defs)
      call hi#(l:group, get(l:v, 'guifg', ''), get(l:v, 'guibg', ''),
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
  call s:load_colors(g:darker_overrides)
  delf s:load_colors
endif

" delete functions {{{
fu! s:rm_functions ()
    "delf hi#
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
