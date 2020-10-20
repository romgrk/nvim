" !::exe [so %]

let gitgutter_enabled = 1
let gitgutter_map_keys = 0

"let gitgutter_realtime = 0
"let gitgutter_eager = 0

let gitgutter_highlight_linenrs = 1

" let gitgutter_sign_added            = "\u00a0"
" let gitgutter_sign_removed          = "\u00a0-"
" let gitgutter_sign_modified         = "\u00a0·"
" let gitgutter_sign_modified_removed = "\u00a0·"

let gitgutter_sign_added            = "\u00a0│"
let gitgutter_sign_removed          = "\u00a0│"
let gitgutter_sign_modified         = "\u00a0│"
let gitgutter_sign_modified_removed = "\u00a0│"

" let gitgutter_sign_added            = "\u00a0▎"
" let gitgutter_sign_removed          = "\u00a0▎"
" let gitgutter_sign_modified         = "\u00a0▎"
" let gitgutter_sign_modified_removed = "\u00a0▎"


function! s:link_colors_start ()
  call timer_start(100, function('s:link_colors'), { "repeat": 1 })
endfunc

function! s:link_colors (...)
  hi default link DiffAddedGutterLineNr     DiffAddedGutter
  hi default link DiffModifiedGutterLineNr  DiffModifiedGutter
  hi default link DiffModifiedGutterLineNr  DiffModifiedGutter
  hi default link DiffRemovedGutterLineNr   DiffRemovedGutter

  hi! link GitGutterAdd                DiffAddedGutter
  hi! link GitGutterChange             DiffModifiedGutter
  hi! link GitGutterChangeDelete       DiffModifiedGutter
  hi! link GitGutterDelete             DiffRemovedGutter

  hi! link GitGutterAddLineNr          DiffAddedGutterLineNr
  hi! link GitGutterChangeLineNr       DiffModifiedGutterLineNr
  hi! link GitGutterChangeDeleteLineNr DiffModifiedGutterLineNr
  hi! link GitGutterDeleteLineNr       DiffRemovedGutterLineNr
endfunc

augroup gitgutter_colors
  au!
  au ColorScheme * call <SID>link_colors_start()
augroup END

call s:link_colors_start()
