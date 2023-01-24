
" mappings: ../../syntax/clap_input.vim

let clap_layout = {
  \ 'relative': 'editor',
  \ 'row': '10%',
  \}
let clap_enable_icon = 0
" let clap_prompt_format = ' %provider_id%   '
" let clap_current_selection_sign = { 'text': '  ', 'texthl': 'ClapCurrentSelection', 'linehl': 'ClapCurrentSelection' }
" let clap_forerunner_status_sign_running = ' '
" let clap_forerunner_status_sign_done    = '  '

let clap_always_open_preview = v:false
let clap_preview_direction = 'UD'
let clap_popup_border = v:null
let clap_enable_background_shadow = v:false


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

let clap_provider_git_branch = {
\ 'source': {-> fugitive#CompleteObject('', '', '')},
\ 'sink': 'Git checkout',
\}

let clap_provider_npm = {
\ 'source': {-> s:npm_list_scripts()},
\ 'sink': 'NpmRun',
\}

let clap_provider_browser_history = {
\ 'source': {-> v:lua.browser_history_get()},
\ 'sink': {url -> v:lua.browser_history_open(url)},
\}

" NPM run scripts provider {{{

function! s:npm_list_scripts()
  let project_root = getcwd()
  let directory = project_root

  if !filereadable(directory . '/package.json')
    let directory = expand('%:p:h')
    while !filereadable(directory . '/package.json')
          \ && directory != project_root
          \ && directory != '/'
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

" }}}


"
" Highlight
"

augroup clap_settings
  au!
  au ColorScheme *      call s:update_highlights()
  au User PluginsLoaded call s:update_highlights()
augroup END

function s:update_highlights()
  " window backgrounds
  hi! link ClapSpinner          NormalPopupPrompt
  hi! link ClapInput            NormalPopup
  hi! link ClapIndicator        NormalPopupSubtle
  hi! link ClapSearchText       NormalPopup
  hi! link ClapDisplay          NormalPopover
  hi! link ClapPreview          Normal

  hi! link ClapQuery            Normal
  hi! link ClapSelected         Visual
  hi! link ClapCurrentSelection Visual
  hi! link ClapPopupCursor      Visual

  " Name of file/tag
  hi! link ClapFile             File
  hi! link ClapDir              Directory
  hi! link ClapVistaTag         ClapFile

  hi! link ClapBlines       TextNormal
  hi! link ClapBlinesLineNr Comment

  hi! link ClapLinesBufnr   Comment
  hi! link ClapLinesBufname Directory
endfunc

" Matches
" hi! link ClapMatches        EasyMotionTargetDefault
" hi! link ClapMatches1       EasyMotionTargetDefault
" hi! link ClapMatches2       EasyMotionTargetDefault
" hi! link ClapMatches3       EasyMotionTargetDefault
" hi! link ClapMatches4       EasyMotionTargetDefault
" hi! link ClapMatches5       EasyMotionTargetDefault
" hi! link ClapMatches6       EasyMotionTargetDefault
" hi! link ClapMatches7       EasyMotionTargetDefault
" hi! link ClapMatches8       EasyMotionTargetDefault
" hi! link ClapMatches9       EasyMotionTargetDefault
" hi! link ClapMatches10      EasyMotionTargetDefault
" hi! link ClapMatches11      EasyMotionTargetDefault
" hi! link ClapFuzzyMatches1  EasyMotionTargetDefault
" hi! link ClapFuzzyMatches2  EasyMotionTargetDefault
" hi! link ClapFuzzyMatches3  EasyMotionTargetDefault
" hi! link ClapFuzzyMatches4  EasyMotionTargetDefault
" hi! link ClapFuzzyMatches5  EasyMotionTargetDefault
" hi! link ClapFuzzyMatches6  EasyMotionTargetDefault
" hi! link ClapFuzzyMatches7  EasyMotionTargetDefault
" hi! link ClapFuzzyMatches8  EasyMotionTargetDefault
" hi! link ClapFuzzyMatches9  EasyMotionTargetDefault
" hi! link ClapFuzzyMatches10 EasyMotionTargetDefault
" hi! link ClapFuzzyMatches11 EasyMotionTargetDefault

" let clap_fuzzy_match_hl_groups = [
" \ [196 , '#cc0000'] ,
" \ [196 , '#cc0000'] ,
" \ [196 , '#cc0000'] ,
" \ [196 , '#cc0000'] ,
" \ [196 , '#cc0000'] ,
" \ [196 , '#cc0000'] ,
" \ [196 , '#cc0000'] ,
" \ [196 , '#cc0000'] ,
" \ [196 , '#cc0000'] ,
" \ [196 , '#cc0000'] ,
" \ [196 , '#cc0000'] ,
" \ [196 , '#cc0000'] ,
" \ ]
