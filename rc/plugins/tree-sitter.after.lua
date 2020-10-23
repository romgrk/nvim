
local configs = require('nvim-treesitter.configs')

-- Available tags:
--   @block.inner
--   @block.outer
--   @call.inner
--   @call.outer
--   @class.inner
--   @class.outer
--   @comment.outer
--   @conditional.inner
--   @conditional.outer
--   @function.inner
--   @function.outer
--   @loop.inner
--   @loop.outer
--   @parameter.inner
--   @statement.outer

configs.setup {
  ensure_installed = 'all',     -- one of 'all', 'language', or a list of languages

  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {  },  -- list of language that will be disabled
    use_languagetree = true,
  },

  incremental_selection = {
    enable = false,
    keymaps = {
      init_selection    = 'grn',
      node_incremental  = 'grn',
      scope_incremental = 'grc',
      node_decremental  = 'grm',
    },
  },

  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["am"] = "@function.outer",
        ["im"] = "@function.inner",
        ["a<A-f>"] = "@function.outer",
        ["i<A-f>"] = "@function.inner",
        ["af"] = "@call.outer",
        ["if"] = "@call.inner",
        ["a<A-b>"] = "@block.outer",
        ["i<A-b>"] = "@block.inner",
        ["a<A-c>"] = "@class.outer",
        ["i<A-c>"] = "@class.inner",

        -- Or you can define your own textobjects like this
        ["iF"] = {
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
          java = "(method_declaration) @function",
        },
      },

      move = {
        enable = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },

      swap = {
        enable = false,
        -- swap_next = {
        --   ["<leader>a"] = "@parameter.inner",
        -- },
        -- swap_previous = {
        --   ["<leader>A"] = "@parameter.inner",
        -- },
      },

      lsp_interop = {
        enable = false,
        -- peek_definition_code = {
        --   ["df"] = "@function.outer",
        --   ["dF"] = "@class.outer",
        -- },
      },
    },
  },
}
