" !::exe [so %]

let gitgutter_enabled = 1
let gitgutter_map_keys = 0

"let gitgutter_realtime = 0
"let gitgutter_eager = 0

let gitgutter_highlight_linenrs = 1

let gitgutter_sign_added            = "\u00a0"
let gitgutter_sign_removed          = "\u00a0-"
let gitgutter_sign_modified         = "\u00a0·"
let gitgutter_sign_modified_removed = "\u00a0·"

function! s:link_colors_start ()
  call timer_start(100, function('s:link_colors'), { "repeat": 1 })
endfunc

function! s:link_colors (...)
  hi! link GitGutterAdd          DiffAddedSubtle
  hi! link GitGutterChange       DiffModifiedSubtle
  hi! link GitGutterChangeDelete DiffModifiedSubtle
  hi! link GitGutterDelete       DiffRemovedSubtle

  hi! link GitGutterAddLineNr          GitGutterAdd
  hi! link GitGutterChangeLineNr       GitGutterChange
  hi! link GitGutterChangeDeleteLineNr GitGutterChangeDelete
  hi! link GitGutterDeleteLineNr       GitGutterDelete
endfunc

augroup gitgutter_colors
  au!
  au ColorScheme * call <SID>link_colors_start()
augroup END

call s:link_colors_start()
