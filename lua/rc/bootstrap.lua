local vim = vim

local function bootstrap()
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  local did_bootstrap = false
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    })
    did_bootstrap = true
  end
  vim.opt.rtp:prepend(lazypath)
  return did_bootstrap
end

return bootstrap
