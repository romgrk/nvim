" File: exchange-operator.vim
" Author: romgrk
" Date: 19 Jan 2019
" Description: Exchange operator
" !::exe [So]

" type: boolean
let s:has_selection = v:false

" type: [[lnum, col], [lnum, col]]
let s:selection = v:null

" type: [matchID]
let s:matches = []

" type: string
let s:mode = v:null

hi! link ExchangeRegion Highlight


nnoremap <silent><Plug>(exchange-operator)  :set opfunc=<SID>opfunc<CR>g@
vnoremap <silent><Plug>(exchange-operator)  :<C-U>call <SID>opfunc(visualmode())<CR>

vmap gx <Plug>(exchange-operator)
nmap gx <Plug>(exchange-operator)


function! s:opfunc (type, ...)
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@

    " Select the interest region
    " If invoked from Visual mode, use '< and '> marks.

    if (!empty(a:000))
      silent exe "normal! `<" . a:type . "`>"
    elseif (a:type == 'line')  | silent exe "normal! '[V']"
    elseif (a:type == 'char')  | silent exe "normal! `[v`]"
    elseif (a:type == 'block') | silent exe "normal! `[\<C-V>`]"
    end
    silent exe "normal! \<Esc>"

    if !s:has_selection
      call s:save_selection(a:type)
    else
      call s:exchange_selection()
    endif

    silent exe "normal! \<Esc>"

    let &selection = sel_save
    let @@         = reg_save
endfunc

function! s:save_selection(type)
  let s:has_selection = v:true
  let s:selection = s:get_current_selection()
  let s:mode = s:get_mode(a:type)

  call s:add_highlight(s:selection)

  echom string(s:selection)
endfunc

function! s:exchange_selection()
  let other_selection = s:get_current_selection()

  let is_other_after = s:is_after(s:selection, other_selection)

  if is_other_after != v:null
    let first = is_other_after ? s:selection : other_selection
    let last  = is_other_after ? other_selection : s:selection

    let first_text = s:get_selection_text(first)
    let last_text  = s:get_selection_text(last)

    call s:replace_selection(last,  first_text)
    call s:replace_selection(first, last_text)
  else
    " selection overlap
    echohl ErrorMsg
    echo 'Exchange operator: selection overlap'
    echohl None
  end

  " value movement
  " some test

  call s:reset_selection()
endfunc

function! s:reset_selection()
  let s:has_selection = v:true
  let s:selection = s:get_current_selection()
  let s:mode = v:null

  for matchID in s:matches
    try
      call matchdelete(matchID)
    catch /.*/ | | endtry
  endfor

  let s:matches = []
endfunc

function! s:get_current_selection()
  return [getpos("'<")[1:2], getpos("'>")[1:2]]
endfunc

function! s:add_highlight(selection)
  let lines = range(a:selection[0][0], a:selection[1][0])
  for lnum in lines

    let is_first = lnum == a:selection[0][0]
    let is_last  = lnum == a:selection[1][0]
    let is_same_line = is_first && is_last

    let line = getline(lnum)

    let col    = is_first ? a:selection[0][1] : 1
    let length = !is_last ?
          \     (len(line) - col + 1) :
          \ is_same_line ?
          \     (a:selection[1][1] - a:selection[0][1] + 1) :
          \     (a:selection[1][1])

    let m = matchaddpos('ExchangeRegion', [[lnum, col, length]])

    call add(s:matches, m)
  endfor
endfunc

function! s:get_mode(type)
  if a:type ==# 'v' || a:type ==# 'char'
    return 'v'
  end
  if a:type ==# 'V' || a:type ==# 'line'
    return 'V'
  end
  if a:type ==# "\<C-v>" || a:type ==# 'block'
    return "\<C-v>"
  end
  throw 'Invalid type: ' . a:type
endfunc

function! s:replace_selection(selection, text)
  let reg_save = @a

  let @a = a:text

  silent exe "normal! " . a:selection[0][0] . "G" . a:selection[0][1] . "|"
  silent exe "normal! " . s:mode
  silent exe "normal! " . a:selection[1][0] . "G" . a:selection[1][1] . "|"
  silent exe "normal! \"ap"

  let @a = reg_save
endfunction

function! s:get_selection_text(selection)
  let reg_save = @a

  silent exe "normal! " . a:selection[0][0] . "G" . a:selection[0][1] . "|"
  silent exe "normal! " . s:mode
  silent exe "normal! " . a:selection[1][0] . "G" . a:selection[1][1] . "|"
  silent exe "normal! \"ay"

  let result = @a

  let @a = reg_save

  return result
endfunction

function! s:is_after(a, b)
  if a:b[0][0] > a:a[1][0]
    return v:true
  end
  if a:b[1][0] < a:a[0][0]
    return v:false
  end
  if a:b[0][0] == a:a[1][0]
    if a:b[0][1] > a:a[1][1]
      return v:true
    end
    if a:b[1][1] < a:a[0][1]
      return v:false
    end
    return v:null
  end
endfunction
