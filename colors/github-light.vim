" !::exe [so % | call colorizer#ColorHighlight(1)]
"set background=dark
if &bg != 'light'
  set background=light
end
let colors_name = 'github-light'

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

let log = {}
let log.Info    = '#599eff'
let log.Success = '#5faf00'
let log.Warning = '#ff8700'
let log.Debug   = '#f0c904'
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

let theme.fg_text               = '#24292e'
let theme.fg                    = '#24292e'
let theme.fg_subtle             = '#c0c0c0'
let theme.fg_verysubtle         = '#e0e0e0'
let theme.fg_shaded             = '#24292e'
let theme.fg_dark               = '#24292e'
let theme.fg_widget             = '#efe3d5'
let theme.fg_overlay            = '#24292e'

let theme.bg                    = '#ffffff'
let theme.bg_subtle             = '#f0f0f0'
let theme.bg_verysubtle         = '#f5f5f5'
let theme.bg_widget             = '#ffffff'
let theme.bg_overlay            = '#e9e9e9'
let theme.bg_dark               = '#d0d0d0'

let theme.fg_hl                 = '#a3a3a3'
let theme.bg_hl                 = '#404040'

let theme.hover                 = '#505050'

let theme.hl                    = '#599eff'

let theme.fg_selection          = 'none'
let theme.bg_selection          = '#d7d4ef'
let theme.bg_selection_dark     = '#d7d4ef'
let theme.bg_selection_light    = '#DEEBFE'
let theme.selection_dark        = ['none', '#d7d4ef']
let theme.selection             = ['none', '#d7d4ef']
let theme.selection_light       = ['none', '#d7d4ef']

"let theme.insensitive          = '#515a5a'
let theme.insensitive_bg        = '#ffffff'
let theme.insensitive_fg        = '#949796'
let theme.unfocused_fg          = '#949796'
let theme.unfocused_text        = '#eeeeec'
let theme.unfocused_bg          = '#393f3f'
let theme.unfocused_base        = '#2c2c2c'

let theme.border                = '#1c1f1f'
let theme.unfocused_border      = '#1f2222'

let theme.folded_bg             = '#252525'
let theme.folded_fg             = '#999999'

" }}}
" General UI                                                                 {{{

call hi#('Normal',           theme.fg,        theme.bg, '')
call hi#('Shaded',           theme.fg_shaded, '',       '')
call hi#('EndOfBuffer',      theme.fg_widget, theme.bg, '')

call hi#('Cursor',           '', theme.base,  'reverse')
call hi#('SecondaryCursor',  '', theme.bg_hl, 'none')

call hi#('CursorLine',       '',              theme.bg_verysubtle)
call hi#('CursorColumn',     '',              theme.bg_verysubtle)
call hi#('CursorLineNr',     theme.hl,        theme.bg_verysubtle, 'none')
call hi#('LineNr',           theme.fg_widget, theme.bg_widget, 'none')

call hi#('TermCursor',       '',                    theme.base,           '')
call hi#('TermCursorNC',     '',                    theme.unfocused_base, '')

call hi#('Visual',           theme.selection)
call hi#('LastVisual',       '',              theme.bg_selection_dark, '')
call hi#('WildMenu',         theme.fg,        theme.bg_selection)
call hi#('StatusLine',       theme.fg,        theme.bg_dark,           'NONE')
call hi#('StatusLineNC',     '#1f1f1f',       theme.bg_dark,           'NONE')
call hi#('Separator',        '#4c4c4c',       'none',                  '')
call hi#('VertSplit',        theme.fg_subtle, theme.bg_widget,         '')

call hi#('Pmenu',            theme.fg, theme.bg_overlay)
call hi#('PmenuSel',         theme.fg, theme.bg_selection)
call hi#('PmenuSbar',        '',       theme.bg_dark)
call hi#('PmenuThumb',       '#666660', '#666660')
call hi#('Terminal',         s:white,  s:_black, 'bold'  )

call hi#('Folded',           'none',          theme.bg_verysubtle,  'none')
call hi#('FoldColumn',       theme.fg_subtle, theme.bg_widget,      '')
call hi#('SignColumn',       '',              theme.insensitive_bg, '')
call hi#('ColorColumn',      '',              theme.insensitive_bg, '')


call hi#('IndentGuidesEven', '#404040', '',        '')
call hi#('IndentGuidesOdd',  '',        '#2a2a2a', '')


call hi#('TabLine',          '#a8a89e',        theme.bg_dark, 'none')
call hi#('TabLineFill',      '#4e4e48',        theme.bg_dark, 'none')
call hi#('TabLine',          '#1f1f1f',        theme.bg_dark, '')
call hi#('TabLineFill',      '#1f1f1f',        theme.bg_dark, '')
call hi#('TabLineSel',       theme.fg_subtle, theme.bg_dark)

call hi#('Buffer',           theme.fg,        theme.bg_dark, '')
call hi#('BufferCurrent',    theme.hl,        theme.bg,      '')
call hi#('BufferActive',     theme.fg_subtle, theme.bg_dark, '')
call hi#('BufferMod',        s:brightyellow,  theme.bg_dark, 'italic,bold')
call hi#('BufferCurrentMod', s:yellow,        theme.bg,      'italic')
call hi#('BufferActiveMod',  s:yellow,        theme.bg_dark, 'italic')

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

call hi#('Search',          '#000000', '#ffff00', 'none')
call hi#('IncSearch',       '#000000', '#fb8f33', 'none')
call hi#('IncSearchCursor', '',        '',        'reverse')

