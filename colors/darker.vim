" !::exe [so %]

let colors_name = "darker"
set background=dark
if get(g:, 'debug', 0) && exists("syntax_on")
    syntax reset
    syntax enable
endif

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

let colors = {}
for k in keys(s:)
    let colors[k] = s:{k}
endfor
"call pp#print(s:)

"finish

for k in keys(g:colors)
    let c = get(g:colors, k, 0)
    if _#isString(c)
        call hi#('fg_' . k, c,  '', '')
        call hi#('bg_' . k, '', c,  '')
        call hi#('b_'  . k, c,  '', 'bold')
    end
    unlet c
endfor

func! s:mod1 (color)
    return [s:base3, a:color]
endfu

func! s:mod2 (color)
    return [s:base1, a:color]
endfu

" Basic groups {{{

let hl_high = [ s:base02, s:base2 ]
let hl_med  = [ s:base3, s:base00 ]
let hl_med0 = [ s:base02, s:base00 ]
let hl_low  = [ s:base00, s:base02 ]

call hi#('High', hl_high)
call hi#('Med',  hl_med )
call hi#('Med0', hl_med0)
call hi#('Low',  hl_low )

let s:part1  = [ s:base02, s:base2 ]
let s:part1b = [ s:base02, s:base2 ]
let s:part2  = [ s:base3, s:base00 ]
let s:part3  = [ s:base3, s:base00 ]

let s:part00  = [s:base00,     s:base00]
let s:part00b = [s:base02,     s:base00]
let s:part01  = [s:base02,     s:base00]
let s:part01b = [s:base00,     s:base02]
let s:part02  = [s:base2,      s:base00]
"let s:part3 = [s:base3, s:base00]
let s:term        = [ s:white, s:_black,        'bold' ]
let s:labelOrange = [ s:white, s:brightorange,  'bold' ]
let s:labelGreen  = [ s:white, s:mediumgreen,   'bold' ]
let s:labelBlue   = [ s:white, s:brightblue,    'bold' ]
let s:labelPurple = [ s:white, s:darkestpurple, 'bold' ]
" }}}

" Colors                                                                     {{{
let theme = {}
"let theme.base                 = '#282828'
let theme.base                  = '#202020'
let theme.insensitive_base      = '#282828'

let theme.fg                    = '#ffffff'
let theme.bg                    = '#282828'
let theme.bg_dark               = '#151515'

let theme.text                  = '#dddddc'
let theme.hover                 = '#333636'
let theme.search                = '#505050'

let theme.selected              = '#215d9c'
let theme.selected_fg           = '#ffffff'
let theme.selection             = ['#f4fbfe', '#215d9c']
let theme.light_selection       = ['#f4fbfe', '#599eff']

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

" previous colors                                                            {{{
"if !exists('g:ui')
    "let g:ui = {}
    "let g:ui.border   = ['#666660', '#666660']
    "let g:ui.wildmenu = ['#f4fbfe', '#345fa8']
    "let g:ui.selected = ['#f4fbfe', '#599eff']
    "let g:ui.popup    = ['#e8e8d7', '#4e4e48']
    "let g:ui.tabline  = ['#a8a89e', '#666660']
    "let g:ui.tabsep   = ['#4e4e48', '#4e4e48']
    "let g:ui.active   = ['#f4fbfe', '#808078']
"end "                                                                        }}}

" }}}
" General UI                                                                 {{{
call hi#("Normal",       theme.fg,             theme.bg,             "")
call hi#("EndOfBuffer",  theme.base,           theme.bg,             "")
call hi#("Cursor",       "",                   theme.base,           "reverse")
call hi#("CursorLine",   "",                   theme.hover)
call hi#("CursorColumn", "",                   theme.hover)
call hi#("LineNr",       theme.insensitive_fg, theme.insensitive_bg, "none")
call hi#("CursorLineNr", theme.text,           theme.base,           "none")
call hi#("Visual",       theme.selected_fg,    theme.selected)
call hi#("TermCursor",   "",                   theme.base,           "")
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
call hi#("FoldColumn",  "#535D66",            "#1f1f1f",            "")
call hi#("SignColumn",  "",                   theme.insensitive_bg, "")
call hi#("ColorColumn", "",                   theme.insensitive_bg, "")
"call hi#("LineNr",      theme.insensitive_fg, theme.insensitive_bg, "none")

"call hi#("TabLine",     '#f4fbfe', '#808078', 'none')
"call hi#("TabLine",     '#f4fbfe', '#808078', 'none')
call hi#("TabLine",     '#4e4e48', '#4e4e48', 'none')
call hi#("TabLineFill", '#4e4e48', '#808078', 'none')
call hi#("TabLineSel",  '#f4fbfe', '#599eff', 'none')
call hi#("Separator",   '#4e4e48', '#4e4e48', 'none')

