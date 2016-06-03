" File: highlight.vim
" Author: romgrk
" Date: 16 Oct 2015
" !::exe [so %]

exe 'augroup ' . expand('<sfile>:t') | au!
autocmd ColorScheme * exe 'source ' . expand('<sfile>:p')
exe 'augroup END'

" General & Plugins                                                          {{{

call hi#("Highlight", hi#("Search"))

let bg_normal = hi#bg('Normal')
if bg_normal[0] != '#'
    let bg_normal = '#282828'
end

call hi#("AutoHL", "none", color#Lighten(bg_normal, '0.4'), "none")
"call hi#("Search", hi#("CursorLine"))

hi! NonText gui=none guibg=none guifg=grey40
hi! Conceal gui=none guibg=none guifg=grey20

hi! link LeadingSP Conceal

hi! link Noise                   Comment

call hi#('EasyMotionTargetDefault', '#ff0000', '', 'bold')
hi!  link SneakPluginTarget      EasyMotionTargetDefault
hi!  link SneakStreakTarget      EasyMotionTargetDefault
hi!  link SneakStreakMask        EasyMotionShadeDefault
call hi#('SneakStreakMask', hi#('EasyMotionShadeDefault'))

hi! link CtrlPTagKind            Delimiter

hi! link TagbarScope             Class
hi! link TagbarFoldIcon          Comment

hi! link MatchParen          b_brightteal
hi! link hiPairs_matchPair   b_brightteal
hi! link hiPairs_unmatchPair b_brightteal


call hi#('multiple_cursors_cursor', colors.darkred, colors.pink,     'bold')
"hi! link multiple_cursors_visual Visual
"hi! link multiple_cursors_visual AutoHL
hi! link multiple_cursors_visual Visual


hi! link helpURL URL

" }}}
" Tabline & Statusline                                                       {{{
hi! uc_red    gui=undercurl guisp=#d03955

let s:groups = {}
let s:groups['MediumGreen']  = ['#005f00', '#afdf00']
let s:groups['MediumOrange'] = ['#870000', '#ffb700']
let s:groups['SessionTab']   = ['#ffb700', colors.base02, 'none' ]
for k in keys(s:groups)
    call hi#(k,                            s:groups[k])
endfor     "                                                                 }}}
" Tags                                                                       {{{

fu! s:highlightTags ()
    let bg = hi#bg('Normal')
    if (bg[0] != '#') | return | end
    let hl_bg = color#Lighten(bg, 35)

    call hi#('cFunctionTag',         hi#fg('Function'),   hl_bg, 'none')
    call hi#('cTypeTag',             hi#fg('Type'),   hl_bg, 'none')
endfunc
call s:highlightTags()

" 15. Highlighting tags					*tag-highlight*
" =====================================================
"
" If you want to highlight all the tags in your file, you can use the following
" mappings.
"
"     <F11>	-- Generate tags.vim file, and highlight tags.
"     <F12>	-- Just highlight tags based on existing tags.vim file.
"   :map <F11>  :sp tags<CR>:%s/^\([^	:]*:\)\=\([^	]*\).*/syntax keyword Tag \2/<CR>:wq! tags.vim<CR>/^<CR><F12>
"   :map <F12>  :so tags.vim<CR>
"
" WARNING: The longer the tags file, the slower this will be, and the more
" memory Vim will consume.
"
" Only highlighting typedefs, unions and structs can be done too.  For this you
"  must use Exuberant ctags found at	http://ctags.sf.net.
" Put these lines in your Makefile:
"
" # Make a highlight file for types.  Requires Exuberant ctags and awk
" types: types.vim
" types.vim: *.[ch]
"     ctags --c-kinds=gstu -o- *.[ch] YXXY\
"         awk 'BEGIN{printf("syntax keyword Type\t")}\
"             {printf("%s ", $$1)}END{print ""}' > $@
"
" And put these lines in your .vimrc:
"    " load the types.vim highlighting file, if it exists
"    autocmd BufRead,BufNewFile *.[ch] let fname = expand('<afile>:p:h') . '/types.vim'
"    autocmd BufRead,BufNewFile *.[ch] if filereadable(fname)
"    autocmd BufRead,BufNewFile *.[ch]   exe 'so ' . fname
"    autocmd BufRead,BufNewFile *.[ch] endif


"                                                                            }}}
" GitGutter                                                                  {{{

let s:bg = hi#bg('LineNr')
if(s:bg[0] == '#')
    call hi#('GitGutterAdd',          hi#fg('Success'), s:bg, '')
    call hi#('GitGutterDelete',       hi#fg('Error'),   s:bg, '')
    call hi#('GitGutterChange',       hi#fg('Info'), s:bg, '')
    call hi#('GitGutterChangeDelete', hi#fg('Warning'), s:bg, '')
end

"                                                                            }}}
" Notes, notation, etc.                                                      {{{

hi! link vifmNotation  OldSpecial

hi! link notesXXX            ErrorMsg
hi! link notesDoneMarker     TextSuccess
hi! link notesTODO           TextWarning

" }}}
" JS, Coffee & JSON                                                                  {{{

"hi! link javascriptIdentifierName   Identifier
hi! link jsonQuote               Delimiter
hi! link jsonKeyword             Keyword
hi! link jsonKeywordMatch        Comment

hi! link coffeeObject       Type
hi! link coffeeObjAssign    StorageClass
hi! link coffeeDotAccess    Function
hi! link coffeeGlobal       Constant
hi! link coffeeBracket      Delimiter
hi! link coffeeParen        Delimiter
hi! link coffeeSpecialOp    StringDelimiter
hi! link coffeeSpecialVar   Identifier
hi! link coffeeSpecialIdent Variable
"                                                                            }}}
" Shell                                                                      {{{
hi! link zshHereDoc Comment
hi! link zshKSHFunction Function
hi! link zshVariableDef Var1
hi! link zshDeref Var1
hi! link zshTypes StorageClass
"                                                                            }}}
" }}}
