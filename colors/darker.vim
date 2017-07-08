" !::exe [so % | call colorizer#ColorHighlight(1)]
if (&bg == 'light')
  set background=dark
end
let colors_name = 'darker'

" Definitions:                                                               {{{
"
" *Comment	any comment
"
" *Constant	any constant
"  String		a string constant 'this is a string'
"  Character	a character constant 'c', '\n'
"  Number		a number constant 234, 0xff
"  Boolean	    a boolean constant TRUE, false
"  Float		a floating point constant 2.3e10
"
" *Identifier	any variable name
"  Function	    function name (also methods for classes)
"
" *Statement	any statement
"  Conditional	if, then, else, endif, switch, etc.
"  Repeat		for, do, while, etc.
"  Label		case, default, etc.
"  Operator	'sizeof', '+', '*', etc.
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
" *Ignore		left blank, hidden  |hl-Ignore|
" *Error		any erroneous construct
"
" *Todo		anything that needs extra attention; mostly the
" 		keywords TODO FIXME and XXX
" }}}

" Colors                                                                     {{{

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

if exists('*RandomColor')
"call hi#('User1', '#202020', RandomColor(), '')
"call hi#('User2', '#202020', RandomColor(), '')
"call hi#('User3', '#202020', RandomColor(), '')
"call hi#('User4', '#202020', RandomColor(), '')
"call hi#('User5', '#202020', RandomColor(), '')
"call hi#('User6', '#202020', RandomColor(), '')
"call hi#('User7', '#202020', RandomColor(), '')
"call hi#('User8', '#202020', RandomColor(), '')
"call hi#('User9', '#202020', RandomColor(), '')
end

let log = {}
let log.Info    = '#599eff'
let log.Success = '#5faf00'
let log.Warning = '#ff8700'
let log.Debug   = '#F9FA00'
let log.Error   = '#ef2021'
let log.Special = '#9c5fff'
for key in keys(log)
    call hi#('Text' . key, log[key], '', '')
    call hi#('Bold' . key, log[key], '', 'bold')
    call hi#link(key,      'Text' . key)
endfor

" }}}
" Theme                                                                      {{{

let theme = {}
let theme.base                  = '#202020'
let theme.insensitive_base      = '#282828'

let theme.fg_text               = '#dddddc'
let theme.fg                    = '#e4e4e4'
let theme.fg_subtle             = '#d0d0d0'
let theme.fg_shaded             = '#a8a8a8'
let theme.fg_dark               = '#666666'
let theme.fg_widget             = '#4d5656'
let theme.fg_overlay            = '#f3f3f2'

let theme.bg                    = '#1a191b'
let theme.bg_subtle             = '#2c2c2d'
let theme.bg_verysubtle         = '#202020'
let theme.bg_widget             = '#202121'
let theme.bg_overlay            = '#454849'
let theme.bg_dark               = '#151515'

if get(g:,'high_contrast',0)
let theme.bg                    = '#0e0e0e'
let theme.bg_subtle             = '#181716'
let theme.bg_widget             = '#1b1c1c'
let theme.bg_overlay            = '#363939'
let theme.bg_dark               = '#090909'
end

let theme.fg_hl                 = '#a3a3a3'
let theme.bg_hl                 = '#404040'

let theme.hover                 = '#505050'

let theme.hl                    = '#599eff'

let theme.fg_selection          = '#f4fbfe'
let theme.bg_selection          = '#215d9c'
let theme.bg_selection_dark     = '#073655'
let theme.selection_dark        = ['#d0d6d8', '#073655']
let theme.selection             = ['#f4fbfe', '#215d9c']
let theme.selection_light       = ['#f4fbfe', '#599eff']

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

" }}}
" General UI                                                                 {{{

call hi#('Normal',          theme.fg,        theme.bg, '')
call hi#('Shaded',          theme.fg_shaded, '',       '')
call hi#('EndOfBuffer',     theme.base,      theme.bg, '')

call hi#('Cursor',          '', theme.base,  'reverse')
call hi#('SecondaryCursor', '', theme.bg_hl, 'none')

call hi#('CursorLine',   '',              theme.bg_verysubtle)
call hi#('CursorColumn', '',              theme.bg_widget)
call hi#('LineNr',       theme.fg_widget, theme.bg_widget, 'none')
call hi#('CursorLineNr', theme.hl,        theme.bg_widget, 'none')

