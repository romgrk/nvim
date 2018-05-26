" !::exe [So]

let fzf_layout = { 'window': 'belowright 15split enew' }

" Customize fzf colors to match your color scheme
let fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
\ 'bg':      ['bg', 'Normal'],
\ 'hl':      ['fg', 'Sneak'],
\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
\ 'hl+':     ['fg', 'Sneak'],
\ 'info':    ['fg', 'PreProc'],
\ 'border':  ['fg', 'Ignore'],
\ 'prompt':  ['fg', 'Conditional'],
\ 'pointer': ['fg', 'Exception'],
\ 'marker':  ['fg', 'Keyword'],
\ 'spinner': ['fg', 'Label'],
\ 'header':  ['fg', 'Comment'] }

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



command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview('right:50%'), <bang>0)
