#! /usr/bin/env lua
--
-- context.after.lua
-- Copyright (C) 2021 romgrk <romgrk@dell-precision>
--
-- Distributed under terms of the MIT license.
--

require('treesitter-context').setup({
  mode = 'topline',
  line_numbers = true,
  max_lines = 8,
  multiwindow = true,
})
