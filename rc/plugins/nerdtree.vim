" !::exe [So]

let NERDTreeWinSize = 30
let NERDTreeMinimalUI = 1
let NERDTreeHighlightCursorline = 1
let NERDTreeRespectWildIgnore = 1
let NERDTreeIgnore = ['__pycache__[[dir]]', '.o$[[file]]']
let NERDTreeAutoDeleteBuffer = 1



" UI

" let NERDTreeDirArrowExpandable  = '>'
" let NERDTreeDirArrowCollapsible = 'v'

hi! link NERDtreeDir Directory
hi! link NERDtreeCWD Special

" hi NERDTreeDir      guifg=#EBAD0D
hi! NERDTreeFlags    guifg=#EBAD0D
hi! link NERDTreeOpenable Comment
hi! link NERDTreeClosable Comment

let NERDTreeIndicatorMapCustom = {
\   'Modified'  : '*',
\   'Staged'    : '',
\   'Untracked' : '',
\   'Renamed'   : '',
\   'Unmerged'  : '',
\   'Deleted'   : '',
\   'Dirty'     : '*',
\   'Clean'     : '',
\   'Unknown'   : ''
\ }

let webdevicons_enable_nerdtree = 1
let webdevicons_conceal_nerdtree_brackets = 1
let WebDevIconsUnicodeDecorateFolderNodes = 1
let WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''

let DevIconsDefaultFolderOpenSymbol = ''
