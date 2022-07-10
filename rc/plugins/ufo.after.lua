
local ufo = require('ufo')

ufo.setup({
  open_fold_hl_timeout = 0,
})

vim.keymap.set('n', 'zr', ufo.openAllFolds)
vim.keymap.set('n', 'zm', ufo.closeAllFolds)
