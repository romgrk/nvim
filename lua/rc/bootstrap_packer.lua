#! /usr/bin/env lua
--
-- bootstrap_packer.lua
-- Copyright (C) 2022 romgrk <romgrk@dell-precision>
--
-- Distributed under terms of the MIT license.
--

local vim = vim
local glob = vim.fn.glob
local empty = vim.fn.empty
local system = vim.fn.system
local stdpath = vim.fn.stdpath
local utils = require('rc.utils')
local join = utils.join

-- Bootstrap packer, if required
function bootstrap_packer()
  local install_path = join(stdpath('data'), 'site/pack/packer/start/packer.nvim')
  local packer_bootstrap = nil
  if empty(glob(install_path)) > 0 then
    packer_bootstrap = system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  end
  return packer_bootstrap
end

return bootstrap_packer
