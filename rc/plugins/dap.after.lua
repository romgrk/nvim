local dap = require('dap')
local ui = require('dapui')
require'nvim-dap-virtual-text'

---
-- General options
---

vim.fn.sign_define('DapStopped',            {text='',  linehl='DapCurrentLine', numhl='DapCurrentLineNum', texthl='DapCurrentLineNum'})
vim.fn.sign_define('DapBreakpoint',         {text='●',  linehl='',               numhl='DapBreakpointNum',  texthl='DapBreakpointNum'})
vim.fn.sign_define('DapLogPoint',           {text='●',  linehl='',               numhl='DapLogpointNum',    texthl='DapLogpointNum'})
vim.fn.sign_define('DapBreakpointRejected', {text='❓', linehl='',               numhl='',                  texthl=''})


-- Enable virtual text
vim.g.dap_virtual_text = true
-- Disable exceptions error text
require'dap'.listeners.after.exceptionInfo['nvim-dap-virtual-text'] = function() end

-- Configure UI
ui.setup({
  icons = { expanded = '▾', collapsed = '▸' },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { '<CR>', '<2-LeftMouse>' },
    open = 'o',
    remove = 'd',
    edit = 'e',
    repl = 'r',
  },
  sidebar = {
    open_on_start = true,
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with 'id' and 'size' keys
      {
        id = 'scopes',
        size = 0.25, -- Can be float or integer > 1
      },
      { id = 'breakpoints', size = 0.25 },
      { id = 'stacks', size = 0.25 },
      { id = 'watches', size = 00.25 },
    },
    width = 40,
    position = 'left', -- Can be 'left' or 'right'
  },
  tray = {
    open_on_start = true,
    elements = { 'repl' },
    height = 10,
    position = 'bottom', -- Can be 'bottom' or 'top'
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    mappings = {
      close = { 'q', '<Esc>' },
    },
  },
  windows = { indent = 1 },
})


---
-- Adapters
---

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode',
  name = 'lldb'
}

---
-- Configurations
---

local last_cpp_program = nil
local last_cpp_args = nil

dap.configurations.cpp = {
  {
    name = 'Launch C++ program',
    type = 'lldb',
    request = 'launch',
    program = function()
      local result = vim.fn.input('Program: ', last_cpp_program or '', 'file')
      last_cpp_program = result
      return result
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = function()
      local result = vim.fn.input('Arguments: ', last_cpp_args or '')
      last_cpp_args = result
      return vim.split(result, ' +')
    end,

    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    runInTerminal = false,
  },
}
