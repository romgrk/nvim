
local configs = require('nvim-treesitter.configs')

configs.setup {
  ensure_installed = 'all',     -- one of 'all', 'language', or a list of languages

  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {  },  -- list of language that will be disabled
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection    = '<C-r>n',
      node_incremental  = '<C-r>n',
      scope_incremental = '<C-r>c',
      node_decremental  = '<C-r>m',
    },
  },

}
