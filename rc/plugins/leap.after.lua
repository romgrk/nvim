#! /usr/bin/env lua
--
-- leap.after.lua
-- Copyright (C) 2022 romgrk <romgrk@dell-precision>
--
-- Distributed under terms of the MIT license.
--

local leap = require('leap')

local labels = {
  'f', 'j', 'd', 'k', 's', 'l', 'a', ';',
  'n', 'v', 'c', 'm', 'x',
  'q', 'w', 'u', 'i', 'o', 'e', 'r',
  'h', 'g'
}

leap.setup({
  labels = labels,
  safe_labels = {},
})

vim.api.nvim_create_user_command('LeapThisWindow',
  function()
    leap.leap { target_windows = { vim.api.nvim_get_current_win() } }
  end, {})

vim.api.nvim_set_keymap('n', '<Plug>(leap-this-window)',
  ':LeapThisWindow<CR>', { silent = true })
