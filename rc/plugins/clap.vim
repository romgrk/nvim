
" mappings: ../../syntax/clap_input.vim

let clap_layout = {
  \ 'relative': 'editor',
  \ 'row': '10%',
  \}
let clap_enable_icon = 1
let clap_prompt_format = ' %provider_id%   '
let clap_current_selection_sign = { 'text': '  ', 'texthl': 'ClapCurrentSelection', 'linehl': 'ClapCurrentSelection' }
let clap_forerunner_status_sign_running = ' '
let clap_forerunner_status_sign_done    = '  '

"
" Custom providers
"

let clap_provider_session = {
\ 'source': {-> xolox#session#complete_names('', 'OpenSession ', 0)},
\ 'sink': 'OpenSession',
\}

let clap_provider_note = {
\ 'source': {-> xolox#notes#cmd_complete('', 'Note ', 0)},
\ 'sink': 'Note',
\}

let clap_provider_todoist = {
\ 'source': {-> Todoist__listProjects()},
\ 'sink': 'Todoist',
\}

let clap_provider_git_branch = {
\ 'source': {-> fugitive#CompleteObject('', '', '')},
\ 'sink': 'Git checkout',
\}

let clap_provider_npm = {
\ 'source': {-> s:npm_list_scripts()},
\ 'sink': 'NpmRun',
\}

function! s:npm_list_scripts()
  let project_root = getcwd()
  let directory = project_root

  if !filereadable(directory . '/package.json')
    let directory = expand('%:p:h')
    while !filereadable(directory . '/package.json')
          \ && directory != project_root
          \ && directory != '/'
      echom directory
      let directory = fnamemodify(directory, ':h')
    endwhile
  end
  if !filereadable(directory . '/package.json')
    return []
  end
  let package = json_decode(readfile(directory . '/package.json'))
  let scripts = get(package, 'scripts', {})
  let items = []
  let max_length = 0
  for key in keys(scripts)
    call add(items, #{ name: key, command: scripts[key] })
    if len(key) > max_length
      let max_length = len(key)
    end
  endfor
  let max_length = max_length + 1
  return map(items, {key, val -> printf('%-' . max_length . 's # %s', val.name, val.command)})
endfunc



"
" Highlight
"

hi! link ClapCurrentSelection Visual
hi! link ClapPopupCursor      Visual

" window backgrounds
hi! link ClapInput            NormalPopup
hi! link ClapSearchText       NormalPopup
hi! link ClapDisplay          NormalPopover
hi! link ClapPreview          Normal

hi! link ClapSpinner          TabLine
hi! link ClapQuery            Normal
hi! link ClapSelected         PmenuSelBold
hi! link ClapCurrentSelection PmenuSelBold
hi! link ClapDefaultSelected  PmenuSelBold
hi! link ClapDefaultCurrentSelection PmenuSelBold

" Name of file/tag
hi! link ClapFile             File
hi! link ClapDir              Directory
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
hi! link ClapMatches11      EasyMotionTargetDefault
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
hi! link ClapFuzzyMatches11 EasyMotionTargetDefault

let clap_fuzzy_match_hl_groups = [
\ [196 , '#FF0000'] ,
\ [196 , '#FF0000'] ,
\ [196 , '#FF0000'] ,
\ [196 , '#FF0000'] ,
\ [196 , '#FF0000'] ,
\ [196 , '#FF0000'] ,
\ [196 , '#FF0000'] ,
\ [196 , '#FF0000'] ,
\ [196 , '#FF0000'] ,
\ [196 , '#FF0000'] ,
\ [196 , '#FF0000'] ,
\ [196 , '#FF0000'] ,
\ ]
