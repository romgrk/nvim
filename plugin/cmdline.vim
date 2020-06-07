"!::exe [So]

finish

augroup cmdline
  au!
  au CmdlineEnter   * call s:on_cmdline_enter()
  au CmdlineLeave   * call s:on_cmdline_leave()
augroup END
augroup cmdline_changed
  au!
augroup END

let s:is_active = v:false
let s:last_time = ''
let s:last_value = ''

function! s:on_cmdline_enter ()
  let s:is_active = v:true
  augroup cmdline_changed
    au!
    au CmdlineChanged * call s:on_cmdline_changed()
  augroup END
endfunc

function! s:on_cmdline_leave ()
  let s:is_active = v:false
  augroup cmdline_changed
    au!
  augroup END
endfunc

function! s:on_cmdline_changed ()
  if !s:is_active || mode() !=# 'c'
    return
  end

  let current_value = getcmdline()
  let current_time = reltimefloat(reltime())

  if len(current_value) > len(s:last_value)
        \ && (current_time - s:last_time) > 0.150
        \ && !wildmenumode()
    call feedkeys("\<tab>", 't')
    let s:last_time = current_time
  end

  let s:last_value = current_value
endfunc
