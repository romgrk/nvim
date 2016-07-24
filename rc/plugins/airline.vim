" !::exe [So | AirlineRefresh]

let airline_theme='jellybeans'
let airline_left_sep = ''
let airline_left_alt_sep = ''
let airline_right_sep = ''
let airline_right_alt_sep = ''
let airline_symbols = get(g:, 'airline_symbols', {})
let airline_symbols.branch = ''
let airline_symbols.readonly = ''
let airline_symbols.linenr = ''

let airline_exclude_preview = 0



let airline#extensions#tabline#buffer_idx_mode = 1

let airline#extensions#tabline#left_sep = ''
let airline#extensions#tabline#left_alt_sep = ''
let airline#extensions#tabline#right_sep = ''
let airline#extensions#tabline#right_alt_sep = ''



let airline#extensions#syntastic#enabled = 0

let airline#extensions#ycm#enabled = 1
let airline#extensions#ycm#error_symbol = ''
let airline#extensions#ycm#warning_symbol = ''


" * configure whether close button should be shown: >
let airline#extensions#tabline#show_close_button = 1
" * configure symbol used to represent close button >
let airline#extensions#tabline#close_symbol = ''


" * configure pattern to be ignored on BufAdd autocommand >
" fixes unneccessary redraw, when e.g. opening Gundo window
let airline#extensions#tabline#ignore_bufadd_pat =
        \ '\c\vgundo|undotree|vimfiler|tagbar|nerd_tree'