call hi#("Buffer",            '#a8a89e', '#666660')
call hi#("BufferActive",      '#f4fbfe', '#808078')
call hi#("BufferCurrent",     '#f4fbfe', '#599eff')
call hi#("BufferM",           '#efaa2c', '#666660', 'italic')
call hi#("BufferActiveM",     '#efaa2c', '#808078', 'italic')
call hi#("BufferCurrentM",    '#efaa2c', '#599eff', 'italic')
call hi#("BufferIcon",        "#deded0", '#666660')
call hi#("BufferActiveIcon",  "#efaa2c", '#808078')
call hi#("BufferCurrentIcon", "#efaa2c", '#599eff')

call hi#("Search",          "none",    theme.search, "none")
call hi#("IncSearch",       "#870000", "#ffb700", "none")
call hi#("IncSearchCursor", "",        "",        "reverse")

call hi#("NonText",    "#606060", "#151515", "")
call hi#("MatchParen", "none",    "#28485f", "")

call hi#("Todo",    "#397edf", "none", "bold")
call hi#("Section", "#F9FA00", "none", "bold")

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

call hi#("Key",        "#799d6a", "",        "")
call hi#("SpecialKey", "#868680", "#2e2e2e", "")

call hi#("Question",   "#65C254", "",        "",     "Green",     "")
call hi#("Question2",  "#70b950", "",        "bold", "Green",     "")

call hi#("Directory",  "#ffff00", "",        "bold")
call hi#("Directory2", "#dad085", "",        "")
call hi#("Title",      "#bab075", "",        "bold")
call hi#("Title2",     "#f0e930", "",        "bold")

call hi#("Bold", "", "", "bold")

" }}}
" Definitions:                                                              {{{1
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
" Lang                                                                      {{{1

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

call hi#("Symbol",               "#447799", "", "")
call hi#("ControlN",             "#7597c6", "", "")
call hi#("Control",              "#7597c6", "", "bold")
call hi#("PredefinedIdentifier", "#7597c6", "", "bold")
call hi#("Predefined",           "#c6b6fe", "", "bold")

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

call hi#("DiffAdd",      "#38ad2c", "none",      "")
call hi#("DiffDelete",   "#e04242", "none",      "")
call hi#("DiffChange",   "#ddcf00", "none",      "")
call hi#("DiffModified", "#3c43c2", "none",      "")
call hi#("DiffText",     "#363BA9", "none", "")
hi! link diffAdded   DiffAdd
hi! link diffRemoved DiffDelete
"                                                                            }}}
" Debugger                                                                  {{{1

"call hi#("DbgCurrent",   "#DEEBFE", "#345FA8")
"call hi#("DbgBreakPt",   "",        "#4F0037")
call hi#("PreciseJumpTarget","#B9ED67","#405026","","White","Green")
hi! link helpHyperTextJump Purple

