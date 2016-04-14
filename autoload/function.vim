function! s:IsFunctionContext(context) abort
  return value#IsDict(a:context)
      \ || (value#IsNumber(a:context) && a:context == 0)
endfunction


function! s:EnsureFunctionContext(context) abort
  if !s:IsFunctionContext(a:context)
    let l:msg = 'Function context must be either a dictionary or 0.'
    throw error#BadValue(l:msg)
  endif
  return a:context
endfunction


"" @private
function! function#DoCall(...) dict abort
  return function#Call(self, get(a:, 1, []), get(a:, 2, 0))
endfunction

"" @private
function! function#DoApply(...) dict abort
  return function#Call(self, a:000)
endfunction

"" @private
function! function#DoWithArgs(...) dict abort
  return function#Create(self, a:000)
endfunction

"" @private
function! function#DoWithContext(dict) dict abort
  return function#WithContext(self, a:dict)
endfunction

let s:DoCall = function('function#DoCall')
let s:DoApply = function('function#DoApply')
let s:DoWithArgs = function('function#DoWithArgs')
let s:DoWithContext = function('function#DoWithContext')


""
" @private
" Names correspond to |call()| help docs.
" Can be tricked, but only if people are accessing our private functions.
function! function#IsWellFormedDict(F) abort
  return value#IsDict(a:F)
      \ && has_key(a:F, 'Call')
      \ && value#IsEqual(a:F.Call, s:DoCall)
endfunction


""
" Creates a funcdict object that can be applied with @function(#Apply).
" When applied, {func} will be applied with [arglist], a list of arguments.
" If {func} is already a funcdict, it will be passed the arguments in [arglist]
" AFTER the arguments that are already pending.
"
" If [dict] is given it must be a dictionary, which will be passed as the
" dictionary context to {func} when applied. (In this case, {func} must be
" a dictionary function.) [dict] may also be the number 0, in which case it will
" be ignored.
"
" This allows you to create actual closures in vimscript (by storing context in
" a dictionary, see |Dictionary-function|.
"
" Note that the resulting funcdict can only be used in scopes where {func} can
" be used. For example, if {func} is script-local then the resulting function
" object is also script-local. (Builtin and autoloaded functions are in the
" global scope, so if {func} is builtin or autoloaded then the resulting
" function object can be used anywhere).
"
" @default arglist=[]
" @default dict=0
function! function#Create(F, ...) abort
  call ensure#IsCallable(a:F)
  let l:arglist = ensure#IsList(get(a:, 1, []))
  let l:dict = s:EnsureFunctionContext(get(a:, 2))
  let l:base = {
      \ 'Call': s:DoCall,
      \ 'Apply': s:DoApply,
      \ 'WithArgs': s:DoWithArgs,
      \ 'WithContext': s:DoWithContext
      \}
  if value#IsDict(a:F)
    let l:base.func = a:F.func
    let l:base.arglist = a:F.arglist + l:arglist
    let l:base.dict = value#IsDict(l:dict) ? l:dict : a:F.dict
  else
    let l:base.func = a:F
    let l:base.arglist = l:arglist
    let l:base.dict = l:dict
  endif
  return l:base
endfunction


""
" @usage func [arglist] [dict]
" Applies {func} (optionally to [arglist], optionally with [dict] as its
" dictionary context). {func} may be a funcref, a string describing a function,
" or a maktaba funcdict (see @function(#Create)).
"
" If {func} is a funcdict that has arguments pending, [arglist] will be sent to
" the function APPENDED to the pending arguments.
"
" [dict], if given and non-zero, will override any existing dictionary context.
" Note that if [dict] is given, {func} must describe a dictionary function.
"
" @default arglist=[]
" @default dict=0
function! function#Call(F, ...) abort
  call ensure#IsCallable(a:F)
  let l:args = ensure#IsList(get(a:, 1, []))
  if value#IsDict(a:F)
    let l:dict = get(a:, 2)
    if value#IsNumber(l:dict)
      unlet l:dict
      let l:dict = a:F.dict
    endif
    return function#Call(a:F.func, a:F.arglist + l:args, l:dict)
  endif
  let l:dict = get(a:, 2)
  if value#IsDict(l:dict)
    return call(a:F, l:args, l:dict)
  endif
  return call(a:F, l:args)
endfunction


""
" Creates a funcdict that is {method} on {dict}, with {dict} bound as the
" dictionary context.
"
" This is usually what users mean when they say something like dict.Method, but
" unfortunately, vimscript 'forgets' the dictionary context when you extract
" a method. Thus, you sometimes have to do things like
" >
"   call call(dict.Method, [args], dict)
" <
" Which is just silly. Using this function, you can do
" >
"   call function#Method(dict, 'Method').Apply(args)
" <
" which is a little less repetitive.
"
" @throws NotFound if {dict} has no such {method}.
function! function#Method(dict, method) abort
  call ensure#IsDict(a:dict)
  call ensure#IsString(a:method)
  if !has_key(a:dict, a:method)
    let l:msg = 'Method %s in dict %s.'
    throw error#NotFound(l:msg, a:method, string(a:dict))
  endif
  call ensure#IsCallable(a:dict[a:method])
  return function#Create(a:dict[a:method], [], a:dict)
endfunction


""
" @usage func [args...]
" Applies {func} to [args...]. This is like @function(#Call), but allows you to
" pass arguments in naturally rather than wrapping them in a list.
"
" Note that because vimscript functions are limited to 20 arguments, and because
" one argument is spent to specify {func}, this function can only send nineteen
" arguments on. If this is too limiting, use |#Call|.
function! function#Apply(F, ...) abort
  return function#Call(a:F, a:000)
endfunction


""
" Given callable {func}, creates a function object that will be called with
" [arg...] when it is applied. If {func} is a funcdict with pending arguments,
" then when {func} is applied [arg...] will be sent to the inner function AFTER
" the existing arguments. For example:
" >
"   :echomsg function#WithArgs('get', ['a', 'b', 'c']).Apply(1)
" <
" This will echo b.
"
" This will always create a new funcdict. {func} will not be modified.
function! function#WithArgs(F, ...) abort
  return function#Create(a:F, a:000)
endfunction


""
" Creates a funcdict that will call {func} with dictionary context {dict} when
" applied.
"
" This will always create a new funcdict. {func} will not be modified.
function! function#WithContext(F, dict) abort
  return function#Create(a:F, [], a:dict)
endfunction


""
" @private
" The Apply of a @function(#FromExpr) funcdict.
function! function#EvalExpr(expr, ...) abort dict
  return eval(a:expr)
endfunction


""
" Creates a funcdict that evaluates and returns {expr} when applied. {expr} may
" reference numbered arguments (|a:1|, a:2, ... through a:19). {expr} itself is
" available as a:expr. [arglist] will be queued as the initial arguments, if
" given:
" >
"   :let hello = function#FromExpr('a:1 . ", " . a:2', ['Hello'])
"   :echomsg hello.Apply('World')
" <
" This will echo "Hello, World".
"
" If [dict] is given then it must be a dictionary, and will be used as the
" dictionary context for the resulting function. In that case, {expr} may also
" make use of |self|.
function! function#FromExpr(expr, ...) abort
  let l:arglist = get(a:, 1, [])
  let l:dict = get(a:, 2, {})
  return function#Create(
      \ 'function#EvalExpr', [a:expr] + l:arglist, l:dict)
endfunction


""
" @private
" The Apply of a function composition.
function! function#DoCompose(...) dict abort
  call map(self.functions, 'ensure#IsCallable(v:val)')
  if empty(self.functions)
    throw error#BadValue('Cannot compose no functions.')
  endif
  let l:args = a:000
  for l:Function in self.functions
    let l:Result = function#Call(l:Function, l:args)
    let l:args = [l:Result]
    unlet l:Function
  endfor
  return l:Result
endfunction



""
" @usage {g} {f}
" Creates a composition of {g} and {f}.
"
" This creates a function object that, when applied, will apply {g} to the
" result of applying {f} to the given arguments.
"
" Notice that, as per the usual convention, control flow passes RIGHT TO LEFT:
" {g} (the FIRST argument) will be run on the result of {f} (the SECOND
" argument).
"
" The final result is returned.
"
" @usage {functions...}
" Composes all of {functions...}, RIGHT to LEFT. For example,
" >
"   :let HGF = function#Compose(H, G, F)
"   :call HGF.Apply(x)
" <
" computes H(G(F(x))).
function! function#Compose(F, ...) abort
  let l:context = {'functions': reverse(copy(a:000))}
  call add(l:context.functions, a:F)
  return function#Create('function#DoCompose', [], l:context)
endfunction


""
" @usage {list} {func}
" Replaces each item of {list} with the result of applying {func} to that item.
" This is like |map|, except {func} may be any maktaba callable and where a new
" list is created. Unlike the builtin map() function, {list} WILL NOT be
" modified in place.
"
" If you really need to modify a list in-place, you can use
" >
"   map({list}, 'function#Call({func}, [v:val])')
" <
function! function#Map(list, F) abort
  call ensure#IsList(a:list)
  return map(copy(a:list), 'function#Call(a:F, [v:val])')
endfunction


""
" @usage {list} {func}
" Applies {func} to each item in {list}, and removes those for which {func}
" returns 0. This is like |filter|, except {func} may be any maktaba callable
" and a new list is created. Unlike the builtin filter() function, {list} WILL
" NOT be modified in place.
"
" If you really need to filter a list in-place, you can use
" >
"   filter({list}, 'function#Call({func}, [v:val])')
" <
function! function#Filter(list, F) abort
  call ensure#IsList(a:list)
  return filter(a:list, 'function#Call(a:F, [v:val])')
endfunction


""
" @usage {list} {initial} {func}
" Reduces {list} to a single value, using {initial} and {func}.
" {func} must be a function that takes two values.
"
" First, {func} is applied to {initial} and the first item in {list}.
" Then, {func} is applied again to the first result and the second item in
" {list}, and so on. The final result is returned.
"
" If {list} is empty, {initial} will be returned.
function! function#Reduce(list, Initial, F) abort
  call ensure#IsList(a:list)
  let l:Value = a:Initial
  for l:Item in a:list
    let l:Value = function#Call(a:F, [l:Value, l:Item])
  endfor
  return l:Value
endfunction


""
" @usage {list} {func}
" Like @function(#Reduce), except {list} must be non-empty. The first item of
" {list} will be used as the initial value, the remainder of {list} will be
" reduced.
"
" @throws BadValue if {list} is empty.
function! function#Reduce1(list, F) abort
  call ensure#IsList(a:list)
  if empty(a:list)
    throw error#BadValue('Cannot Reduce1 an empty list.')
  endif
  return function#Reduce(a:list[1:], a:list[0], a:F)
endfunction


""
" @private
" Used as a bridge between #Sorted and sort().
function! function#DoSort(x, y) dict abort
  return function#Call(self.function, [a:x, a:y])
endfunction


""
" Sorts {list} IN PLACE, using {func} to determine the order of items in the
" list. {func} must take two arguments and return either 0 (if they are equal),
" 1 (if the first item comes after the second item), or -1 (if the second item
" comes after the first item).
"
" {list} is returned, for convenience.
"
" This is like the builtin |sort()| function, except {func} may be any maktaba
" callable.
function! function#Sort(list, F) abort
  call ensure#IsList(a:list)
  call ensure#IsCallable(a:F)
  return sort(a:list, 'function#DoSort', {'function': a:F})
endfunction


""
" Returns a new list that is a sorted copy of {list}. {func} is used to
" determine the sort order, as in |sort()|.
function! function#Sorted(list, F) abort
  return function#Sort(copy(a:list), a:F)
endfunction
