--
-- init.lua
--

-- TODO https://github.com/ggandor/flit.nvim
-- TODO https://github.com/koenverburg/peepsight.nvim
-- TODO https://github.com/DNLHC/glance.nvim
-- TODO https://github.com/Wansmer/treesj
-- TODO https://github.com/smjonas/live-command.nvim
-- TODO consider https://git.sr.ht/~whynothugo/lsp_lines.nvim
-- TODO install https://github.com/GustavoKatel/sidebar.nvim
-- TODO install https://github.com/kristijanhusak/vim-dadbod-ui
-- TODO install https://github.com/anuvyklack/hydra.nvim
-- TODO install https://github.com/RRethy/nvim-treesitter-textsubjects
-- TODO install https://github.com/SmiteshP/nvim-gps
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
local api = vim.api
local glob = vim.fn.glob
local stdpath = vim.fn.stdpath
local filereadable = vim.fn.filereadable
local nvim_create_augroup = api.nvim_create_augroup
local nvim_create_autocmd = api.nvim_create_autocmd
local utils = require('rc.utils')
local bootstrap_packer = require('rc.bootstrap_packer')
local join = utils.join
local split = vim.split
local load = utils.load

-- Bootstrap packer, if required
local packer_bootstrap = bootstrap_packer()

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

