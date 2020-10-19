" !::exe [so %]
let multi_cursor_use_default_mapping   = 0
let multi_cursor_exit_from_visual_mode = 1
let multi_cursor_exit_from_insert_mode = 0

let multi_cursor_start_key      = '<A-m>'
let multi_cursor_start_word_key = '<A-M>'
let multi_cursor_prev_key       = '<C-p>'
let multi_cursor_next_key       = '<C-n>'
let multi_cursor_skip_key       = '<C-s>'
let multi_cursor_quit_key       = 'q'

let multi_cursor_normal_maps =
\ {'!':1, '@':1, '=':1, 'r':1,
\  'y':1, 'c':1, 's':1,
\  '\':1, 'd':1, 'g':1,
\  '"':1, '`':1, '''':1,
\  'f':1, 'F':1, 't':1, 'T':1,
\}
"\  'm':1, '<':1, '>':1,
"\  '[':1, ']':1,
let multi_cursor_visual_maps = {
\ 'i':1, 'a':1,
\ 'f':1, 'F':1, 't':1, 'T':1,
\}
let multi_cursor_insert_maps = {
\ "\<A-i>": 1
\}


" function! Multiple_cursors_before()
"   if exists(':NeoCompleteLock')==2
"     exe 'NeoCompleteLock'
"   endif
" endfunction
"
" function! Multiple_cursors_after()
"   if exists(':NeoCompleteUnlock')==2
"     exe 'NeoCompleteUnlock'
"   endif
" endfunction
