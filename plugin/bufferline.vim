" File: bufferline.vim
" Author: romgrk
" Description: Buffer line
" Date: Fri 22 May 2020 02:22:36 AM EDT
" !::exe [So]


augroup bufferline
    au!
    " Modified-buffer styling
    au BufReadPost,BufNewFile * call <SID>on_open_buffer()
augroup END


command! BufferNext     call s:goto_buffer_relative(+1)
command! BufferPrevious call s:goto_buffer_relative(-1)

command! -nargs=1 BufferJump  call s:goto_buffer(<f-args>)
command!          BufferLast  call s:goto_buffer(-1)

command! BufferMoveNext     call s:move_current_buffer(+1)
command! BufferMovePrevious call s:move_current_buffer(-1)


" Constants
let s:SPACE = '%( %)'

" Hl groups used for coloring
let s:status = ['Inactive', 'Visible', 'Current']
let s:hl_groups = ['BufferInactive', 'BufferVisible', 'BufferCurrent']

" Current buffers in tabline (ordered)
let s:buffers = []

" Default icons
let g:icons = extend(get(g:, 'icons', {}), #{
\ bufferline_separator_active:   '▎',
\ bufferline_separator_inactive: '▎',
\})


fu! bufferline#update ()
   let &tabline = bufferline#render()
endfu

fu! bufferline#render ()
   let bufferNames = {}
   let bufferDetails = map(s:get_updated_buffers(), {k, number -> { 'number': 0+number, 'name': s:get_buffer_name(number) }})

   for i in range(len(bufferDetails))
   let buffer = bufferDetails[i]

   if !has_key(bufferNames, buffer.name)
      let bufferNames[buffer.name] = i
   else
      let other = bufferNames[buffer.name]
      let name = buffer.name
      let results = s:get_unique_name(bufname(buffer.number), bufname(bufferDetails[other].number))
      let newName = results[0]
      let newOtherName = results[1]
      let buffer.name = newName
      let bufferDetails[other].name = newOtherName
      let bufferNames[buffer.name] = buffer
      let bufferNames[bufferDetails[other].name] = bufferDetails[other]
      call remove(bufferNames, name)
   end
   endfor

   let currentnr = bufnr()

   let result = ''

   for i in range(len(bufferDetails))
      let buffer = bufferDetails[i]
      let type = buf#activity(0+buffer.number)
      let is_visible = type == 1
      let is_current = currentnr == buffer.number

      let status = s:status[type]
      let mod = buf#modF(0+buffer.number) ? 'Mod' : ''

      let signPrefix = s:hl('Buffer' . status . 'Sign')
      let namePrefix = s:hl('Buffer' . status . mod)

      let sign = status == 'Inactive' ?
         \ g:icons.bufferline_separator_inactive :
         \ g:icons.bufferline_separator_active

      let [icon, iconHl] = s:get_icon(buffer.name)
      let iconPrefix = status is 'Inactive' ? namePrefix : s:hl(iconHl)

      let icon = '%{"' . icon .' "}'
      let name = '%{"' . buffer.name .'"}'

      let result .=
         \ signPrefix . sign .
         \ iconPrefix . icon .
         \ namePrefix . name .
         \ s:SPACE

   endfor

   let result .= s:hl('TabLineFill')

   return result
endfu

fu! bufferline#session (...)
    let name = ''

    if exists('g:xolox#session#current_session_name')
        let name = g:xolox#session#current_session_name
    end

    if empty(name)
        let name = substitute(getcwd(), $HOME, '~', '')
        if len(name) > 30
           let name = pathshorten(name)
        end
    end

    return '%#BufferPart#%( ' . name . ' %)'
endfunc

fu! bufferline#tab_pages ()
    if tabpagenr('$') == 1
        return ''
    end
    let tabpart = ''
    for t in range(1, tabpagenr('$'))
        if !empty(t)
            let style = (t == tabpagenr()) ?  'TabLineSel'
                        \ : gettabvar(t, 'hl', 'LightLineRight_tabline_0')
            let tabpart .= s:hl(style, ' ' . t[0] . ' ')
        end
    endfor
    return tabpart
endfu


" Event handlers