require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }

  -- Dev
  -- use { '/home/romgrk/src/hologram.nvim' }

  -- Libraries
  use { 'nvim-lua/plenary.nvim' }
  use { 'MunifTanjim/nui.nvim' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'itchyny/vim-gitbranch' }

  -- Editing
  use { 'nvim-treesitter/nvim-treesitter' }
  use { 'nvim-treesitter/nvim-treesitter-context' }
  use { 'nvim-treesitter/playground' }
  use { 'JoosepAlviste/nvim-ts-context-commentstring' }
  use { 'AndrewRadev/sideways.vim' }
  use { 'AndrewRadev/splitjoin.vim' }
  use { 'bkad/CamelCaseMotion' }
  use { 'coderifous/textobj-word-column.vim' }
  use { 'jiangmiao/auto-pairs' }
  -- Plug 'justinmk/vim-sneak'
  use { 'romgrk/vim-sneak' }
  use { 'ggandor/leap.nvim' }
  use { 'kana/vim-niceblock' }
  use { 'Konfekt/vim-ctrlxa' }
  use { 'michaeljsmith/vim-indent-object' }
  use { 'neoclide/coc.nvim', run = 'yarn install' }
  use { 'numToStr/Comment.nvim' }
  use { 'sirver/UltiSnips' }
  use { 'tpope/vim-fugitive' }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-surround' }
  use { 'wellle/targets.vim' }

  -- General
  -- @plugins
  use { 'fidian/hexmode' }
  use { 'jbyuki/one-small-step-for-vimkind' }
  use { 'jbyuki/venn.nvim' }
  use { 'ruanyl/vim-gh-line' }
  use { 'wellle/visual-split.vim' }
  use { 'aperezdc/vim-template' }
  use { 'bfredl/nvim-miniyank' }
  use { 'honza/vim-snippets' }
  use { 'junegunn/vim-easy-align' }
  use { 'liuchengxu/vim-clap', run = ':Clap install-binary!' }
  use { 'liuchengxu/vista.vim' }
  use { 'MarcWeber/vim-addon-local-vimrc' }
  use { 'tpope/vim-eunuch' }
  use { 'tpope/vim-sleuth' }
  use { 'vim-scripts/loremipsum', cmd = 'Loremipsum' }
  use { 'vn-ki/coc-clap' }
  use { 'wsdjeg/vim-fetch' }
  use { 'xolox/vim-misc' }
  use { 'xolox/vim-notes' }
  use { 'xolox/vim-shell' }
  use { 'romgrk/vim-session' }

  -- UI
  use { 'sindrets/diffview.nvim' }
  use { 'dstein64/nvim-scrollview' }
  use { 'sidebar-nvim/sidebar.nvim' }
  use { 'VonHeikemen/searchbox.nvim', requires = { 'MunifTanjim/nui.nvim' } }
  use { 'kevinhwang91/nvim-ufo', requires = { 'kevinhwang91/promise-async' } }
  use { 'rhysd/git-messenger.vim' }
  use { 'KabbAmine/vCoolor.vim' }
  use { 'machakann/vim-highlightedyank' }
  use { 'RRethy/vim-hexokinase'                , run = 'make hexokinase' }
  use { 'airblade/vim-gitgutter' }
  use { 'https://gitlab.com/yorickpeterse/nvim-pqf.git' }
  use { 'akinsho/nvim-toggleterm.lua' }
  use { 'lukas-reineke/indent-blankline.nvim' }
  -- use { 'mfussenegger/nvim-dap' }
  -- use { 'rcarriga/nvim-dap-ui' }
  -- use { 'theHamsta/nvim-dap-virtual-text' }

  -- Personal
  use { 'romgrk/barbar.nvim' }
  use { 'romgrk/equal.operator' }
  use { 'romgrk/columnMove.vim' }
  use { 'romgrk/lib.kom' }
  use { 'romgrk/pp.vim' }
  use { 'romgrk/replace.vim' }
  use { 'romgrk/vim-exeline' }
  use { 'romgrk/winteract.vim'                 , cmd = 'InteractiveWindow'}
  use { 'romgrk/searchReplace.vim' }
  use { 'romgrk/todoist.nvim'                  , run = ':TodoistInstall' }
  use { 'romgrk/doom-one.vim' }

  -- Language
  use { 'rhysd/vim-llvm' }
  use { 'martinda/Jenkinsfile-vim-syntax'      , ft = 'Jenkinsfile' }
  use { 'pantharshit00/vim-prisma'             , ft = 'prisma' }
  use { 'neoclide/jsonc.vim' }
  use { 'justinmk/vim-syntax-extra' }
  use { 'jordwalke/vim-reasonml'               , ft = 'reason' }
  use { 'vim-python/python-syntax'             , ft = 'python' }
  use { 'tmhedberg/SimpylFold'                 , ft = 'python' }
  use { 'othree/xml.vim'                       , ft = 'xml' }
  use { 'pangloss/vim-javascript'              , ft = 'javascript' }
  use { 'kristijanhusak/vim-js-file-import'    , ft = 'javascript' }
  use { 'neoclide/vim-jsx-improve'             , ft = 'javascript.jsx' }
  use { 'moll/vim-node'                        , ft = 'javascript.node' }
  use { 'leafgarland/typescript-vim'           , ft = 'typescript' }
  use { 'ianks/vim-tsx'                        , ft = 'typescript.tsx' }
  use { 'plasticboy/vim-markdown'              , ft = 'markdown' }
  use { 'iamcco/markdown-preview.nvim'         , run = function () vim.cmd[[call mkdp#util#install()]] end, ft = { 'markdown', 'vim-plug' } }
  use { 'tpope/vim-haml'                       , ft = { 'sass', 'scss', 'haml' } }
  use { 'hail2u/vim-css3-syntax'               , ft = { 'css', 'sass', 'scss', 'less' } }
  use { 'AndrewRadev/tagalong.vim' }
  use { 'valloric/MatchTagAlways'              , ft = 'html' }
  use { 'othree/html5.vim'                     , ft = 'html' }
  use { 'othree/html5-syntax.vim'              , ft = 'html' }
  use { 'rstacruz/sparkup'                     , ft = 'html' }
  use { 'kelan/gyp.vim'                        , ft = 'gyp' }
  use { 'rust-lang/rust.vim'                   , ft = 'rust' }
  use { 'cespare/vim-toml'                     , ft = 'toml' }
  use { 'dzeban/vim-log-syntax'                , ft = 'log' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

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
    vim.cmd [[colorscheme doom-one]]

    load('./rc/highlight.vim')
    load('./rc/keymap.vim')
  end,
})
