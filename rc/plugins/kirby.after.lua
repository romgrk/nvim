--
-- kirby.after.lua
--

local kirby = require('kirby')


kirby.register({
  id = 'git-branch',
  name = 'Git checkout',
  values = function() return vim.fn['fugitive#CompleteObject']('', ' ', '') end,
  onAccept = 'Git checkout',
})

kirby.register({
  id = 'session',
  name = 'Open session',
  values = function() return vim.fn['xolox#session#complete_names']('', 'OpenSession ', 0) end,
  onAccept = 'OpenSession',
})

kirby.register({
  id = 'note',
  name = 'Open note',
  values = function() return vim.fn['xolox#notes#cmd_complete']('', 'Note ', 0) end,
  onAccept = 'Note',
})

kirby.register({
  id = 'browser-history',
  values = function() return _G.browser_history_get() end,
  onAccept = function(_, entry)
    browser_history_open(entry.value)
  end ,
})


-- let clap_provider_note = {
-- \ 'source': {-> xolox#notes#cmd_complete('', 'Note ', 0)},
-- \ 'sink': 'Note',
-- \}
--
-- let clap_provider_git_branch = {
-- \ 'source': {-> fugitive#CompleteObject('', '', '')},
-- \ 'sink': 'Git checkout',
-- \}
--
-- let clap_provider_npm = {
-- \ 'source': {-> s:npm_list_scripts()},
-- \ 'sink': 'NpmRun',
-- \}
--
-- let clap_provider_browser_history = {
-- \ 'source': {-> v:lua.browser_history_get()},
-- \ 'sink': {url -> v:lua.browser_history_open(url)},
-- \}
--
