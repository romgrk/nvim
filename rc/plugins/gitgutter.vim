" !::exe [so %]

let gitgutter_enabled = 0
let gitgutter_map_keys = 0

"let gitgutter_realtime = 0
"let gitgutter_eager = 0


let gitgutter_sign_added            = "\u00a0"
let gitgutter_sign_removed          = "\u00a0-"
let gitgutter_sign_modified         = "\u00a0·"
let gitgutter_sign_modified_removed = "\u00a0·"

hi link GitGutterAdd          DiffAddedSubtle
hi link GitGutterChange       DiffModifiedSubtle
hi link GitGutterChangeDelete DiffModifiedSubtle
hi link GitGutterDelete       DiffRemovedSubtle
