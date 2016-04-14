"=============================================================================
" Autocomplete

let ycm_global_ycm_extra_conf = $rc . '/ycm.py'
let ycm_confirm_extra_conf    = 1
let ycm_extra_conf_globlist   = ['~/projects/*', '!~/downloads/*', '~/*']

let ycm_min_num_of_chars_for_completion     = 3

let ycm_autoclose_preview_window_after_insertion = 1

let ycm_cache_omnifunc = 1
let ycm_use_ultisnips_completer = 1
"let ycm_seed_identifiers_with_syntax = 1
"let ycm_collect_identifiers_from_tags_files = 1

let ycm_server_log_level = 'warning'

"=============================================================================