call hi#('TermCursor',   '',                    theme.base,           '')
call hi#('TermCursorNC', '',                    theme.unfocused_base, '')

call hi#('Visual',       theme.selection)
call hi#('DarkVisual',   theme.selection_dark)
call hi#('LastVisual',   '',         theme.selection_dark[1], '')
call hi#('WildMenu',     theme.fg,   theme.selection[1])
call hi#('StatusLine',   [theme.fg,   '#4e4e48',               'NONE'])
call hi#('StatusLineNC', ['#1f1f1f',  '#4e4e48',               'NONE'])
call hi#('Separator',    ['#4c4c4c', 'none',                  ''])
call hi#('VertSplit',    [theme.bg,  theme.bg_widget,         ''])

call hi#('Pmenu',        ['#d1d1c1', theme.bg_overlay])
call hi#('PmenuSel',     [theme.fg,  theme.selection_dark[1]])
call hi#('Terminal',     [ s:white,  s:_black, 'bold' ] )
call hi#('PmenuSbar',    ['',        theme.bg_widget])
call hi#('PmenuThumb',   ['#666660', '#666660'])

" call hi#('Folded',       '#c9c9c0', theme.bg_subtle,      'none')
call hi#('Folded',      'NONE',    theme.bg_verysubtle,      'none')
call hi#('FoldColumn',  '#535D66', '#1f1f1f',            '')
call hi#('SignColumn',  '',        theme.insensitive_bg, '')
call hi#('ColorColumn', '',        theme.insensitive_bg, '')


call hi#('IndentGuidesEven', '#404040', '',        '')
call hi#('IndentGuidesOdd',  '',        '#2a2a2a', '')


call hi#('TabLine',      '#a8a89e',         '#4e4e48', 'none')
call hi#('TabLineFill',  '#4e4e48',         '#4e4e48', 'none')
" call hi#('BufferCurrent', theme.dark_subtle, theme.bg)
" call hi#('BufferActive',  '#c2c8ca',         '#808078')
" call hi#('Buffer',        '#a8a89e',         '#666660')
call hi#('TabLine',           ['#1f1f1f',        '#4e4e48', ''])
call hi#('TabLineFill',       ['#1f1f1f',        '#4e4e48', ''])
call hi#('TabLineSel',        theme.fg_subtle, theme.bg)
"call hi#('BufferCurrent',     ['#e4e4e4',        theme.bg,  ''])
"call hi#('BufferActive',      ['',               '#2c2c2d', ''])

call hi#('Buffer',           ['#1f1f1f',       '#4e4e48', ''])
call hi#('BufferCurrent',    [theme.hl,        theme.bg,  ''])
call hi#('BufferActive',     [theme.fg_subtle, '#2c2c2d', ''])
call hi#('BufferMod',        [s:yellow,        '#4e4e48', 'italic'])
call hi#('BufferCurrentMod', [s:yellow,        theme.bg,  'italic'])
call hi#('BufferActiveMod',  [s:yellow,        '#2c2c2d', 'italic'])

call hi#('Terminal',    [ s:white, s:_black, '', '' ] )

" }}}
" Search, Highlight, Conceal, Messages                                               {{{

hi! link Msg        TextSuccess
hi! link MoreMsg    TextInfo
hi! link WarningMsg TextWarning
hi! link ErrorMsg   TextError
hi! link ModeMsg    TextSpecial

call hi#('LabelOrange',     [ theme.base, colors.brightorange,  'bold' ] )
call hi#('LabelGreen',      [ theme.base, colors.mediumgreen,   'bold' ] )
call hi#('LabelBlue',       [ theme.base, colors.brightblue,    'bold' ] )
call hi#('LabelPurple',     [ theme.fg, colors.darkestpurple, 'bold' ] )

call hi#('Search',          'none',    '#3d3a00', 'none')
call hi#('IncSearch',       '#870000', '#f2ad00', 'none')
call hi#('IncSearchCursor', '',        '',        'reverse')

" hi! NonText gui=none guibg=none guifg=grey40
" hi! Conceal gui=none guibg=none guifg=grey20
call hi#('Conceal',         '#393939',       'none',    '')
call hi#('SpecialKey',      '#333333',       'none',    '')
call hi#('NonText',         theme.fg_subtle, '',        'bold')
call hi#('MatchParen',      '',              '#28485f', 'none')
call hi#('SpecialOpt',      '#868680',       '#32363a', '')