" hi! NonText gui=none guibg=none guifg=grey40
" hi! Conceal gui=none guibg=none guifg=grey20
call hi#('Conceal',         '#393939',       'none',    '')
call hi#('SpecialKey',      '#333333',       'none',    '')
call hi#('NonText',         theme.fg_subtle, '',        'bold')
call hi#('MatchParen',      '',              '#28485f', 'none')
call hi#('SpecialOpt',      '#868680',       '#32363a', '')


call hi#('AutoHL',          '',     theme.bg,  'none')
call hi#('Highlight',       'none', theme.bg_selection_light, 'none')

call hi#('Key',             '#799d6a', '', '')
call hi#('Question',        '#65C254', '', '',     'Green', '')
call hi#('Question2',       '#70b950', '', 'bold', 'Green', '')
call hi#('Todo',            '#3b84ea', 'none', 'bold')

call hi#('Directory',       '#bab075', '',     'bold')
call hi#('Section',         '#bab075', '',     '')
call hi#('Title',           '#bab075', '',     'bold')
call hi#('Title2',          '#f0e930', '',     'bold')
call hi#('Title3',          '#F9FA00', 'none', 'bold')

call hi#('Bold',            '', '', 'bold')

" }}}
" Main Syntax                                                               {{{1

call hi#('Tag',                  '#80a0ff', '',        'underline')
call hi#('Link',                 '#80a0ff', '',        'underline')
call hi#('URL',                  '#80a0ff', '',        'underline')

call hi#('Comment',              '#6a737d', '',        '')
call hi#('BoldComment',          '#6a737d', '',        'bold')
call hi#('SpecialComment',       '#7597c6', '',        'bold')
call hi#('CommentLabel',         '#799d6a', '',        'bold')

call hi#('Global',               '#005cc5', '',        'none')
call hi#('PreProc',              '#005cc5', '',        'none')
call hi#('Macro',                '#005cc5', '',        'bold')
call hi#('Define',               '#005cc5', '',        'bold')
call hi#('PreCondit',            '#005cc5', '',        'bold')
call hi#('Include',              '#005cc5', '',        'bold')

call hi#('Repeat',               '#d73a49', '',        '')
call hi#('Keyword',              '#d73a49', '',        '')
call hi#('Statement',            '#d73a49', '',        'none')
call hi#('Label',                '#d73a49', '',        '')

call hi#('Operator',             '#d73a49', '',        '')
"call hi#('Operator',             '#94afff', '',        '')

call hi#('Constant',             '#005cc5', '',        'none')
call hi#('Number',               '#005cc5', '',        'none')
call hi#('Float',                '#005cc5', '',        'none')
call hi#('Boolean',              '#005cc5', '',        'none')
call hi#('Enum',                 '#005cc5', '',        'none')

call hi#('Delimiter',            '#668799', '',        'none')
call hi#('Delimiter2',           '#799033', '',        'none')
call hi#('SpecialChar',          '#799d6a', '',        'bold')

call hi#('String',               '#032fb2', '',        'none')
call hi#('StringDelimiter',      '#032f62', '',        'bold')

call hi#('Character',            '#238fff', '',        'bold')


call hi#('SpecialIdentifier',    '#9c5fff', '',        'none')

call hi#('Special',              '#a755df', '',        'none')
call hi#('SpecialDelimiter',     '#a040af', '',        'none')


call hi#('Identifier',           theme.fg,  '',        'none')
call hi#('Variable',             '#ffe790', '',        'none')
call hi#('Argument',             '#dea537', '',        'none')

" func name
call hi#('Function',             '#6f42c1', '',        'none')
call hi#('Method',               '#6f42c1', '',        'bold')

call hi#('Symbol',               '#005cc5', '',        'none')
call hi#('Control',              '#005cc5', '',        'none')
call hi#('PredefinedIdentifier', '#005cc5', '',        'none')
call hi#('Predefined',           '#005cc5', '',        'none')

call hi#('StaticFunc',           '#ffb964', '',        'none')
call hi#('Property',             '#dea537', '',        'none')


call hi#('Type',                 '#d73a49', '',        'none')
call hi#('StorageClass',         '#d73a49', '',        'none')
call hi#('Class',                '#d73a49', '',        'none')
call hi#('Structure',            '#d73a49', '',        'none')
call hi#('Typedef',              '#d73a49', '',        'none')

call hi#('Regexp',               '#dd0093', '',        'none')
call hi#('RegexpSpecial',        '#a40073', '',        'none')
call hi#('RegexpDelimiter',      '#540063', '',        'bold')
call hi#('RegexpKey',            '#5f0041', '',        'bold')

" }}}
" Diff                                                                       {{{

hi! clear DiffAdd
hi! clear DiffChange
hi! clear DiffText
hi! clear DiffDelete

call hi#('DiffAdd',      '',              '#e6ffed', '')
call hi#('DiffChange',   '',              '#e6ffed', '')
call hi#('DiffText',     '',              '#acf2bd', '')
call hi#('DiffDelete',   '',              '#ffeef0', '')
call hi#('DiffModified', theme.fg_subtle, '#DEEBFE', '')
call hi#('DiffAdded',    theme.fg_subtle, '#cdffd8', '')
call hi#('DiffRemoved',  theme.fg_subtle, '#ffdce0', '')

"                                                                            }}}
" Additionnal/Common groups                                         {{{1

call hi#('DbgCurrent',           '#DEEBFE', '#345FA8', '')
call hi#('DbgBreakPt',           '',        '#4F0037', '')

" Jumping around {{{

call hi#('PreciseJumpTarget',       '#B9ED67', '#405026', '' )
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