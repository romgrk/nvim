let s:is_backslash_platform = exists('+shellslash')
let s:use_backslash = s:is_backslash_platform && !&shellslash
let s:slash = s:use_backslash ? '\' : '/'

if !s:is_backslash_platform
  " Unescaped frontslash.
  " \\@<!%(\\\\)* matches any number of double-backslashes not preceded by
  " a backslash.
  let s:unescaped_slash = '\v\\@<!%(\\\\)*\zs/'
else
  " Unescaped frontslash or backslash.
  " Even platforms that use backslashes as separators accept forward slashes.
  " See http://en.wikipedia.org/wiki/Path_(computing)#Representations_of_paths_by_operating_system_and_shell.
  let s:unescaped_slash = '\v\\@<!%(\\\\)*\zs[/\\]'
endif
let s:trailing_slash = s:unescaped_slash . '$'
let s:trailing_slashes = s:unescaped_slash . '+$'

let s:drive_backslash = '\v^\a:\\\\'
let s:drive_frontslash = '\v^\a://'


""
" Splits {path} on the last system separator character. Equivalent to using
" @function(#Split) and re-joining all components but the last, but more
" efficient since it's needed by performance critical code.
function! s:SplitLast(path) abort
  " First strip off root. This prevents the root from ever ending up in the tail
  " side of the split, and also makes the algorithm easier to reason about.
  let l:root = path#RootComponent(a:path)
  let l:path = a:path[len(l:root) : ]

  " Find the last separator (highest count to match() that doesn't return -1).
  " Note this uses linear search, but tuning it to reduce iterations didn't seem
  " to help, possibly because of caching inside vim.
  let l:count = 1
  let l:last_sep = -1
  while 1
    let l:sep_index = match(l:path, s:unescaped_slash, 0, l:count)
    if l:sep_index is -1
      " No match at this count. Terminate and use last match.
      break
    else
      let l:last_sep = l:sep_index
    endif
    let l:count += 1
  endwhile

  " Return [HEAD, TAIL] with root (if any_ included in the HEAD.
  if l:last_sep != -1
    " Slice up to (but not including) separator as HEAD.
    let l:head = l:last_sep > 0 ? l:path[ : l:last_sep - 1] : ''
    return [l:root . l:head, l:path[l:last_sep + 1 : ]]
  else
    return [l:root, '']
  endif
endfunction


" Joins {left} and {right}.
" Note that s:Join('foo', '') is foo/ and s:Join('foo/', '') is foo/.
function! s:Join(left, right) abort
  if a:left =~# s:trailing_slash
    return a:left . a:right
  elseif empty(a:left)
    return a:right
  endif
  return a:left . s:slash . a:right
endfunction


""
" Returns {path} with trailing slash (forward or backslash, depending on
" platform).
" Maktaba uses paths with trailing slashes to unambiguously denote directory
" paths, so utilities like @function(#Dirname) don't try to interpret them as
" file paths.
function! path#AsDir(path) abort
  return substitute(a:path, s:trailing_slashes, '', 'g') . s:slash
endfunction


""
" Returns the root component of {path}.
" In unix, / is the only root.
" In windows, the root can be \ (which vim treats as the default drive), a drive
" like D:\\, and also / or D:// if shellslash is set.
" The root of a relative path is empty.
function! path#RootComponent(path) abort
  if !s:is_backslash_platform
    return a:path[:0] ==# '/' ? '/' : ''
  endif
  if a:path ==# '\'
    " Windows users can always use backslashes regardless of &shellslash.
    " Vim interprets \ as the default drive.
    return '\'
  elseif &shellslash && a:path[:0] ==# '\'
    " / also expands to the default drive if &shellslash is set.
    return '/'
  elseif a:path =~# s:drive_backslash
    " Windows users can always give drives like c:\\
    return matchstr(a:path, s:drive_backslash)
  elseif &shellslash
    " Windows users with &shellslash set can also give drives like c://
    return matchstr(a:path, s:drive_frontslash)
  endif
  return ''
endfunction


"" Whether {path} is absolute.
function! path#IsAbsolute(path) abort
  return !path#IsRelative(a:path)
endfunction


