local sidebar = require('sidebar-nvim')
local view = require('sidebar-nvim.view')
local bufferline = require('bufferline.state')

sidebar.setup({
  open = true,
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
    'diagnostics',
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
  bindings = {
    ['q'] = function()
      bufferline.set_offset(0)
      sidebar.close()
    end,
  },
})

vim.api.nvim_create_user_command('TreeToggle', function()
 if sidebar.is_open() then
    bufferline.set_offset(0)
    sidebar.close()
  else
    bufferline.set_offset(view.View.width, '', 'SidebarNvimNormal')
    sidebar.open()
  end
end, {})
