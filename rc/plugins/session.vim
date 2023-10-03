"!::exe [So]
"=============================================================================
" Session options (vim-session)                                              {{{

let session_directory = $vim . '/sessions'
let session_command_aliases = 1
let session_default_to_last = 1
let session_persist_colors  = 1
let session_persist_globals = ['g:session_persist_globals', 'g:session']

let session_autoload = 'no'
let session_autosave = 'yes'
let session_autosave_silent = 1
let session_autosave_periodic = 1
let session_lock_enabled = 0

if !exists('g:session')
  let g:session = {}
end

let g:rc#on_session_save = {}

function! g:rc#on_session_save.pre() dict
  if exists(':ScrollViewDisable')
    ScrollViewDisable
  end
  if exists(':TSContextDisable')
    TSContextDisable
  end
endfunc

function! g:rc#on_session_save.post()
  if exists(':ScrollViewEnable')
    ScrollViewEnable
  end
  if exists(':TSContextEnable')
    TSContextEnable
  end
endfunc

" }}}
