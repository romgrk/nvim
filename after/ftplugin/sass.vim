
setlocal sw=2
setlocal fdm=marker
setlocal isk+=-,$

au BufEnter *.sass exe ":ColorHighlight"

iabbrev <buffer> dib display: inline-block
