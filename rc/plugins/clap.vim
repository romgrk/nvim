
" mappings: ../../syntax/clap_input.vim

let clap_layout = {
  \ 'relative': 'editor',
  \ 'row': '10%',
  \}
let clap_enable_icon = 0
let clap_prompt_format = ' %provider_id%   '
let clap_current_selection_sign = { 'text': '  ', 'texthl': 'ClapCurrentSelection', 'linehl': 'ClapCurrentSelection' }
let clap_forerunner_status_sign_running = '⧗ '
let clap_forerunner_status_sign_done    = '  '

"
" Custom providers
"

let clap_provider_session = {
\ 'source': {-> xolox#session#complete_names('', 0, 0)},
\ 'sink': 'OpenSession',
\}

let clap_provider_note = {
\ 'source': {-> xolox#notes#cmd_complete('', 'Note ', 0)},
\ 'sink': 'Note',
\}

"
" Highlight
"

hi! link ClapCurrentSelection Visual
hi! link ClapPopupCursor      Visual

" window backgrounds
hi! link ClapInput            NormalPopup
hi! link ClapSearchText       NormalPopup
hi! link ClapDisplay          NormalPopover
hi! link ClapPreview          NormalPopover

hi! link ClapSpinner          TabLine
hi! link ClapQuery            Normal
hi! link ClapSelected         PmenuSel
hi! link ClapCurrentSelection PmenuSel
hi! link ClapDefaultSelected  PmenuSel
hi! link ClapDefaultCurrentSelection PmenuSel

" Name of file/tag
hi! link ClapFile             Directory
hi! link ClapVistaTag         ClapFile

hi! link ClapBlines       TextNormal
hi! link ClapBlinesLineNr Comment

hi! link ClapLinesBufnr   Comment
hi! link ClapLinesBufname Directory

" Matches
hi! link ClapMatches        EasyMotionTargetDefault
hi! link ClapMatches1       EasyMotionTargetDefault
hi! link ClapMatches2       EasyMotionTargetDefault
hi! link ClapMatches3       EasyMotionTargetDefault
hi! link ClapMatches4       EasyMotionTargetDefault
hi! link ClapMatches5       EasyMotionTargetDefault
hi! link ClapMatches6       EasyMotionTargetDefault
hi! link ClapMatches7       EasyMotionTargetDefault
hi! link ClapMatches8       EasyMotionTargetDefault
hi! link ClapMatches9       EasyMotionTargetDefault
hi! link ClapMatches10      EasyMotionTargetDefault
hi! link ClapFuzzyMatches1  EasyMotionTargetDefault
hi! link ClapFuzzyMatches2  EasyMotionTargetDefault
hi! link ClapFuzzyMatches3  EasyMotionTargetDefault
hi! link ClapFuzzyMatches4  EasyMotionTargetDefault
hi! link ClapFuzzyMatches5  EasyMotionTargetDefault
hi! link ClapFuzzyMatches6  EasyMotionTargetDefault
hi! link ClapFuzzyMatches7  EasyMotionTargetDefault
hi! link ClapFuzzyMatches8  EasyMotionTargetDefault
hi! link ClapFuzzyMatches9  EasyMotionTargetDefault
hi! link ClapFuzzyMatches10 EasyMotionTargetDefault
