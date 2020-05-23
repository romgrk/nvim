"!::exe [So]
"=============================================================================
" Session options (vim-session)                                              {{{

let session_directory = $vim . '/sessions'
let session_command_aliases = 1
let session_default_to_last = 1
let session_persist_colors  = 1
let session_persist_globals = ['g:session_persist_globals', 'g:session']

let session_autoload = 'yes'
let session_autosave = 'yes'
let session_autosave_silent = 1
let session_autosave_periodic = 1
let session_lock_enabled = 0

let session_hooks = {}

function! session_hooks.pre() dict
  ContextDisable
endfunc
function! session_hooks.post() dict
  ContextEnable
endfunc

if !exists('g:session')
  let g:session = {}
end

" }}}
