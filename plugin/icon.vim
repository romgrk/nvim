"!::exe [So]

let s:by_name = {
\ 'file':     '',
\ 'lock':     '',
\ 'checking': '',
\ 'warning':  '',
\ 'error':    '',
\ 'ok':       '',
\ 'info':     '',
\ 'hint':     '',
\ 'line':     '',
\ 'separator-right': '',
\}

function! icon#name(name)
  return get(
  \ s:by_name,
  \ a:name,
  \ '[INVALID_NAME]'
  \)
endfunction
