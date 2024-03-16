require('spectre').setup({
  color_devicons = true,
  open_cmd = 'leftabove vnew | wincmd H | vertical resize 60 | setlocal nonumber',
  mapping={
    ['close'] = {
        map = "q",
        cmd = "<cmd>wincmd c<CR>",
        desc = "close window"
    },
    ['toggle_line'] = {
        map = "d",
        cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
        desc = "toggle item"
    },
  },
  default = {
      find = {
          cmd = "rg",
          options = {}
      },
      replace={
          cmd = "sed"
      }
  },
})
