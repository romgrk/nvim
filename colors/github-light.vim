" !::exe [so % | call colorizer#ColorHighlight(1)]

if &bg != 'light'
  set background=light
end
let colors_name = 'github-light'

" Colors                                                                     {{{

let s:black     = '#000000'
let s:white      = '#f4fbfe'

let s:darkyellow      = '#c59000'

let s:gh_grey   = '#8f9aa9'
let s:gh_red    = '#DB524E'
let s:gh_orange = '#e98642'
let s:gh_blue0  = '#0d33a5'
let s:gh_blue1  = '#2076d8'
let s:gh_purple = '#6f42c1'
let s:gh_url    = '#80a0ff'

let s:gh_search      = '#FFEEB9'
let s:gh_search_dark = '#EDB34D'


let s:text_colors = {
\ 'Info':    '#599eff',
\ 'Success': '#5faf00',
\ 'Warning': '#ff8700',
\ 'Debug':   '#f0c904',
\ 'Error':   '#ef2021',
\ 'Special': '#9c5fff',
\}
for key in keys(s:text_colors)
  call hi#('Text' . key, s:text_colors[key], '', '')
  call hi#('Bold' . key, s:text_colors[key], '', 'bold')
endfor

" }}}
" Theme                                                                      {{{

let theme = {}
let theme.base                  = '#202020'
let theme.insensitive_base      = '#282828'

let theme.fg                    = '#24292e'
let theme.fg_light              = '#454B53'
let theme.fg_lighter            = '#666D74'
let theme.fg_subtle             = '#c0c0c0'
let theme.fg_dark               = '#24292e'
let theme.fg_widget             = '#cad0d3'
let theme.fg_conceal            = '#e2e8eb'
let theme.fg_overlay            = '#f0f0f0'
let theme.fg_widget_dark        = '#8f9aa9'
let theme.fg_widget_alt         = '#ffffff'
let theme.fg_widget_alt_nc      = '#333333'


let theme.bg                    = '#ffffff'
let theme.bg_subtle             = '#f0f0f0'
let theme.bg_popover            = '#e0e0e0'
let theme.bg_verysubtle         = '#f5f5f5'
let theme.bg_widget             = '#ffffff'
let theme.bg_overlay            = '#121212'
let theme.bg_dark               = '#d0d0d0'
let theme.bg_light              = '#e5e7e9'
let theme.bg_widget_alt         = '#4c4c4c'
let theme.bg_widget_alt_nc      = '#aaaaaa'

let theme.fg_hl                 = '#a3a3a3'
let theme.bg_hl                 = '#404040'

let theme.hover                 = '#505050'

let theme.hl                    = '#599eff'
let theme.hl_fg                 = '#ffffff'

let theme.fg_selection          = 'none'
let theme.bg_selection          = '#d7d4ef'
let theme.bg_selection_dark     = '#d7d4ef'
let theme.bg_selection_light    = '#deebfe'
let theme.bg_selection_very_light = '#e9f2ff'
let theme.selection_dark        = ['none', '#d7d4ef']
let theme.selection             = ['none', '#d7d4ef']
let theme.selection_light       = ['none', '#d7d4ef']

"let theme.insensitive          = '#515a5a'
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

call hi#('Normal',           theme.fg,        theme.bg)
call hi#('EndOfBuffer',      theme.fg_widget, theme.bg)
call hi#('NormalPopup',      theme.fg,        theme.bg_subtle)
call hi#('NormalPopover',    theme.fg,        theme.bg_popover)

call hi#('Cursor',           '', theme.base,  'reverse')
call hi#('SecondaryCursor',  '', theme.bg_hl, 'none')

call hi#('CursorLine',       '',              theme.bg_verysubtle)
call hi#('CursorColumn',     '',              theme.bg_verysubtle)
call hi#('CursorLineNr',     theme.hl,        theme.bg_verysubtle, 'none')
call hi#('LineNr',           theme.fg_widget, theme.bg_widget, 'none')

call hi#('TermCursor',       theme.bg,        'none',            'reverse')
call hi#('TermCursorNC',     theme.fg_hl,     'none',            'reverse')
call hi#('TermNormal',       theme.bg,        theme.base,    '')
call hi#link('TermNormalNC', 'TermNormal')