call hi#('AutoHL',          '',        theme.bg,  'none')
call hi#('Highlight',       '#000000', '#f0e930', 'none')

call hi#('Key',             '#799d6a', '', '')
call hi#('Question',        '#65C254', '', '',     'Green', '')
call hi#('Question2',       '#70b950', '', 'bold', 'Green', '')
call hi#('Todo',            '#3b84ea', 'none', 'bold')


call hi#('Directory',       '#ffff00', '',     'bold')
call hi#('Section',         '#dad085', '',     '')
call hi#('Title',           '#bab075', '',     'bold')
call hi#('Title2',          '#f0e930', '',     'bold')
call hi#('Title3',          '#F9FA00', 'none', 'bold')

call hi#('Bold',            '', '', 'bold')

" }}}
" Main Syntax                                                               {{{1

call hi#('Tag',                  '#80a0ff', '',        'underline')
call hi#('Link',                 '#80a0ff', '',        'underline')
call hi#('URL',                  '#80a0ff', '',        'underline')

call hi#('Comment',              '#777777', '',        '')
call hi#('BoldComment',          '#777777', '',        'bold')
call hi#('SpecialComment',       '#7597c6', '',        'bold')
call hi#('CommentLabel',         '#799d6a', '',        'bold')

call hi#('Global',               '#668799', '',        'bold')
call hi#('PreProc',              '#668799', '',        'none')
call hi#('Macro',                '#7597c6', '',        'bold')
call hi#('Define',               '#668799', '',        'bold')
call hi#('PreCondit',            '#7597c6', '',        'bold')
call hi#('Include',              '#7597c6', '',        'bold')

call hi#('Operator',             '#2d7cd0', '',        '')
call hi#('Repeat',               '#2d7cd0', '',        '')
call hi#('Keyword',              '#2d7cd0', '',        '')
call hi#('Statement',            '#2d7cd0', '',        'none')
call hi#('Label',                '#377edd', '',        '')

call hi#('Statement2',           '#397edf', '',        '')
call hi#('Statement3',           '#195ebf', '',        '')
call hi#('Keyword2',             '#2a40dd', '',        'bold')
call hi#('Keyword3',             '#7597c6', '',        '')

call hi#('Constant2',            '#ef6a4c', '',        'none')
call hi#('Constant',             '#dc322f', '',        'bold')
call hi#('Number',               '#ff5f00', '',        'none')
call hi#('Float',                '#ff5f00', '',        'none')
call hi#('Boolean',              '#eab700', '',        'bold')
call hi#('Enum',                 '#efaa2c', '',        '')

call hi#('Delimiter',            '#668799', '',        '')
call hi#('Delimiter2',           '#799033', '',        '')
call hi#('SpecialChar',          '#799d6a', '',        'bold')

call hi#('String1',              '#acd279', '',        'none')
call hi#('String2',              '#58F040', '',        'none')
call hi#('String3',              '#70d640', '',        'none')
call hi#('String4',              '#40cf00', '',        'none')
call hi#('String5',              '#5faf00', '',        'none')
call hi#('StringDelimiter',      '#799033', '',        'bold')

call hi#('Character',            '#5faf00', '',        'bold')

hi! link String String5

"call hi#('htmlString', '#0077aa', '', '', 'Blue', '')
"call hi#('htmlTagName','#990055', '', '', 'Blue', '')
"call hi#('htmlArg',    '#669900', '', '', 'Blue', '')

call hi#('Violet',               '#9c5fff', '',        '')
call hi#('Purple',               '#a755df', '',        '')
call hi#('Purple2',              '#a040af', '',        '')
call hi#('Purple3',              '#EB95ED', '',        '')

hi! link SpecialIdentifier  Violet

call hi#('Special',              '#a755df', '',        '')
call hi#('SpecialDelimiter',     '#a040af', '',        '')

call hi#('SpecialLight',         '#eb95ed', '',        '')
call hi#('SpecialDark',          '#5f00af', '',        'bold')


call hi#('Udentifier',           '#f0eeff', '',        '')
call hi#('Identifier',           '#ffe790', '',        '')
call hi#('Variable',             '#ffe790', '',        '')
call hi#('Argument',             '#dea537', '',        '')
call hi#('Var1',                 '#dea537', '',        '', 'Red', '')
call hi#('Var2',                 '#c59f6f', '',        '', 'Red', '')
call hi#('Var3',                 '#b58f5f', '',        '', 'Red', '')
call hi#('Var4',                 '#a57f4f', '',        '', 'Red', '')

