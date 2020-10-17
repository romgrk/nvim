"!::exe [So]

" Powerline characters:
"                


let s:color_by_mode = {
\  'n':  ['#e9f2ff', '#599eff'],
\  'i':  ['#6d5d08', '#ffcf00'],
\  'R':  ['#e9e9e9', '#afaf00'],
\  'c':  ['#e9f2ff', '#599eff'],
\  't':  ['#e9e9e9', '#d75f5f'],
\  'v':  ['#e9e9e9', '#875fdf'],
\  'V':  ['#e9e9e9', '#875fdf'],
\  '': ['#e9e9e9', '#875fdf'],
\
\  'default': ['#e9f2ff', '#599eff'],
\}

" let s:statuslineFg = hi#fg('StatusLine')
" let s:statuslineBg = hi#bg('StatusLine')
let s:statuslineFg = '#495058'
let s:statuslineBg = '#d0d0d0'

let s:modifiedFg = '#d75f5f'

augroup statusline
  au!
  au VimEnter * call s:update_inactive_windows()
  au VimEnter,WinEnter,BufWinEnter * let &l:statusline = statusline#active()
  au WinLeave *                      let &l:statusline = statusline#inactive()
augroup END

function! s:update_inactive_windows()
  for winnum in range(1, winnr('$'))
    if winnum != winnr()
      call setwinvar(winnum, '&statusline', '%!statusline#inactive()')
    endif
  endfor
endfunction

function! statusline#update_colors(mode) abort
  call hi#('StatuslineAccent', get(s:color_by_mode, a:mode, s:color_by_mode.default))
  call hi#('StatuslineAccentTransition',
    \ get(s:color_by_mode, a:mode, s:color_by_mode.default)[1],
    \ s:statuslineBg)
  call hi#fg('StatuslineFilename', &modified ? s:modifiedFg : s:statuslineFg)
  return ''
endfunction

" Setup the colors
function! s:setup_colors() abort

  " let s:statuslineFg = hi#fg('StatusLine')
  let s:statuslineFg = '#495058'
  let s:statuslineFgLight = color#lighten(s:statuslineFg, '110%')
  let s:statuslineNCFg = hi#fg('StatusLineNC')
  " let s:statuslineBg = hi#bg('StatusLine')
  let s:statuslineBg = '#d0d0d0'
  let s:statuslineBgDark = '#9D9D9D'


  call hi#('StatuslineNormal',           ['#e9e9e9',           s:statuslineBg, 'none'])
  call hi#('StatuslineAccent',           ['none',              'none',         'bold'])
  call hi#('StatuslineAccentTransition', ['none',              'none',         'bold'])
  call hi#('StatuslinePart',             hi#('StatusLinePart'))
  call hi#('StatuslinePartNC',           hi#('StatusLinePartNC'))
  call hi#('StatuslineFiletype',         [s:statuslineFg,      s:statuslineBg, 'none'])
  call hi#('StatuslineModified',         [s:modifiedFg,        s:statuslineBg, 'bold'])
  call hi#('StatuslineFilename',         [s:statuslineFg,      s:statuslineBg, 'bold'])
  call hi#('StatuslineFilenameNC',       [s:statuslineNCFg,    s:statuslineBg, 'bold'])
  call hi#('StatuslineSeparator',        [s:statuslineFgLight, s:statuslineBg, 'none'])
  call hi#('StatuslineLineCol',          [s:statuslineFg,      s:statuslineBg, 'none'])
  call hi#('StatuslinePercentage',       ['#dab997',           s:statuslineBg, 'none'])
  call hi#('StatuslineVC',               [s:statuslineFg,      s:statuslineBg, 'none'])
  call hi#('StatuslineHeart',            ['#d75f5f',           s:statuslineBg, 'none'])

  call hi#('StatuslineLintWarn',         ['#ffcf00',      s:statuslineBg, 'none'])
  call hi#('StatuslineLintChecking',     ['#458588',      s:statuslineBg, 'none'])
  call hi#('StatuslineLintError',        ['#d75f5f',      s:statuslineBg, 'none'])
  call hi#('StatuslineLintOk',           ['#b8bb26',      s:statuslineBg, 'none'])
  call hi#('StatuslineLint',             [s:statuslineBg, '#e9e9e9',      'none'])

endfunction

call s:setup_colors()

augroup statusline_colors
  au!
  au ColorScheme * call s:setup_colors()
augroup END

"===============================================================================
" Statusline builders

function! statusline#active () abort
  let is_normal = !(&bt =~# '\vno(file|write)')

  " Left side items

  let content = '%{statusline#update_colors(mode())}'

  if !is_normal
    let content .= '%#StatuslineAccent# '
    let content .= statusline#get_special_name() . ' '
    let content .= '%#StatuslineAccentTransition#'

    let content .= '%#StatuslineFilename#'
  end

  if is_normal
    " Mode
    let content .= '%#StatuslineAccent# '
    let content .= '%{statusline#get_mode(mode())} '
    let content .= '%#StatuslineAccentTransition#'

    " Filetype icon
    let content .= '%#StatuslineFiletype# %{statusline#filetype_icon()}'

    " Modified + Filename + Readonly
    let content .= '%#StatuslineFilename#'
    let content .= '%{statusline#modified(&modified)} '
    let content .= '%{statusline#filename()} %<'
    let content .= '%{&readonly?"' . icon#name('lock') . '":" "}'

    let content .= '%=' " Right side items

    " Line and Column
    let content .= '%#StatuslineLineCol#%l:%c '
    let content .= '%#StatuslineSeparator#| '
    let content .= '%#StatuslineLineCol#%L lines %<'

    " VCS
    let vc_status = statusline#vc_status()
    if len(vc_status)
      let content .= '%#StatuslineSeparator#| '
      let content .= '%#StatuslineVC#%{statusline#vc_status()}'
    end

    " Heart
    let content .= '%#StatuslineHeart# '

    " Gutentags status
    " let content .= '%{statusline#gutentags_enabled()?" ":""}%(%#StatuslineLint#%{statusline#gutentags()}%)'

    " coc
    " let content .= '%{g:coc_enabled?"":" "}%(%#StatuslineLint#%{statusline#coc()}%)'

    let content .= '%{statusline#have_lsp()?"":" "}%(%#StatuslineLint#%{statusline#lsp()}%)'
  end

  return content
endfunc

function! statusline#inactive () abort
  let is_normal = !(&bt =~# '\vno(file|write)')

  let content = ''

  if !is_normal
    let content .= '%#StatuslinePartNC# '
    let content .= statusline#get_special_name() . ' '
    let content .= '%#StatuslineFilenameNC#'
  end

  if is_normal
    " Filetype icon
    let content .= '%#StatuslineFiletype# %{statusline#filetype_icon()}'

    " Modified + Filename + Readonly
    let content .= '%#StatuslineFilenameNC#'
    let content .= '%{statusline#modified(&modified)} '
    let content .= '%{statusline#filename()} %<'
    let content .= '%{&readonly?"' . icon#name('lock') . '":" "}'

    let content .= '%=' " Right side items

    " Line and Column
    let content .= '%#StatuslineLineCol#%l:%c '
    let content .= '%#StatuslineSeparator#| '
    let content .= '%#StatuslineLineCol#%L lines %<'

    " VCS
    let vc_status = statusline#vc_status()
    if len(vc_status)
      let content .= '%#StatuslineSeparator#| '
      let content .= '%#StatuslineVC#%{statusline#vc_status()}'
    end

    " Heart
    let content .= '%#StatuslineVC#  '
  end

  return content
endfunc

"===============================================================================
" Statusline functions

let g:spinner_frames = ['⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷']

function! statusline#get_special_name() abort
  let name_by_filetype = {
  \ 'vista':    ' VISTA',
  \ 'fugitive': ' FUGITIVE',
  \ 'LuaTree':  ' FILES',
  \ 'nerdtree': ' FILES',
  \}

  if has_key(name_by_filetype, &filetype)
    return name_by_filetype[&filetype]
  end

  return bufname()
endfunction

function! statusline#modified(modified) abort
  if a:modified == 1
    return '  ●'
  end
  return ''
endfunction

function! statusline#filetype_icon() abort
  return icon#file(fnamemodify(bufname('%'), ':h'), &filetype)
endfunction

function! statusline#gutentags_enabled() abort
  return exists('g:gutentags_enabled') && g:gutentags_enabled == 1 && gutentags#statusline() !=# ''
endfunction

function! statusline#gutentags()
  if !statusline#gutentags_enabled()
    return ''
  endif

  return gutentags#statusline('[', '] ')
endfunction

function! statusline#vc_status() abort
  let l:mark = ''
  let l:branch = gitbranch#name()
  let l:changes = GitGutterGetHunkSummary()
  let l:status = l:changes[0] > 0 ? '+' . l:changes[0] : ''
  let l:prefix = l:changes[0] > 0 ? ' ' : ''
  let l:status = l:changes[1] > 0 ? l:status . l:prefix . '~' . l:changes[1] : l:status
  let l:prefix = l:changes[1] > 0 ? ' ' : ''
  let l:status = l:changes[2] > 0 ? l:status . l:prefix . '-' . l:changes[2] : l:status
  let l:status = l:status ==# '' ? '' : l:status . ' '
  return l:branch !=# '' ? l:status . l:mark . ' ' . l:branch . ' ' : ''
endfunction

function! statusline#coc() abort
  " Partially adapted from coc#status
  let l:coc_info = get(b:, 'coc_diagnostic_info', {})
  let l:coc_msgs = []
  let l:only_hint = v:true
  if get(l:coc_info, 'error', 0)
    call add(l:coc_msgs, g:icons.by_name.error . ' ' . l:coc_info['error'])
    let l:only_hint = v:false
  endif

  if get(l:coc_info, 'warning', 0)
    call add(l:coc_msgs, g:icons.by_name.warning . ' ' . l:coc_info['warning'])
    let l:only_hint = v:false
  endif

  if get(l:coc_info, 'information', 0)
    call add(l:coc_msgs, g:icons.by_name.info . ' ' . l:coc_info['information'])
    let l:only_hint = v:false
  endif

  if get(l:coc_info, 'hint', 0)
    call add(l:coc_msgs, g:icons.by_name.hint . l:coc_info['hint'])
  endif

  let l:base_status = trim(join(l:coc_msgs, ' ') . ' ' . get(g:, 'coc_status', ''))
  let l:status = ' 🇻' . (l:only_hint ? '' : ' ')
  let l:current_function = get(b:, 'coc_current_function', '')
  if l:current_function !=# ''
    let l:status = l:status . '(' . l:current_function . ') '
  endif

  if l:base_status !=# ''
    let l:status = l:status . l:base_status . ' '
  else
    let l:status = l:status . g:icons.by_name.ok . ' '
  endif

  return l:status
endfunction

function! statusline#have_lsp() abort
  return luaeval("#vim.lsp.buf_get_clients() > 0")
endfunction

function! statusline#lsp() abort
  return luaeval("require('statusline').lsp()")
endfunction

function! statusline#get_mode(mode) abort
  let l:currentmode={
        \'n':  'Normal',
        \'no': 'Operator',
        \'v':  'Visual',
        \'V':  'V·Line',
        \'^V': 'V·Block',
        \'s':  'Select',
        \'S':  'S·Line',
        \'^S': 'S·Block',
        \'i':  'Insert',
        \'R':  'Replace',
        \'Rv': 'V·Replace',
        \'c':  'Command',
        \'cv': 'Vim Ex',
        \'ce': 'Ex',
        \'r':  'Prompt',
        \'rm': 'More',
        \'r?': 'Confirm',
        \'!':  'Shell',
        \'t':  'Terminal'
        \}
  return toupper(get(l:currentmode, a:mode, 'V-Block'))
endfunction

function! statusline#filename() abort
  let base_name = bufname('%')
  if base_name != ''
    let base_name = fnamemodify(base_name, ':~:.')
  else
    let base_name = '[Buffer ' . bufnr() . ']'
  end
  let space = min([60, float2nr(floor(0.6 * winwidth(0)))])
  if len(base_name) <= space
    return base_name
  endif

  return pathshorten(base_name)
endfunction