call hi#('Visual',         theme.selection)
call hi#('LastVisual',     '',                  theme.bg_selection_dark, '')
call hi#('WildMenu',       theme.fg,            theme.bg_selection)
call hi#('StatusLine',     theme.fg_light,      theme.bg_dark,          'none')
call hi#('StatusLineNC',   theme.fg_lighter,    theme.bg_dark,          'none')
call hi#('StatusLinePart', theme.fg_widget_alt, theme.bg_widget_alt,     'bold')
call hi#('StatusLinePartNC', theme.fg_widget_alt_nc, theme.bg_widget_alt_nc,     'bold')
call hi#('Separator',      '#4c4c4c',           'none',                  '')
call hi#('VertSplit',      theme.fg_subtle,     theme.bg_widget,         'none')

call hi#('Pmenu',            theme.fg_overlay, theme.bg_overlay)
call hi#('PmenuSel',         theme.hl_fg,      theme.hl)
call hi#('PmenuSbar',        '',       theme.bg_dark)
call hi#('PmenuThumb',       '#666660', '#666660')

if exists('&pumblend')
  set pumblend=20
end

call hi#('Terminal',         s:white,  s:black, '')


call hi#('Folded',           'none',          theme.bg_verysubtle,  'none')
call hi#('FoldColumn',       theme.fg_subtle, theme.bg_widget,      '')
call hi#('SignColumn',       '',              theme.bg_widget, '')
call hi#('ColorColumn',      '',              theme.bg_widget, '')


call hi#('IndentGuidesEven', theme.fg_widget, '', '')
call hi#('IndentGuidesOdd',  theme.fg_widget, '', '')


call hi#('TabLine',          '#a8a89e',        theme.bg_dark, 'none')
call hi#('TabLineFill',      '#4e4e48',        theme.bg_dark, 'none')
call hi#('TabLine',          '#1f1f1f',        theme.bg_dark, '')
call hi#('TabLineFill',      '#1f1f1f',        theme.bg_dark, '')
call hi#('TabLineSel',       theme.fg_subtle,  theme.bg_dark)

call hi#('Buffer',            theme.fg,         theme.bg_dark, 'none')
call hi#('BufferCurrent',     theme.hl,         theme.bg,      'none')
call hi#('BufferActive',      theme.hl,         theme.bg_dark, 'none')
call hi#('BufferMod',         s:darkyellow,     theme.bg_dark, 'bold')
call hi#('BufferCurrentMod',  s:darkyellow,     theme.bg,      'bold')
call hi#('BufferActiveMod',   s:darkyellow,     theme.bg_dark, 'bold')
call hi#('BufferSign',        theme.fg_widget_dark, theme.bg_dark, 'none')
call hi#('BufferSignCurrent', theme.fg_widget_dark, theme.bg,      'none')

" }}}
" Search, Highlight, Conceal, Messages                                               {{{

call hi#('Search',          'none', s:gh_search,      'none')
call hi#('IncSearch',       'none', s:gh_search_dark, 'none')
call hi#('IncSearchCursor', '',     '',               'reverse')

call hi#('Conceal',         theme.fg_conceal, 'none',    '')
call hi#('SpecialKey',      '#333333',        'none',    '')
call hi#('NonText',         theme.fg_subtle,  '',        'bold')
call hi#('MatchParen',      '',               '#BCE3FF', 'none')
call hi#('SpecialOpt',      '#868680',        '#32363a', '')
call hi#('Whitespace',      '#8f9aa9',        '',        '')



call hi#('AutoHL',          '',     theme.bg,  'none')
call hi#('Highlight',       'none', theme.bg_selection_light,       'none')
call hi#('HighlightSubtle', 'none', theme.bg_selection_very_light, 'none')

call hi#('Key',             '#799d6a', '', '')
call hi#('Question',        '#65C254', '', '',     'Green', '')
call hi#('Todo',            '#3b84ea', 'none', 'bold')

call hi#('Directory',       theme.fg, '',     'bold')
call hi#('Section',         '#3365CE', '',     'bold')
" call hi#('Directory',       '#3365CE', '',     'bold')
" call hi#('Title',           '#3365CE', '',     'bold')
hi! link Title Special

call hi#('Bold', '', '', 'bold')

hi! link Msg        TextSuccess
hi! link MoreMsg    TextInfo
hi! link WarningMsg TextWarning
hi! link ErrorMsg   TextError
hi! link ModeMsg    TextSpecial


" }}}
" Main Syntax                                                               {{{1

call hi#('Tag',                  s:gh_url, '',        'underline')
call hi#('Link',                 s:gh_url, '',        'underline')
call hi#('URL',                  s:gh_url, '',        'underline')

