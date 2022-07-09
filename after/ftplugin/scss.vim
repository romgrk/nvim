let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
exe printf('source %s/css.vim', s:path)
