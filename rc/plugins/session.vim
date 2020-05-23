"!::exe [So]

let session_persist_colors = 0

let session_hooks = {}
function! session_hooks.pre() dict
  ContextDisable
endfunc
function! session_hooks.post() dict
  ContextEnable
endfunc