function! s:on_open_buffer()
   if (&bt == '')
      augroup BUFFER_MOD
      au!
      au BufWritePost <buffer> call <SID>check_modified()
      au TextChanged  <buffer> call <SID>check_modified()
      au TextChangedI <buffer> call <SID>check_modified()
      augroup END
   end
endfunc

function! s:check_modified()
   if (&modified != get(b:,'checked'))
      let b:checked = &modified
      call bufferline#update()
   end
endfunc


" Buffer movement

function! s:move_current_buffer (direction)
   call s:get_updated_buffers()

   let currentnr = bufnr('%')
   let idx = index(s:buffers, currentnr)

   if idx == 0 && a:direction == -1
      return
   end
   if idx == len(s:buffers)-1 && a:direction == +1
      return
   end

   let othernr = s:buffers[idx + a:direction]
   let s:buffers[idx] = othernr
   let s:buffers[idx + a:direction] = currentnr

   call bufferline#update()
endfunc

function! s:goto_buffer (number)
   call s:get_updated_buffers()

   if a:number == -1
      let idx = len(s:buffers)-1
   else
      let idx = a:number - 1
   end

   silent execute 'buffer' . s:buffers[idx]
endfunc

function! s:goto_buffer_relative (direction)
   call s:get_updated_buffers()

   let currentnr = bufnr('%')
   let idx = index(s:buffers, currentnr)

   if idx == 0 && a:direction == -1
      let idx = len(s:buffers)-1
   elseif idx == len(s:buffers)-1 && a:direction == +1
      let idx = 0
   else
      let idx = idx + a:direction
   end

   silent execute 'buffer' . s:buffers[idx]
endfunc

" Helpers

lua << END
local web = require'nvim-web-devicons'
function get_icon_wrapper(args)
   local basename  = args[1]
   local extension = args[2]
   local icon, hl = web.get_icon(basename, extension, { default = true })
   return { icon, hl }
end
END

function! s:get_icon (buffer_name)
   let basename = fnamemodify(a:buffer_name, ':t')
   let extension = matchstr(basename, '\v\.@<=\w+$', '', '')
   let [icon, hl] = luaeval("get_icon_wrapper(_A)", [basename, extension])
   if icon == ''
      let icon = g:lua_tree_icons.default
   end
   return [icon, hl]
endfunc

function! s:get_updated_buffers ()
   if exists('g:session.buffers')
      let s:buffers = g:session.buffers
   elseif exists('g:session')
      let g:session.buffers = []
      let s:buffers = g:session.buffers
   end

    let current_buffers = buf#filter('&buflisted')
    let new_buffers =
        \ filter(
        \   copy(current_buffers),
        \   {i, bufnr -> !s:contains(s:buffers, bufnr)}
        \ )
    " Remove closed buffers
    call filter(s:buffers, {i, bufnr -> s:contains(current_buffers, bufnr)})
    " Add new buffers
    call extend(s:buffers, new_buffers)
    return copy(s:buffers)
endfunc

function! s:contains(list, value)
    for element in a:list
        try
            if element == a:value
                return 1
            end
        catch /.*/
            echom string(element)
            echom string(a:value)
            throw 'Invalid comparison'
        endtry
    endfor
    return 0
endfunction

function! s:get_buffer_name (number)
    if empty(bufname(a:number))
        return '[buffer ' . a:number . ']'
    end
    return buf#tail(a:number)
endfunc

function! s:get_unique_name (first, second)
    let first_parts  = path#Split(a:first)
    let second_parts = path#Split(a:second)

    let length = 1
    let first_result  = path#Join(first_parts[-length:])
    let second_result = path#Join(second_parts[-length:])
    while first_result == second_result && length < max([len(first_parts), len(second_parts)])
        let length = length + 1
        let first_result  = path#Join(first_parts[-min([len(first_parts), length]):])
        let second_result = path#Join(second_parts[-min([len(second_parts), length]):])
    endwhile

    return [first_result, second_result]
endfunc

function! s:hl (...)
    let str = '%#' . a:1 . '#'
    if a:0 > 1
        let str .= join(a:000[1:], '')
    end
    return str
endfu

let g:bufferline = s:
