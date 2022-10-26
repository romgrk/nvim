let s:bufnr = bufnr(0)
func RustFiletypeSetup(timer)
    call extend(b:splitjoin_split_callbacks, [
        \ 'sj#js#SplitArgs',
        \ 'sj#js#SplitObjectLiteral',
        \ ])

    call extend(b:splitjoin_join_callbacks, [
        \ 'sj#js#JoinArgs',
        \ 'sj#js#JoinObjectLiteral',
        \ ])
endfunc
let timer = timer_start(200, 'RustFiletypeSetup', {'repeat': 1})

" if !exists('b:splitjoin_split_callbacks')
"   let b:splitjoin_split_callbacks = [
"       \ 'sj#js#SplitFunction',
"         \ 'sj#js#SplitObjectLiteral',
"         \ 'sj#js#SplitFatArrowFunction',
"         \ 'sj#js#SplitArray',
"         \ 'sj#js#SplitOneLineIf',
"         \ 'sj#js#SplitArgs',
"         \ ]
" endif
"
" if !exists('b:splitjoin_join_callbacks')
"   let b:splitjoin_join_callbacks = [
"         \ 'sj#js#JoinFatArrowFunction',
"         \ 'sj#js#JoinArray',
"         \ 'sj#js#JoinArgs',
"         \ 'sj#js#JoinFunction',
"         \ 'sj#js#JoinOneLineIf',
"         \ 'sj#js#JoinObjectLiteral',
"         \ ]
" endif
