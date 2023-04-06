local sidebar = require('sidebar-nvim')
local view = require('sidebar-nvim.view')
local barbar = require('barbar.api')

sidebar.setup({
  -- open = vim.fn.argc() == 0,
  open = false,
  disable_default_keybindings = 0,
  side = 'left',
  initial_width = 35,
  hide_statusline = false,
  update_interval = 1000,
  -- sections = {
  --   'datetime',
  --   'buffers',
  --   'git',
  --   'diagnostics',
  --   'todos',
  --   'files',
  -- },
  sections = {
    'git',
    -- 'diagnostics',
    'files',
    'todos',
  },
  section_separator = function()
    return {
      '',
      string.rep('─', view.View.width),
      '',
    }
  end,
  section_title_separator = {''},
  containers = {
    attach_shell = '/bin/sh', show_all = true, interval = 5000,
  },
  todos = { ignored_paths = { '~' } },
  diagnostics = {
    default_open = false,
  },
  bindings = {
    ['q'] = function()
      barbar.set_offset(0)
      sidebar.close()
    end,
  },
})

vim.api.nvim_create_user_command('TreeToggle', function()
 if sidebar.is_open() then
    barbar.set_offset(0)
    sidebar.close()
  else
    barbar.set_offset(view.View.width, '', 'SidebarNvimNormal')
    sidebar.open()
  end
end, {})
