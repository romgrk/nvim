
setlocal path+=lib/,./node_modules/;~

setlocal suffixesadd=.js,.coffee
setlocal include=require(\?'\zs.*\ze'
"setlocal includeexpr=v:fname.'.js'

fu! FindNodeMain ()
endfu