" func name
call hi#('Function',             '#fad07a', '',        '')
call hi#('Method',               '#fad07a', '',        'bold')

call hi#('Symbol',               '#447799', '',        '')
call hi#('Control',              '#7597c6', '',        'bold')
call hi#('ControlN',             '#7597c6', '',        '')
call hi#('PredefinedIdentifier', '#7597c6', '',        '')
call hi#('Predefined',           '#c6b6fe', '',        'bold')

call hi#('StaticFunc',           '#ffb964', '',        '')
call hi#('Property1',            '#d5af7f', '',        '')
call hi#('Property2',            '#c59f6f', '',        '')
call hi#('Property3',            '#b58f5f', '',        '')
call hi#('Property4',            '#a57f4f', '',        '')
call hi#('Property5',            '#956f3f', '',        '')
hi def link Property Property1


call hi#('Type',                 '#ffb964', '',        'none')
call hi#('StorageClass',         '#d5af7f', '',        '')
call hi#('Class',                '#ffc311', '',        'none')
call hi#('Structure',            '#599eff', '',        '')
call hi#('Typedef',              '#ffaf70', '',        '')

call hi#('Regexp',               '#dd0093', '',        '')
call hi#('RegexpSpecial',        '#a40073', '',        '')
call hi#('RegexpDelimiter',      '#540063', '',        'bold')
call hi#('RegexpKey',            '#fefdfc', '#5f0041', '')

" }}}
" Diff                                                                       {{{

hi! clear DiffAdd
hi! clear DiffChange
hi! clear DiffText
hi! clear DiffDelete

call hi#('DiffAdd',      '',        '#0a2c06', '')
call hi#('DiffChange',   '',        '#0a2c06', '')
call hi#('DiffText',     '',        '#24761c', '')
call hi#('DiffDelete',   '',        '#3a191b', '')
call hi#('DiffModified', '#ddcf00', 'none',    '')
call hi#('DiffAdded',              '#38ad2c', 'none',    '')
" hi! link DiffAdded   DiffAdd
hi! link DiffRemoved DiffDelete

"                                                                            }}}
" Additionnal/Common groups                                         {{{1

call hi#('DbgCurrent',           '#DEEBFE', '#345FA8', '')
call hi#('DbgBreakPt',           '',        '#4F0037', '')

" Jumping around {{{

call hi#('PreciseJumpTarget',    '#B9ED67', '#405026', '' )
call hi#('EasyMotionTargetDefault', '#ff0000', '', 'bold')
hi!  link Sneak                  EasyMotionTargetDefault
hi!  link SneakPluginTarget      EasyMotionTargetDefault
hi!  link SneakStreakTarget      EasyMotionTargetDefault
hi!  link SneakStreakMask        EasyMotionShadeDefault
call hi#('SneakStreakMask', hi#('EasyMotionShadeDefault'))

" }}}

" Languages/Others                                                    {{{1

call hi#('vimSpecial',           '#799d6a', '',        '')

" Help                                                                      {{{2

hi! link helpURL           URL
hi! link helpHyperTextJump Purple

" PHP                                                                       {{{2

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

" Python                                                                    {{{2

hi! link pythonOperator Operator

" Ruby                                                                      {{{2

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


" Erlang                                                                    {{{2

hi! link erlangAtom rubySymbol
hi! link erlangBIF rubyPredefinedIdentifier
hi! link erlangFunction rubyPredefinedIdentifier
hi! link erlangDirective Statement
hi! link erlangNode Identifier

" CoffeeScript                                                              {{{2

hi! link coffeeRegExp rubyRegexp

" Lua & Moonscript'                                                         {{{2

hi! link luaOperator Conditional

hi! link moonObject     Type
hi! link moonSpecialOp  StringDelimiter
hi! link moonSpecialVar Identifier
hi! link moonObjAssign  StorageClass
hi! link moonObjAssign  StorageClass
hi! link moonConstant   Global

" Objective-C/Cocoa                                                         {{{2

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

" 1}}}

":call setreg('h', 'f''""yi'':call matchadd(''"'', ''\<"\>'')')
" g/^call hi#('\(\w\+\)',\s*/normal! @h

