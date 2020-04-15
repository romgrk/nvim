
" mappings: ../../syntax/clap_input.vim

" 

let clap_enable_icon = 0

let clap_prompt_format = ' %provider_id%   '

let clap_forerunner_status_sign_running = '⧗ '
let clap_forerunner_status_sign_done    = '  '

let clap_current_selection_sign = { 'text': '➔ ', 'texthl': 'ClapCurrentSelection', 'linehl': 'ClapCurrentSelection' }

let clap_provider_session = {
\ 'source': {-> xolox#session#complete_names('', 0, 0)},
\ 'sink': 'OpenSession',
\ }