" Others                                                                     {{{1
" PHP "                                                                     {{{2

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

" Python "                                                                  {{{2

hi! link pythonOperator Operator

" Ruby "                                                                    {{{2

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


" Erlang "                                                                  {{{2

hi! link erlangAtom rubySymbol
hi! link erlangBIF rubyPredefinedIdentifier
hi! link erlangFunction rubyPredefinedIdentifier
hi! link erlangDirective Statement
hi! link erlangNode Identifier

" CoffeeScript "                                                            {{{2

hi! link coffeeRegExp rubyRegexp

" Lua & Moonscript"                                                         {{{2

hi! link luaOperator Conditional

hi! link moonObject     Type
hi! link moonSpecialOp  StringDelimiter
hi! link moonSpecialVar Identifier
hi! link moonObjAssign  StorageClass
hi! link moonObjAssign  StorageClass
hi! link moonConstant   Global

" C "                                                                       {{{2

hi! link cFormat Identifier
hi! link cOperator Constant

" Objective-C/Cocoa "                                                       {{{2

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

let palette = {
            \ 'normal': {}, 'inactive': {}, 'insert': {},
            \ 'replace': {}, 'visual': {}, 'select': {},
            \ 'tabline': {}, 'terminal': {} }

"let s:mode = [
            "\ 'normal', 'inactive', 'insert',
            "\ 'replace', 'visual', 'select',
            "\ 'tabline', 'terminal' ]

"for mx in s:mode
    "let palette[mx] = {}
    "echo mx . ':' . string(palette[mx])
"endfor

let palette.normal.left     = [ s:mod1(s:blue), s:part1, s:part2 ]
let palette.normal.right    = [ s:mod2(s:blue), s:part1b ]
let palette.normal.middle   = [ s:part3 ]

let palette.normal.error    = [ [ s:darkred, s:base02, 'bold' ] ]
let palette.normal.warning  = [ [ s:darkorange, s:base2 ] ]
let palette.normal.modified = [ [ s:darkorange, s:base2 ] ]

"let palette.insert.left     = [ [ s:darkred, s:brightorange ],  s:part1, s:part2 ]
"let palette.insert.right    = [ [ s:darkred, s:brightorange ], s:part1b ]
"let palette.insert.middle   = [ [ s:black, s:brightorange ] ]

let palette.replace.left     = [ [ s:darkred, s:brightorange ], [ color#Lighten(s:mediumorange, '0.8'), color#Darken(s:orange, '0.3') ] ]
let palette.replace.right    = [ [ s:darkred, s:brightorange ], [ s:darkred, s:mediumorange ] ]
let palette.replace.middle   = [ [ color#Darken(s:orange, '0.0'), color#Darken(s:orange, '0.6') ] ]
"let palette.replace.left    = [ s:mod1(s:green), s:part1, s:part2 ]
"let palette.replace.right   = [ s:mod2(s:green), s:part1b ]
"let palette.replace.middle = [ s:part3 ]

"let palette.visual.left     = [ s:mod1(s:red), s:mod1(s:mediumred) ]
"let palette.visual.right    = [ s:mod2(s:red), s:mod1(s:mediumred) ]
"let palette.visual.middle   = [ [ s:red, color#Darken(s:mediumred, '0.3') ] ]

let palette.select.left     = [ s:mod1(s:lightteal), s:mod1(s:teal) ]
let palette.select.right    = [ s:mod2(s:lightteal), s:mod1(s:teal) ]
let palette.select.middle   = [ [ s:lightteal, s:teal ] ]

let p_purple = [s:darkestpurple, s:white ]
let palette.terminal.left   = [ p_purple, s:mod1(s:mediumpurple) ]
let palette.terminal.right  = [ [s:darkestpurple, s:white ], s:mod2(s:mediumpurple) ]
let palette.terminal.middle = [ s:mod2(s:darkestpurple) ]
let palette.terminal.icon   = [ s:term ]

" Inactive
let palette.inactive.left   = [ hl_high, hl_med0, [ s:darkorange, s:base02 ]]
let palette.inactive.right  = [ s:part00b, s:part01b ]
let palette.inactive.middle = [ s:part02 ]

" }}}
" Tabline {{{
let palette.tabline.left   = [ [s:base2,  s:base00] , [ s:base2, s:base01 ] ]
let palette.tabline.right  = [ [s:brightblue, s:base01 ], [ s:base2, s:base01 ] ]
let palette.tabline.middle = [ [s:base2,  s:base00] ]

let palette.tabline.tabsel   = [ [ s:white, s:brightblue,   'bold' ] ]
"let palette.tabline.tabsel  = [ [ s:base2, s:base02,       'none' ] ]
let palette.tabline.tabtitle = [ [ s:white, s:brightorange, 'bold' ] ]

if exists('*lightline#colorscheme') && exists('g:lightline')     "                                    {{{
    "call lightline#init()

    "let s:dp.inactive.left   = [ hl_high, hl_med0, hi.low(s:darkorange)]
    "let s:dp.inactive.right  = [ s:dp.normal.right[1], s:part01b ]
    "let s:dp.inactive.middle = [ s:part02 ]
    "let palette.normal.left[0]  = deepcopy(s:dp.normal.left[0])
    "let palette.normal.left[1]  = deepcopy(s:dp.normal.right[0])
    "let palette.normal.right[0] = deepcopy(s:dp.normal.right[0])
    "let palette.insert = s:dp.insert
    call lightline#colorscheme#fill(palette)

    "for k in keys(palette.tabline)
        "let s:dp.tabline[k] = copy(palette.tabline[k])
        "echo 'let s:dp.tabline['.k.'] = ' . string(palette.tabline[k])
    "endfor
    "call extend(s:dp.tabline, copy(palette.tabline))
    "let s:dp.replace = deepcopy(palette.replace)
    let s:dp = lightline#colorscheme#default#palette
    let s:dp.tabline = deepcopy(palette.tabline)
    let s:dp.inactive = deepcopy(palette.inactive)
    let s:dp.replace = deepcopy(palette.replace)
    "call lightline#colorscheme()
    "call lightline#highlight()
end

