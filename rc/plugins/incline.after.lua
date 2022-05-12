require('incline').setup({
 window = {
    margin = {
      horizontal = {
        left  = 1,
        right = 0
      },
      vertical = {
        bottom = 0,
        top = 1
      },
    },
    options = {
      signcolumn = 'no',
      wrap = false
    },
    padding = {
      left  = 1,
      right = 1
    },
    padding_char = ' ',
    placement = {
      horizontal = 'right',
      vertical = 'top',
    },
    width = 'fit',
    winhighlight = {
      active = {
        EndOfBuffer = 'None',
        Normal = 'InclineNormal',
        Search = 'None'
      },
      inactive = {
        EndOfBuffer = 'None',
        Normal = 'InclineNormalNC',
        Search = 'None'
      }
    },
    zindex = 50,
  },
})
