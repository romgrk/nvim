" !::exe [so %]
let zv_file_types = {
\ 'cpp'                   : 'c++',
\ 'cc'                    : 'c++',
\ '^(G|g)runtfile\.'      : 'grunt',
\ '^(G|g)ulpfile\.'       : 'gulp',
\ '.htaccess'             : 'apache_http_server',
\ '^(md|mdown|mkd|mkdn)$' : 'markdown',
\ 'css'                   : 'css,foundation,bootstrap_4',
\ 'python'                : 'python 3',
\ 'ruby'                  : 'ruby,ruby 2',
\ }
let zv_docsets_dir = '~/.local/share/Zeal/Zeal/docsets'
