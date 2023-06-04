require'barbar'.setup({
  maximum_padding = 6,

  icons = {
    -- Configure the base icons on the bufferline.
    buffer_index = false,
    buffer_number = false,
    button = false, -- '×',
    modified = { button = false }, -- { button = '●' },

    separator = { left = '▎', right = '' },

    -- -- Configure the icons on the bufferline when modified or pinned.
    -- -- Supports all the base icon options.
    -- modified = {button = '●'},
    -- pinned = {button = '車', filename = true, separator = {right = ''}},
    --
    -- -- Configure the icons on the bufferline based on the visibility of a buffer.
    -- -- Supports all the base icon options, plus `modified` and `pinned`.
    -- alternate = {filetype = {enabled = false}},
    -- current = {buffer_index = true},
    -- inactive = {button = '×'},
    -- visible = {modified = {buffer_number = false}},
  },
})
