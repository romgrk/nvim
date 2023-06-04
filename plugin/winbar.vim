
augroup winbar
  au!
  au VimEnter * call s:update_inactive_windows()
  au VimEnter,WinEnter,BufWinEnter,BufWrite * let &l:winbar = winbar#setup(str2nr(expand('<abuf>')))
augroup END

let s:SEPARATOR = ''

function! s:update_inactive_windows()
  for winnum in range(1, winnr('$'))
    if winnum != winnr()
      call setwinvar(winnum, '&winbar', winbar#setup(winbufnr(winnum)))
    endif
  endfor
endfunction

"===============================================================================
" WinBar builders

function winbar#should_skip(bufnr)
  if winheight(0) <= 1 || nvim_win_get_config(0).relative != ''
    return v:true
  end
  let buftype = nvim_buf_get_option(a:bufnr, 'buftype')
  if buftype != ''
    return v:true
  end
  if bufname(a:bufnr) == ''
    return v:true
  end
  return v:false
endfunction

function! winbar#setup(bufnr) abort
  if winbar#should_skip(a:bufnr)
    return ''
  end

  return '%!winbar#render()'
endfunc

"===============================================================================
" WinBar functions

function! winbar#render() abort
  let buffer_number = winbufnr(g:statusline_winid)

  let base_name = bufname(buffer_number)
  if base_name == ''
    return ''
  end
  let base_name = fnamemodify(base_name, ':~:.')

  let space = float2nr(floor(0.8 * winwidth(g:statusline_winid)))
  if len(base_name) <= space
    let filename = base_name
  else
    let filename = pathshorten(base_name)
  endif

  let parts = split(filename, '/')
  let result = ''
  let is_absolute = filename[0] == '/'

  for i in range(len(parts))
    let part = parts[i]
    if is_absolute && i == 0
      let part = '/'
    end

    if i != 0
      let result .= '%#WinBarSeparator#'
      let result .= s:SEPARATOR
    end

    let hl = '%#WinBarNormal#'

    if i == len(parts) - 1
      let modified = nvim_buf_get_option(buffer_number, 'modified')
      if modified
        let hl = '%#WinBarModified#'
        let part = part . ' ●'
      " else
      "   let icon = s:icon(base_name)
      "   let part = icon . ' ' . part
      end

      let readonly = nvim_buf_get_option(buffer_number, 'readonly')
      if readonly
        let part = part . ' ' . icon#name('lock')
      end
    end

    let result .= hl
    let result .= ' ' . part . ' '
  endfor

  return result
endfunction

" function! s:icon(name) abort
"   let icon = v:lua.require('nvim-web-devicons').get_icon(fnamemodify(a:name, ':h'), &filetype)
"   if icon != v:null
"     return icon
"   end
"   return icon#name('file')
" endfunction
