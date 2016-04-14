if !exists('s:counter')
  let s:counter = 0
endif


"" @private
function! reflist#Create()
  return {
      \ '_list': [],
      \ 'Items': function('reflist#Items'),
      \ 'Add': function('reflist#Add'),
      \}
endfunction


"" @private
function! reflist#Items() dict abort
  return map(copy(self._list), 'v:val[0]')
endfunction


"" @private
function! reflist#Add(Item) dict abort
  let l:id = s:counter
  let s:counter += 1
  call add(self._list, [a:Item, l:id])
  return function#Create('reflist#Remove', [l:id], self)
endfunction


"" @private
function! reflist#Remove(id) dict abort
  let l:len = len(self._list)
  call filter(self._list, 'v:val[1] != a:id')
  if len(self._list) < l:len
    return
  endif
  throw error#Message('AlreadyRemoved', 'Cannot remove a thing twice.')
endfunction
