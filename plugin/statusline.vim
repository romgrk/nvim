"!::exe [So]

" Powerline characters:
"                


let s:mode_background = '#606060'
let s:color_by_mode = {
\  'n':  '#599eff',
\  'i':  '#ffcf00',
\  'R':  '#afaf00',
\  'c':  '#d75f5f',
\  't':  '#d75f5f',
\  'v':  '#A77FFF',
\  'V':  '#A77FFF',
\  '': '#A77FFF',
\
\  'default': '#599eff',
\}

let s:modifiedFg = '#d75f5f'

augroup statusline
  au!
  au VimEnter * call s:update_inactive_windows()
  au VimEnter,WinEnter,BufWinEnter * let &l:statusline = statusline#active()
  au WinLeave *                      let &l:statusline = statusline#inactive()
augroup END

" Setup the colors
function! s:setup_colors() abort

  let s:statuslineFg = !empty(hi#fg('StatusLine')) ? hi#fg('StatusLine') : '#495058'
  let s:statuslineBg = !empty(hi#bg('StatusLine')) ? hi#bg('StatusLine') : '#d0d0d0'

  let s:mode_background = s:statuslineBg

  let s:statuslineFgLight = color#Decrease(s:statuslineFg, 0.4)
  let s:statuslineNCFg = !empty(hi#fg('StatusLineNC')) ? hi#fg('StatusLineNC') : '#495058'
  " let s:statuslineBg = hi#bg('StatusLine')
  " let s:statuslineBg = '#d0d0d0'
  let s:statuslineBgDark = color#Darken(s:statuslineBg, 0.2)


  call hi#('StatuslineNormal',           [s:color_by_mode['n'], s:mode_background, 'bold'])
  call hi#('StatuslineAccent',           ['none',              'none',         'bold'])
  call hi#('StatuslineAccentTransition', ['none',              'none',         'bold'])
  call hi#('StatuslineAccentNC',         [s:statuslineNCFg,    s:statuslineBg, 'bold'])
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
call timer_start(50, {-> s:setup_colors()})

augroup statusline_colors
  au!
  au ColorScheme * call s:setup_colors()
augroup END

function! s:update_inactive_windows()
  for winnum in range(1, winnr('$'))
    if winnum != winnr()
      call setwinvar(winnum, '&statusline', '%!statusline#inactive()')
    endif
  endfor
endfunction

function! statusline#update_colors(mode) abort
  call hi#('StatuslineAccent', [get(s:color_by_mode, a:mode, s:color_by_mode.default), s:mode_background])
  call hi#('StatuslineAccentTransition',
    \ s:mode_background,
    \ s:statuslineBg)
  call hi#fg('StatuslineFilename', &modified ? s:modifiedFg : s:statuslineFg)
  return ''
endfunction


"===============================================================================
" Statusline builders

function! statusline#active () abort
  let is_normal_file = !(&bt =~# '\vno(file|write)' || &bt == 'prompt')

  " Left side items

  let content = '%{statusline#update_colors(mode())}'

  if !is_normal_file
    if &filetype == 'grug-far'
      let content .= statusline#file_grug()
    else
      let content .= statusline#file_special()
    end
  end

  if is_normal_file
    " Mode
    let content .= '%#StatuslineAccent# '
    let content .= '%{statusline#get_mode(mode())} '
    let content .= '%#StatuslineSeparator#| '

    " Filetype icon
    " let content .= '%#StatuslineFiletype#%{statusline#filetype_icon()}'
    " Modified + Filename + Readonly
    " let content .= '%#StatuslineFilename#'
    " let content .= '%{statusline#modified(&modified)} '
    " let content .= '%{statusline#filename()} %<'
    " let content .= '%{&readonly?"' . icon#name('lock') . '":" "}'

    " VCS
    let vc_status = statusline#vc_branch()
    if len(vc_status)
      let content .= '%#StatuslineVC#%{statusline#vc_branch()}'
      " let content .= '%#StatuslineSeparator#| '
    end


    let content .= '%=' " Right side items

    " Line and Column
    let content .= '%#StatuslineLineCol#%l:%c '
    let content .= '%#StatuslineSeparator#| '
    let content .= '%#StatuslineLineCol#%L lines %<'

    " Heart
    let content .= '%#StatuslineHeart# '

    " coc
    " let content .= '%{g:coc_enabled?"":" "}%(%#StatuslineLint#%{statusline#coc()}%)'

    " let content .= '%{statusline#have_lsp()?"":" "}%(%#StatuslineLint#%{statusline#lsp()}%)'
  end

  return content
endfunc


function! statusline#file_special() abort
  let content = ''

  let content .= '%#StatuslineAccent# '
  let content .= statusline#get_special_name() . ' '
  let content .= '%#StatuslineSeparator#| '

  let content .= '%#StatuslineFilename#'

  return content
endfunc

lua << EOF
function statusline_grug_stats()
  return require('grug-far').get_instance()._context.state.stats
end
function statusline_grug_engine()
  return require('grug-far').get_instance()._context.engine.type
end
EOF

function! statusline#file_grug() abort
  let content = ''

  let name_parts = split(bufname(), ':')
  let name = len(name_parts) > 1 ? trim(name_parts[1]) : 'Search…'

  let content .= '%#StatuslineAccent# '
  let content .= ' '. name . ' '
  let content .= '%#StatuslineSeparator#| '

  let stats = v:lua.statusline_grug_stats()

  let content .= '%#StatuslineFilename#'
  let content .= printf('%i matches in %i files ', stats['matches'], stats['files'])

  let content .= '%#StatuslineSeparator#| '
  let content .= v:lua.statusline_grug_engine()

  return content
endfunc


function! statusline#inactive () abort
  " Using laststatus=3
  return statusline#active()

  " let is_normal_file = !(&bt =~# '\vno(file|write)')
  "
  " let content = ''
  "
  " if !is_normal_file
  "   let content .= '%#StatuslinePartNC# '
  "   let content .= statusline#get_special_name() . ' '
  "   let content .= '%#StatuslineFilenameNC#'
  " end
  "
  " if is_normal_file
  "   " Mode placeholder
  "   let content .= '%#StatuslineAccentNC# '
  "   let content .= '%{statusline#get_mode("e")} '
  "   let content .= '%#StatuslineSeparator#| '
  "
  "   " Filetype icon
  "   let content .= '%#StatuslineNC#%{statusline#filetype_icon()}'
  "
  "   " Modified + Filename + Readonly
  "   let content .= '%#StatuslineFilenameNC#'
  "   let content .= '%{tatusline#modified(&modified)} '
  "   let content .= '%{statusline#filename()} %<'
  "   let content .= '%{&readonly?"' . icon#name('lock') . '":" "}'
  "
  "   let content .= '%=' " Right side items
  "
  "   let content .= '%#StatuslineNC#'
  "
  "   " Line and Column
  "   let content .= '%l:%c '
  "   let content .= '| '
  "   let content .= '%L lines %<'
  "
  "   " VCS
  "   let vc_status = statusline#vc_status()
  "   if len(vc_status)
  "     let content .= '| '
  "     let content .= '%{statusline#vc_status()}'
  "   end
  "
  "   " Heart
  "   let content .= ' '
  " end
  "
  " return content
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
  \ 'SidebarNvim': ' Sidebar',
  \ 'SearchBox': ' Searching',
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
  let icon = v:lua.require('nvim-web-devicons').get_icon(fnamemodify(bufname('%'), ':h'), &filetype)
  if icon != v:null
    return icon
  end
  return icon#name('file')
endfunction


function! statusline#vc_branch() abort
  let mark = ''
  let branch = gitbranch#name()
  if branch ==# ''
    return ''
  end
  return branch . ' ' . mark
endfunction

function! statusline#vc_status() abort
  let changes = GitGutterGetHunkSummary()
  let status = changes[0] > 0 ? '+' . changes[0] : ''
  let prefix = changes[0] > 0 ? ' ' : ''
  let status = changes[1] > 0 ? status . prefix . '~' . changes[1] : status
  let prefix = changes[1] > 0 ? ' ' : ''
  let status = changes[2] > 0 ? status . prefix . '-' . changes[2] : status
  let status = status ==# '' ? '' : status . ' '

  return status
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
        \'e':  'Normal',
        \'n':  'Normal',
        \'no': 'Op    ',
        \'v':  'Visual',
        \'V':  'V·Line',
        \'^V': 'V·Blck',
        \'s':  'Select',
        \'S':  'S·Line',
        \'^S': 'S·Blck',
        \'i':  'Insert',
        \'R':  'Replce',
        \'Rv': 'V·Repl',
        \'c':  'Cmd   ',
        \'cv': 'Vim Ex',
        \'ce': 'Ex    ',
        \'r':  'Prompt',
        \'rm': 'More  ',
        \'r?': 'Confrm',
        \'!':  'Shell ',
        \'t':  'Term  '
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
