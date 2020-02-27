
" URL encode a string. ie. Percent-encode characters as necessary.
function! url#encode(string)
    let result = ""

    let characters = split(a:string, '.\zs')
    for character in characters
        if character == " "
            let result = result . "+"
        elseif s:isURLEscaped(character)
            let i = 0
            while i < strlen(character)
                let byte = strpart(character, i, 1)
                let decimal = char2nr(byte)
                let result = result . "%" . printf("%02x", decimal)
                let i += 1
            endwhile
        else
            let result = result . character
        endif
    endfor

    return result
endfunction

" Returns 1 if the given character should be percent-encoded in a URL encoded
" string.
function! s:isURLEscaped(character)
    let ascii_code = char2nr(a:character)
    if ascii_code >= 48 && ascii_code <= 57
        return 0
    elseif ascii_code >= 65 && ascii_code <= 90
        return 0
    elseif ascii_code >= 97 && ascii_code <= 122
        return 0
    elseif a:character == "-" || a:character == "_" || a:character == "." || a:character == "~"
        return 0
    endif

    return 1
endfunction
