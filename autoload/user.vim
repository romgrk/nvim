
"" Gets the user's name.
function! user#Name()
  return string#Strip(system#Call('whoami').stdout)
endfunction

""
" Gets a directory that can be used for cache files, creating it if necessary.
" Respects $XDG_CACHE_HOME if present.
" @throws NotAuthorized if the directory does not exist and cannot be created.
function! user#CacheDir()
  if !empty($XDG_CACHE_HOME)
    let l:dir = path#Join([$XDG_CACHE_HOME, 'vim'])
  elseif !empty($XDG_DATA_HOME)
    let l:dir = path#Join([$XDG_DATA_HOME, 'vim', 'cache'])
  elseif !empty($XDG_CONFIG_HOME)
    let l:dir = path#Join([$XDG_CONFIG_HOME, 'vim', 'cache'])
  else
    let l:dir = path#Join([$HOME, '.vim', 'cache'])
  endif
  call path#MakeDirectory(l:dir)
  return l:dir
endfunction

""
" Gets a directory that can be used for data files, creating it if necessary.
" Respects $XDG_DATA_HOME if present.
" @throws NotAuthorized if the directory does not exist and cannot be created.
function! user#DataDir()
  if !empty($XDG_DATA_HOME)
    let l:dir = path#Join([$XDG_DATA_HOME, 'vim'])
  elseif !empty($XDG_CONFIG_HOME)
    let l:dir = path#Join([$XDG_CONFIG_HOME, 'vim', 'data'])
  else
    let l:dir = path#Join([$HOME, '.vim', 'data'])
  endif
  call path#MakeDirectory(l:dir)
  return l:dir
endfunction

""
" Gets a directory that can be used for config files, creating it if
" necessary.
" Respects $XDG_CONFIG_HOME if present.
" @throws NotAuthorized if the directory does not exist and cannot be created.
function! user#ConfigDir()
  if !empty($XDG_CONFIG_HOME)
    let l:dir = path#Join([$XDG_CONFIG_HOME, 'vim'])
  else
    let l:dir = path#Join([$HOME, '.vim'])
  endif
  call path#MakeDirectory(l:dir)
  return l:dir
endfunction
