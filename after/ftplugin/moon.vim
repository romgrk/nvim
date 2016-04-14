
setlocal foldmethod=expr
setlocal foldexpr=GetIndentFold(v:lnum)

" Reuse coffeescript SJs
let b:splitjoin_join_callbacks  = ['sj#coffee#JoinString', 'sj#coffee#JoinFunction', 'sj#coffee#JoinIfElseClause', 'sj#coffee#JoinIfClause', 'sj#coffee#JoinObjectLiteral']
let b:splitjoin_split_callbacks = ['sj#coffee#SplitTernaryClause', 'sj#coffee#SplitTripleString', 'sj#coffee#SplitString', 'sj#coffee#SplitFunction', 'sj#coffee#SplitIfClause', 'sj#coffee#SplitObjectLiteral']


let s:width = 80

function! MoonCommentSep(...)
    let num = 0 < a:0 ? a:1 : 1
    let sep = repeat('-', s:width) . "\n"
    return repeat(sep, num)
endfunction

nnoremap <buffer><silent> --- "=MoonCommentSep()<CR>p
nnoremap <buffer><silent> --s "=MoonCommentSep(2)<CR>po--<Space>

nnoremap <buffer><F1> :g/debug/d<CR>

"nmap <buffer><A-i> :CtrlPFunky<CR>

