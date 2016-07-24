" !::exe [so %]
" CtrlP ==========================================================================

let ctrlp_tilde_homedir = 1

"let ctrlp_user_command = 'ffind -d %s -t f'       " MacOSX/Linux
"let ctrlp_user_command = ['.git', 'cd %s && git ls-files']
"let ctrlp_user_command = 'ffind -D 2 -d %s -t f'       " MacOSX/Linux
let ctrlp_extensions   = ['tag', 'buffertag', 'quickfix', 'dir', 'mixed']
" , 'bookmarkdir', 'rtscript',

let ctrlp_funky_matchtype = 'path'
let ctrlp_funky_syntax_highlight = 1

" Mappings                                                                  {{{1
let ctrlp_prompt_mappings = {
\ 'PrtBS()':              ['<bs>'],
\ 'PrtDelete()':          ['<del>'],
\ 'PrtDeleteWord()':      ['<c-w>'],
\ 'PrtClear()':           ['<c-u>'],
\ 'PrtSelectMove("j")':   ['<a-j>', '<a-tab>', '<down>'],
\ 'PrtSelectMove("k")':   ['<a-k>', '<tab>', '<up>'],
\ 'PrtSelectMove("t")':   ['<c-a>', '<kHome>'],
\ 'PrtSelectMove("b")':   ['<c-e>', '<kEnd>'],
\ 'PrtSelectMove("u")':   ['<a-u>', '<PageUp>', '<kPageUp>'],
\ 'PrtSelectMove("d")':   ['<a-d>', '<PageDown>', '<kPageDown>'],
\ 'PrtHistory(-1)':       ['<c-n>'],
\ 'PrtHistory(1)':        ['<c-p>'],
\ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>'],
\ 'AcceptSelection("h")': ['<c-\>'],
\ 'AcceptSelection("t")': ['<c-t>', '<a-cr>'],
\ 'AcceptSelection("v")': ['<c-v>', '<c-cr>', '<RightMouse>'],
\ 'ToggleFocus()':        ['<a-''>'],
\ 'ToggleRegex()':        ['<a-\>', '<a-r>'],
\ 'ToggleByFname()':      ['<a-d>', '<a-m>'],
\ 'ToggleType(1)':        ['<a-[>', '<c-up>'],
\ 'ToggleType(-1)':       ['<a-]>', '<c-down>'],
\ 'PrtExpandDir()':       ['<A-e>', '<a-;>'],
\ 'PrtInsert("c")':       ['<MiddleMouse>', '<insert>'],
\ 'PrtInsert()':          ['<c-\>'],
\ 'PrtCurStart()':        ['<c-a>'],
\ 'PrtCurEnd()':          ['<c-e>'],
\ 'PrtCurLeft()':         ['<c-b>', '<a-h>', '<left>'],
\ 'PrtCurRight()':        ['<c-f>', '<a-l>', '<right>'],
\ 'PrtClearCache()':      ['<F5>'],
\ 'PrtDeleteEnt()':       ['<F7>'],
\ 'CreateNewFile()':      ['<c-a-n>'],
\ 'MarkToOpen()':         ['<c-z>', '<a-space>'],
\ 'OpenMulti()':          ['<c-o>', '<a-o>'],
\ 'PrtExit()':            ['<esc>', '<c-c>', '<c-g>'],
\ }

" 1}}}