call hi#('Comment',              s:gh_grey, '',        '')
call hi#('CommentBold',          s:gh_grey, '',        'bold')
call hi#('SpecialComment',       '#7597c6', '',        'bold')
hi! link CommentLabel   CommentBold
hi! link CommentSection CommentBold
hi! link Noise Comment

call hi#('Global',               s:gh_blue1, '',        'none')
call hi#('PreProc',              s:gh_blue1, '',        'none')
call hi#('Macro',                s:gh_blue1, '',        'bold')
call hi#('Define',               s:gh_blue1, '',        'bold')
call hi#('PreCondit',            s:gh_blue1, '',        'bold')
call hi#('Include',              s:gh_blue1, '',        'bold')

call hi#('Repeat',               s:gh_red, '',        '')
call hi#('Keyword',              s:gh_red, '',        '')
call hi#('Statement',            s:gh_red, '',        'none')
call hi#('Label',                s:gh_red, '',        '')

call hi#('Operator',             s:gh_blue1, '',        '')
"call hi#('Operator',             '#94afff', '',        '')

call hi#('Constant',             s:gh_blue1, '',        'none')
call hi#('Number',               s:gh_blue1, '',        'none')
call hi#('Float',                s:gh_blue1, '',        'none')
call hi#('Boolean',              s:gh_blue1, '',        'none')
call hi#('Enum',                 s:gh_blue1, '',        'none')

call hi#('Delimiter',            '#668799', '',        'none')
call hi#('DelimiterAlt',         '#799033', '',        'none')
call hi#('SpecialChar',          '#799d6a', '',        'bold')

call hi#('String',               s:gh_blue0, '',        'none')
call hi#('StringDelimiter',      '#032f62', '',        'bold')

call hi#('Character',            '#238fff', '',        'bold')


call hi#('SpecialIdentifier',    '#9c5fff', '',        'none')

call hi#('Special',              '#a755df', '',        'none')
call hi#('SpecialBold',          '#a755df', '',        'bold')
call hi#('SpecialDelimiter',     '#a040af', '',        'none')


call hi#('Identifier',           theme.fg,  '',        'none')
call hi#('Variable',             '#ffe790', '',        'none')
call hi#('Argument',             theme.fg,  '',        'none')

call hi#('Function',             s:gh_purple, '',        'none')
call hi#('Method',               s:gh_purple, '',        'bold')

call hi#('Symbol',               s:gh_blue1, '',        'none')
call hi#('Control',              s:gh_blue1, '',        'none')
call hi#('PredefinedIdentifier', s:gh_blue1, '',        'none')
call hi#('Predefined',           s:gh_blue1, '',        'none')

call hi#('StaticFunc',           '#ffb964', '',        'none')
call hi#('Property',             s:gh_orange, '',        'none')


call hi#('Type',                 s:gh_red, '',        'none')
call hi#('StorageClass',         s:gh_red, '',        'none')
call hi#('Class',                s:gh_red, '',        'none')
call hi#('Structure',            s:gh_red, '',        'none')
call hi#('Typedef',              s:gh_red, '',        'none')

call hi#('Regexp',               '#dd0093', 'none',        'none')
call hi#('RegexpSpecial',        '#a40073', 'none',        'none')
call hi#('RegexpDelimiter',      '#540063', 'none',        'bold')
call hi#('RegexpKey',            '#5f0041', 'none',        'bold')

" }}}
" Diff                                                                       {{{

let s:gh_info_bg0 = '#D8EEFD'
let s:gh_info_bg1 = '#E6F3FE'


call hi#('diffLine',    s:gh_grey, s:gh_info_bg1, 'none')
call hi#('diffSubName', s:gh_grey, s:gh_info_bg1, 'none')

hi! clear DiffAdd
hi! clear DiffChange
hi! clear DiffText
hi! clear DiffDelete

call hi#('DiffAdd',      '',             '#e6ffed')
call hi#('DiffChange',   '',             '#e6ffed')
call hi#('DiffText',     '',             '#acf2bd')
call hi#('DiffDelete',   '',             '#ffeef0')

call hi#('DiffAdded',    theme.fg_light, '#cdffd8')
call hi#('DiffModified', theme.fg_light, '#deebfe')
call hi#('DiffRemoved',  theme.fg_light, '#ffdce0')

call hi#('DiffAddedSubtle',    '#1cad3c', '#cdffd8')
call hi#('DiffModifiedSubtle', '#3c71be', '#deebfe')
call hi#('DiffRemovedSubtle',  '#c03545', '#ffdce0')

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
