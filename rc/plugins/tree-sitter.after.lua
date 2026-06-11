-- nvim-treesitter `main` branch.
--
-- On `main` there is no `require('nvim-treesitter.configs').setup{}`:
--   * grammars are installed via `install()` / `:TSInstall <lang>`
--   * highlighting is started per-buffer with `vim.treesitter.start()`
--     (no `highlight = { enable = true }` module anymore)
--   * folds are wired globally in rc/settings.vim via
--     `set foldexpr=v:lua.vim.treesitter.foldexpr()`

local langs = {
  'javascript',
  'typescript',
  'tsx',
  'lua',
  'c',
  'cpp',
  'rust',
}

require('nvim-treesitter').install(langs)

-- Start highlighting for any buffer whose filetype has an installed parser.
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('rc_treesitter', { clear = true }),
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
