" !::exe [So]

" let fzf_layout = { 'window': 'belowright 15split enew' }

let $FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS . '--layout=reverse'
let fzf_layout = { 'window': 'call CreateFZFWindow()' }

function! CreateFZFWindow()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let padding = { 'top': 5, 'bottom': 0 }
  " let height = &lines - 3 - (padding.top + padding.bottom)
  let height = 25
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': 1 + padding.top,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  call nvim_open_win(buf, v:true, opts)
  " set winhl=Normal:NormalFloat
endfunction


" Customize fzf colors to match your color scheme
let fzf_colors =
\{ 'fg':      ['fg', 'Normal'],
\  'bg':      ['bg', 'NormalPopup'],
\  'hl':      ['fg', 'Sneak'],
\  'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\  'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
\  'hl+':     ['fg', 'Sneak'],
\  'info':    ['fg', 'PreProc'],
\  'border':  ['fg', 'Ignore'],
\  'prompt':  ['fg', 'Conditional'],
\  'pointer': ['fg', 'Exception'],
\  'marker':  ['fg', 'Keyword'],
\  'spinner': ['fg', 'Label'],
\  'header':  ['fg', 'Comment'] }

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
\| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

autocmd! User FzfStatusLine call <SID>fzf_statusline()

autocmd ColorScheme * call <SID>fzf_highlight()

function! s:fzf_highlight()
  call hi#('FZFStatusLineTitle',     g:theme.fg, hi#bg('StatusLine'), 'bold')
  call hi#('FZFStatusLineSeparator', g:theme.fg, hi#bg('StatusLine'))
endfunc

function! s:fzf_statusline()
  " Override statusline as you like
  setlocal statusline=%#FZFStatusLineTitle#\ FZF\ %#FZFStatusLineSeparator#%#StatusLine#
  let timer = timer_start(0, function('s:fzf_redraw'))
endfunction

function! s:fzf_redraw(timer)
  setlocal laststatus=2
  tnoremap <buffer> <a-u> <a-u>
endfunction

let fzf_btags_command = {
\ 'scss': 'scss-ctags -f- %s',
\ }
" \ 'javascript': 'jsctags %s -f',
" \ 'javascript.jsx': 'jsctags %s -f',

command! -bang -nargs=* BTags
  \  if has_key(g:fzf_btags_command, &filetype)
  \|   call fzf#vim#buffer_tags(<q-args>, printf(g:fzf_btags_command[&filetype], shellescape(expand('%'))), <bang>0)
  \| else
  \|   call fzf#vim#buffer_tags(<q-args>, <bang>0)
  \| endif


command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview('right:50%'), <bang>0)


function! s:color_to_fzf (color)
  let r = '0x' . strpart(a:color, 1, 2)
  let g = '0x' . strpart(a:color, 3, 2)
  let b = '0x' . strpart(a:color, 5, 2)
  return join([r, g, b], ',')
endfunc

function! s:get_fzf_rg_colors ()
  if &bg == 'dark'
    let fzf_rg_colors_dark =
      \   '--colors="path:fg:yellow" '
      \ . '--colors="path:style:bold" '
      \ . '--colors="line:fg:white" '
      \ . '--colors="line:style:bold" '
      \ . '--colors="match:fg:red" '
      \ . '--colors="match:style:bold" '

    return endiffzf_rg_colors_dark
  end

  let fzf_rg_colors_light =
    \   '--colors="path:fg:' . s:color_to_fzf(hi#fg('directory')) . '" '
    \ . '--colors="path:style:bold" '
    \ . '--colors="line:fg:0x30,0x30,0x30" '
    \ . '--colors="line:style:bold" '
    \ . '--colors="match:fg:red" '
    \ . '--colors="match:style:bold" '

  return fzf_rg_colors_light
endfunc

command! -bang -nargs=* FzfRg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '
  \         . s:get_fzf_rg_colors()
  \         . shellescape(<q-args>),
  \   1,
  \   extend(
  \       { 'down': '20%' },
  \       <bang>0 ? fzf#vim#with_preview('up:60%')
  \               : fzf#vim#with_preview('right:40%:hidden', '?')
  \   ),
  \   <bang>0
  \ )