"" Whether {path} is relative.
function! path#IsRelative(path) abort
  return empty(path#RootComponent(a:path))
endfunction


""
" Joins the list {components} together using the system separator character.
" Works like python's os.path.join in that
" >
"   Join(['relative', '/absolute'])
" <
" is '/absolute'
function! path#Join(components) abort
  call ensure#IsList(a:components)
  " We work through the components backwards because Join returns the rightmost
  " absolute path (if any absolute paths are created).
  let l:components = reverse(copy(a:components))
  " You might think this code can be simplified by initializing l:path to ''.
  " This is not the case: joining a component with an empty string ensures
  " a trailing slash. If we were to start with l:path = '' then
  " Join(['file.txt']) would yield file.txt/, which is incorrect.
  for l:component in l:components
    let l:root = path#RootComponent(l:component)
    if !empty(l:root) && l:root ==# l:component
      " This component is something like / or C:\\ It should be prepended rather
      " than joined. Afterwards, the path is absolute and can be returned.
      return exists('l:path') ? l:root . l:path : l:root
    endif
    let l:path = exists('l:path') ? s:Join(l:component, l:path) : l:component
    if !empty(l:root)
      return l:path
    endif
  endfor
  return exists('l:path') ? l:path : ''
endfunction


""
" Splits {path} on the system separator character.
function! path#Split(path) abort
  let l:root = path#RootComponent(a:path)
  let l:components = split(a:path[len(l:root):], s:unescaped_slash)
  " /foo/bar/baz splits to ['/', 'foo', 'bar', 'baz'].
  if !empty(l:root)
    call insert(l:components, l:root)
  endif
  return l:components
endfunction


""
" The basename of {path}. Trailing slash matters. Consider:
" >
"   :echomsg path#Basename('/path/to/file')
"   :echomsg path#Basename('/path/to/dir/')
" <
" The first echoes 'file', the second echoes ''.
function! path#Basename(path) abort
  return s:SplitLast(a:path)[1]
endfunction


""
" The dirname of {path}. Trailing slash matters. Consider:
" >
"   :echomsg path#Dirname('/path/to/file')
"   :echomsg path#Dirname('/path/to/dir/')
" <
" The first echoes '/path/to', the second echoes '/path/to/dir'
function! path#Dirname(path) abort
  return s:SplitLast(a:path)[0]
endfunction


""
" Gets the directory path of {path}.
" If {path} appears to point to a file, the parent directory will be returned.
" Otherwise, {path} will be returned.
" In both cases, the returned {path} will have a tailing slash.
function! path#GetDirectory(path) abort
  let l:path = a:path
  if !isdirectory(a:path) && path#Exists(a:path)
    let l:path = fnamemodify(l:path, ':h')
  endif
  return path#AsDir(l:path)
endfunction


""
" Returns a relative path from {root} to {path}.
" Both paths must be absolute. {root} is assumed to be a directory.
" In windows, both paths must be in the same drive.
" @throws BadValue unless both paths are absolute.
function! path#MakeRelative(root, path) abort
  call ensure#IsAbsolutePath(a:root)
  call ensure#IsAbsolutePath(a:path)
  call s:EnsurePathsHaveSharedRoot(a:root, a:path)

  " Starting from the beginning, discard directories common to both.
  let l:pathparts = path#Split(a:path)
  let l:rootparts = path#Split(a:root)
  while !empty(l:pathparts) && !empty(l:rootparts) &&
      \ l:pathparts[0] ==# l:rootparts[0]
    call remove(l:pathparts, 0)
    call remove(l:rootparts, 0)
  endwhile

  if empty(l:rootparts) && empty(l:pathparts)
    return '.'
  endif

  " l:rootparts now contains the directories we must traverse to reach the
  " common ancestor of root and path. Replacing those with '..' takes us to the
  " common ancestor. Then the remaining l:pathparts take us to the destination.
  return path#Join(map(l:rootparts, '".."') + l:pathparts)
endfunction


""
" Checks whether {path} (a file or directory) exists on the filesystem.
function! path#Exists(path) abort
  " Use glob() to check for path since vim has no fileexists().
  " Convert the path to a wildcard pattern by escaping special characters.
  let l:path_glob = escape(a:path, '\')
  let l:path_glob = substitute(l:path_glob, '\V[', '[[]', 'g')
  let l:path_glob = substitute(l:path_glob, '\V*', '[*]', 'g')
  let l:path_glob = substitute(l:path_glob, '\V?', '[\?]', 'g')
  return !empty(glob(l:path_glob, 1))
endfunction


""
" Makes {dir}. Returns 0 if {dir} already exists. Returns 1 if {dir} is created.
" This function is similar to |mkdir()| with the 'p' flag, but works around
" a Vim7.3 bug where mkdir chokes on trailing slashes.
" @throws BadValue if {dir} is a file.
" @throws NotAuthorized if {dir} cannot be created.
function! path#MakeDirectory(dir) abort
  if isdirectory(a:dir)
    return 0
  endif

  if path#Exists(a:dir)
    let l:msg = 'Cannot make directory %s, it is a file'
    throw error#BadValue(l:msg, a:dir)
  endif

  let l:dir = a:dir
  " Vim bug before 7.4 patch 6: mkdir chokes when a path has a trailing slash.
  if v:version < 704 || (v:version == 704 && !has('patch6'))
    " This is a hackish way to remove a trailing slash.
    let l:dir = path#Join(path#Split(l:dir))
  endif

  try
    call mkdir(l:dir, 'p')
  catch /E739:/
    throw error#NotAuthorized('Cannot create directory: %s', l:dir)
  endtry

  return 1
endfunction


function! s:EnsurePathsHaveSharedRoot(x, y) abort
  if path#RootComponent(a:x) !=# path#RootComponent(a:y)
    throw error#BadValue('%s is not in the same drive as %s', a:x, a:y)
  endif
endfunction
