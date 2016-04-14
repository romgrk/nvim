
" @param String text
fu! search#Word (...)
    let word = get(a:, 1, expand('<cword>'))
    let @/='\<' . word .'\>'
    set hls
    return @/
endfu

" @param String text
fu! search#Text (...)
    let string = a:1
    let @/='\V' . escape(string, '\/')
    set hls
    return @/
endfu

" @param String pattern
fu! search#Pattern (...)
    let patt = _#isString(a:1) ?  a:1 : a:000[1]
    let @/='\v' . patt
    set hls
    if (a:0 > 1)
        return string(a:000[1:])
    end
    return @/
endfu
