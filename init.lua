--
-- init.lua
--

-- TODO https://github.com/rmehri01/onenord.nvim
-- TODO https://github.com/folke/edgy.nvim
-- TODO https://github.com/Bekaboo/dropbar.nvim
-- TODO https://github.com/ggandor/leap-spooky.nvim
-- TODO https://github.com/ggandor/flit.nvim
-- TODO https://github.com/DNLHC/glance.nvim
-- TODO https://github.com/Wansmer/treesj
-- TODO https://github.com/Wansmer/sibling-swap.nvim
-- TODO https://github.com/smjonas/live-command.nvim
-- TODO consider https://git.sr.ht/~whynothugo/lsp_lines.nvim
-- TODO install https://github.com/GustavoKatel/sidebar.nvim
-- TODO install https://github.com/anuvyklack/hydra.nvim
-- TODO install https://github.com/RRethy/nvim-treesitter-textsubjects
-- TODO install https://github.com/abecodes/tabout.nvim
-- TODO install https://github.com/pwntester/octo.nvim when working
-- TODO install https://github.com/tanvirtin/vgit.nvim
-- TODO install https://github.com/kevinhwang91/nvim-bqf
-- TODO install https://github.com/stevearc/qf_helper.nvim
-- TODO install https://github.com/machakann/vim-sandwich
-- TODO install https://github.com/rhysd/vim-operator-surround
-- TODO install https://github.com/fannheyward/coc-react-refactor
-- TODO install https://github.com/nvim-treesitter/nvim-treesitter-refactor
-- TODO install https://github.com/nvim-treesitter/nvim-treesitter-textobjects
-- TODO install https://github.com/folke/twilight.nvim
-- TODO checkout https://github.com/folke/trouble.nvim

local vim = vim

-- Fancy lua loader
vim.loader.enable()

local api = vim.api
local glob = vim.fn.glob
local stdpath = vim.fn.stdpath
local filereadable = vim.fn.filereadable
local nvim_create_augroup = api.nvim_create_augroup
local nvim_create_autocmd = api.nvim_create_autocmd
local utils = require('rc.utils')
local bootstrap = require('rc.bootstrap')
local join = utils.join
local split = vim.split
local load = utils.load

-- Bootstrap lazy, if required
bootstrap()

--
-- Settings
--

vim.cmd [[let $vim = stdpath('config')]]

load('./rc/settings.vim')
load('./rc/plugins.vim')

local plugin_settings = split(glob(join(stdpath('config'), '/rc/plugins/*')), '\n')

-- Plugin settings (before loading)
for _, file in ipairs(plugin_settings) do
  if not string.find(file, '.after.') then
    load(file)
  end
end

