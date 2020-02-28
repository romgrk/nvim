
" Time in milliseconds (default 250)
let Illuminate_delay = 250


" You can define which highlight groups you want the illuminating to apply to. This can be done with a dict
" mapping a filetype to a list of highlight-groups in your vimrc such as:

let Illuminate_ftHighlightGroups = {
\ 'vim-disabled': ['vimVar', 'vimString', 'vimLineComment', 'vimFuncName', 'vimFunction', 'vimUserFunc', 'vimFunc']
\ }

" illuminate can also be disabled for various filetypes using the following:

let Illuminate_ftblacklist = ['nerdtree', 'terminal', 'cocactions']

" Lastly, by default the highlighting will be done with the hl-group CursorLine since that is in
" my opinion the nicest. It can however be overridden using the following or something similar:

" hi illuminatedWord cterm=underline gui=underline
hi! link illuminatedWord HighlightSubtle
