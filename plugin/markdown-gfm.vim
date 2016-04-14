" !::exe [so %]

function! GFM()
  "let langs = ['ruby', 'yaml', 'vim', 'c']
  let lastLine = getline('$')
  if lastLine =~# 'lang'
    let langs = split(substitute(lastLine, '^.\+lang:', '', ''), '\W\+')
  else
    let langs = get(b:, 'mkd_langs', ['vim'])
  end

  call Warning('Included syntaxes: ', langs)

  for lang in langs
    unlet b:current_syntax
    silent! exec printf("syntax include @%s syntax/%s.vim", lang, lang)
    exec printf("syntax region %sSnip matchgroup=Snip start='```%s' end='```' contains=@%s",
                \ lang, lang, lang)
  endfor
  let b:current_syntax='mkd'

  syntax sync fromstart
endfunction