require('lazy').setup({
  -- Libraries
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'itchyny/vim-gitbranch' },

  -- Editing
  { 'nvim-treesitter/nvim-treesitter' },
  { 'nvim-treesitter/playground' },
  { 'nvim-treesitter/nvim-treesitter-context', dev = true },
  { 'JoosepAlviste/nvim-ts-context-commentstring' },
  { 'AndrewRadev/sideways.vim' },
  { 'AndrewRadev/splitjoin.vim' },
  { 'chrisgrieser/nvim-spider', lazy = true },
  { 'coderifous/textobj-word-column.vim' },
  { 'm4xshen/autoclose.nvim', init = function() require'autoclose'.setup() end },
  { 'romgrk/vim-sneak' },
  { 'ggandor/leap.nvim' },
  { 'kana/vim-niceblock' },
  { 'Konfekt/vim-ctrlxa' },
  { 'michaeljsmith/vim-indent-object' },
  { 'neoclide/coc.nvim', build = 'yarn install' },
  { 'numToStr/Comment.nvim' },
  { 'sirver/UltiSnips' },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-surround' },
  { 'wellle/targets.vim' },

  -- General
  -- @plugins
  {
    'MagicDuck/grug-far.nvim',
    opts = {
      wrap = false,
      windowCreationCommand = 'aboveleft vsplit | wincmd H | vertical resize 80',
      resultLocation = {
        showNumberLabel = false,
      }
    },
  },
  { 'projekt0n/github-nvim-theme'},
  { 'justinmk/vim-dirvish' },
  { 'fidian/hexmode' },
  { 'jbyuki/venn.nvim' },
  { 'ruanyl/vim-gh-line' },
  { 'wellle/visual-split.vim' },
  { 'aperezdc/vim-template' },
  { 'bfredl/nvim-miniyank' },
  { 'junegunn/vim-easy-align' },
  { 'liuchengxu/vim-clap', build = ':Clap install-binary!' },
  { 'liuchengxu/vista.vim' },
  { 'MarcWeber/vim-addon-local-vimrc' },
  { 'tpope/vim-eunuch' },
  { 'tpope/vim-sleuth' },
  { 'vn-ki/coc-clap' },
  { 'wsdjeg/vim-fetch' },
  { 'xolox/vim-misc'},
  { 'xolox/vim-notes', dependencies = { 'xolox/vim-misc' } },
  { 'xolox/vim-shell', dependencies = { 'xolox/vim-misc' } },
  { 'romgrk/vim-session', dependencies = { 'xolox/vim-misc' } },

  -- UI
  { 'sindrets/diffview.nvim' },
  { 'sidebar-nvim/sidebar.nvim', dev = true },
  { 'VonHeikemen/searchbox.nvim', dependencies = { { 'MunifTanjim/nui.nvim', dev = true } }, dev = true },
  { 'rhysd/git-messenger.vim' },
  { 'KabbAmine/vCoolor.vim' },
  { 'machakann/vim-highlightedyank' },
  { 'RRethy/vim-hexokinase'                , build = 'make hexokinase' },
  { 'airblade/vim-gitgutter' },
  { 'yorickpeterse/nvim-pqf', init = function() require'pqf'.setup() end },
  { 'akinsho/nvim-toggleterm.lua' },
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = { indent = { char = '▏', }, scope = { enabled = true, char = '▏', show_start = false, show_end = false, }, } },

  -- Personal
  { 'romgrk/kyntell.vim', dev = true, lazy = false, priority = 1000 },
  { 'romgrk/doom-one.vim', dev = true, lazy = false, priority = 1000 },
  { 'romgrk/fzy-lua-native', dev = true },
  { 'romgrk/kui.nvim', dev = true },
  {
    'romgrk/kirby.nvim',
    dependencies = {
      { 'romgrk/fzy-lua-native', build = 'make install', dev = true },
      { 'romgrk/kui.nvim', dev = true },
      { 'nvim-tree/nvim-web-devicons' },
      { 'nvim-lua/plenary.nvim' },
    },
    dev = true,
  },
  { 'romgrk/barbar.nvim',                    dev = true },
  { 'romgrk/todoist.nvim', dev = true      , build = ':TodoistInstall' },
  { 'romgrk/equal.operator' },
  { 'romgrk/columnMove.vim' },
  { 'romgrk/lib.kom' },
  { 'romgrk/pp.vim' },
  { 'romgrk/replace.vim' },
  { 'romgrk/winteract.vim'                 , cmd = 'InteractiveWindow'},

  -- Language
  { 'rhysd/vim-llvm' },
  { 'pantharshit00/vim-prisma'             , ft = 'prisma' },
  { 'neoclide/jsonc.vim' },
  { 'jordwalke/vim-reasonml'               , ft = 'reason' },
  { 'tmhedberg/SimpylFold'                 , ft = 'python' },
  { 'pangloss/vim-javascript'              , ft = 'javascript' },
  { 'kristijanhusak/vim-js-file-import'    , ft = 'javascript' },
  { 'neoclide/vim-jsx-improve'             , ft = 'javascript.jsx' },
  { 'moll/vim-node'                        , ft = 'javascript.node' },
  { 'iamcco/markdown-preview.nvim'         , build = function () vim.cmd[[call mkdp#util#install()]] end, ft = { 'markdown', 'vim-plug' } },
  { 'AndrewRadev/tagalong.vim' },
  { 'valloric/MatchTagAlways'              , ft = 'html' },
  { 'rstacruz/sparkup'                     , ft = 'html' },
  { 'kelan/gyp.vim'                        , ft = 'gyp' },
  { 'cespare/vim-toml'                     , ft = 'toml' },
  { 'dzeban/vim-log-syntax'                , ft = 'log' },
  { 'OXY2DEV/markview.nvim', lazy = false },
}, {
  dev = {
    path = '~/src',
    fallback = false,
  },
})

-- Scripts:
load('./rc/function.vim')
load('./rc/events.vim')
load('./rc/autocmd.vim')
load('./rc/commands.vim')
load('./rc/colors.vim')
load('./rc/abbrev.vim')

-- Plugin settings (after loading):
-- ...either use autocmd
vim.cmd [[doautocmd User PluginsLoaded]]
-- ...or be named *.after.vim
for _, file in ipairs(plugin_settings) do
  if string.find(file, '.after.') then
    load(file)
  end
end

-- Local settings:
if filereadable(join(stdpath('config'), 'local.vim')) == 1 then
    load('./local.vim')
end

nvim_create_autocmd('VimEnter', {
  pattern = {'*'},
  group = nvim_create_augroup('RC_SETUP', { clear = true }),
  callback = function()
    vim.cmd [[colorscheme kyntell]]
    vim.cmd [[IBLDisable | IBLEnable]]


    load('./rc/highlight.vim')
    load('./rc/keymap.vim')
  end,
})
