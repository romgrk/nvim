" File: call.vimI
" Author: romgrk
" Date: 02 Feb 2016
" Description: ...
" !::exe [SO]

if (!exists('g:ff') || get(g:, 'debug')==1)
    unlet! ff
    let ff = {}
    let ff['res']      = []
    let ff['defaults'] = {}
end

" Commands:
com! -nargs=* -bang -complete=expression F     <line1>,<line2>call ParseCall('<bang>', <f-args>)
com! -nargs=* -bang -complete=expression Fn    <line1>,<line2>call ParseCall('<bang>', <f-args>)
com! -nargs=* -bang -complete=expression Fcall <line1>,<line2>call ParseCall('<bang>', <f-args>)

" Generates a function-call from the given arguments
func! ParseCall (bang, ...)
    let ff = get(g:, 'ff', {})
    let hasBang    = (a:bang == '!' ? 1 : 0)

    let funcID   = substitute(a:000[0], '()$', '', '')
    let args     = s:parseBinding(a:000[1:])
    let n        = len(args)

    let fcall = funcID . '(' . join(args, ', ') . ')'

    call <SID>printFcall(funcID, args)
    call pp#hl('Comment', 'args:' . a:0 . ' n:' . n)

    let res = eval(fcall)

    if !empty(res)
        Print res
    end

    if !empty(ff.bindTo)
        if ff.bindTo[0] == '@'
            call setreg(ff.bindTo[1], string(res))
        else
            let {ff.bindTo} = res
        end
    else
        unlet! g:res
        let g:res = res
    end
    call add(ff['res'], g:res)
endfu

" Parses the list. If it finds a binding, removes it.
" In any case, return the list.
fu! s:parseBinding (list)
    let ff = get(g:, 'ff', {})
    let ff.bindTo = ''
    let list = a:list
    let n    = len(list)

    for idx in range(n)
        let val = list[idx]
        if (val == '>')
            let ff.bindTo = 'g:' . remove(list, idx + 1)
            call remove(list, idx)
            break
        elseif (val =~# '^>')
            let ff.bindTo = 'g:' . remove(list, idx)[1:]
            break
        elseif (val =~# '^@.$')
            let ff.bindTo = remove(list, idx)
            break
        end
    endfor

    call Log(ff.bindTo)
    return list
endfu

" Printing stuff
fu! s:printFcall (funcID, args)
    let n = len(a:args)
    call pp#hl('Statement', 'call ')
    call pp#echo('Function', a:funcID)
    call pp#sep('(')
    for idx in range(n)
        call pp#echo('Identifier', a:args[idx])
        if (idx+1 < n)
            call pp#sep(', ')
        end
    endfor
    call pp#echo('Delimiter', ") ")
endfu


