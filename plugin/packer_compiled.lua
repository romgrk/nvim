-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/romgrk/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/romgrk/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/romgrk/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/romgrk/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/romgrk/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  CamelCaseMotion = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/CamelCaseMotion",
    url = "https://github.com/bkad/CamelCaseMotion"
  },
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["Ionide-vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/Ionide-vim",
    url = "https://github.com/ionide/Ionide-vim"
  },
  ["Jenkinsfile-vim-syntax"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/Jenkinsfile-vim-syntax",
    url = "https://github.com/martinda/Jenkinsfile-vim-syntax"
  },
  MatchTagAlways = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/MatchTagAlways",
    url = "https://github.com/valloric/MatchTagAlways"
  },
  SimpylFold = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/SimpylFold",
    url = "https://github.com/tmhedberg/SimpylFold"
  },
  UltiSnips = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/UltiSnips",
    url = "https://github.com/sirver/UltiSnips"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/auto-pairs",
    url = "https://github.com/jiangmiao/auto-pairs"
  },
  ["barbar.nvim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/barbar.nvim",
    url = "https://github.com/romgrk/barbar.nvim"
  },
  ["beacon.nvim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/beacon.nvim",
    url = "https://github.com/DanilaMihailov/beacon.nvim"
  },
  ["coc-clap"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/coc-clap",
    url = "https://github.com/vn-ki/coc-clap"
  },
  ["coc.nvim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/coc.nvim",
    url = "https://github.com/neoclide/coc.nvim"
  },
  ["columnMove.vim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/columnMove.vim",
    url = "https://github.com/romgrk/columnMove.vim"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["doom-one.vim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/doom-one.vim",
    url = "https://github.com/romgrk/doom-one.vim"
  },
  ["equal.operator"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/equal.operator",
    url = "https://github.com/romgrk/equal.operator"
  },
  ["git-messenger.vim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/git-messenger.vim",
    url = "https://github.com/rhysd/git-messenger.vim"
  },
  ["github-light.vim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/github-light.vim",
    url = "https://github.com/romgrk/github-light.vim"
  },
  ["goyo.vim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/goyo.vim",
    url = "https://github.com/junegunn/goyo.vim"
  },
  ["gundo.vim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/gundo.vim",
    url = "https://github.com/sjl/gundo.vim"
  },
  ["gyp.vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/gyp.vim",
    url = "https://github.com/kelan/gyp.vim"
  },
  hexmode = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/hexmode",
    url = "https://github.com/fidian/hexmode"
  },
  ["hologram.nvim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/hologram.nvim",
    url = "/home/romgrk/src/hologram.nvim"
  },
  ["html5-syntax.vim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/html5-syntax.vim",
    url = "https://github.com/othree/html5-syntax.vim"
  },
  ["html5.vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/html5.vim",
    url = "https://github.com/othree/html5.vim"
  },
  ["incline.nvim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/incline.nvim",
    url = "https://github.com/b0o/incline.nvim"
  },
  ["incsearch.vim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/incsearch.vim",
    url = "https://github.com/haya14busa/incsearch.vim"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["jsonc.vim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/jsonc.vim",
    url = "https://github.com/neoclide/jsonc.vim"
  },
  ["leap.nvim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/leap.nvim",
    url = "https://github.com/ggandor/leap.nvim"
  },
  ["lib.kom"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/lib.kom",
    url = "https://github.com/romgrk/lib.kom"
  },
  ["line-targets.vim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/line-targets.vim",
    url = "https://github.com/wellle/line-targets.vim"
  },
  loremipsum = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/loremipsum",
    url = "https://github.com/vim-scripts/loremipsum"
  },
  ["markdown-preview.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  nerdtree = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/nerdtree",
    url = "https://github.com/preservim/nerdtree"
  },
  ["npm.nvim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/npm.nvim",
    url = "https://github.com/neoclide/npm.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-luadev"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/nvim-luadev",
    url = "https://github.com/bfredl/nvim-luadev"
  },
  ["nvim-miniyank"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/nvim-miniyank",
    url = "https://github.com/bfredl/nvim-miniyank"
  },
  ["nvim-pqf.git"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/nvim-pqf.git",
    url = "https://gitlab.com/yorickpeterse/nvim-pqf"
  },
  ["nvim-scrollview"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/nvim-scrollview",
    url = "https://github.com/dstein64/nvim-scrollview"
  },
  ["nvim-toggleterm.lua"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/nvim-toggleterm.lua",
    url = "https://github.com/akinsho/nvim-toggleterm.lua"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/nvim-treesitter-context",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-context"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-ufo"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/nvim-ufo",
    url = "https://github.com/kevinhwang91/nvim-ufo"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["one-small-step-for-vimkind"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/one-small-step-for-vimkind",
    url = "https://github.com/jbyuki/one-small-step-for-vimkind"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["pp.vim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/pp.vim",
    url = "https://github.com/romgrk/pp.vim"
  },
  ["promise-async"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/promise-async",
    url = "https://github.com/kevinhwang91/promise-async"
  },
  ["python-syntax"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/python-syntax",
    url = "https://github.com/vim-python/python-syntax"
  },
  ["replace.vim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/replace.vim",
    url = "https://github.com/romgrk/replace.vim"
  },
  ["rust.vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/rust.vim",
    url = "https://github.com/rust-lang/rust.vim"
  },
  ["searchReplace.vim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/searchReplace.vim",
    url = "https://github.com/romgrk/searchReplace.vim"
  },
  ["searchbox.nvim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/searchbox.nvim",
    url = "https://github.com/VonHeikemen/searchbox.nvim"
  },
  ["sideways.vim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/sideways.vim",
    url = "https://github.com/AndrewRadev/sideways.vim"
  },
  sparkup = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/sparkup",
    url = "https://github.com/rstacruz/sparkup"
  },
  ["splitjoin.vim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/splitjoin.vim",
    url = "https://github.com/AndrewRadev/splitjoin.vim"
  },
  ["swift.vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/swift.vim",
    url = "https://github.com/keith/swift.vim"
  },
  ["tagalong.vim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/tagalong.vim",
    url = "https://github.com/AndrewRadev/tagalong.vim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzy-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["textobj-word-column.vim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/textobj-word-column.vim",
    url = "https://github.com/coderifous/textobj-word-column.vim"
  },
  ["todo-comments.nvim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["todoist.nvim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/todoist.nvim",
    url = "https://github.com/romgrk/todoist.nvim"
  },
  ["typescript-vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/typescript-vim",
    url = "https://github.com/leafgarland/typescript-vim"
  },
  ["vCoolor.vim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vCoolor.vim",
    url = "https://github.com/KabbAmine/vCoolor.vim"
  },
  ["venn.nvim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/venn.nvim",
    url = "https://github.com/jbyuki/venn.nvim"
  },
  ["vim-addon-local-vimrc"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-addon-local-vimrc",
    url = "https://github.com/MarcWeber/vim-addon-local-vimrc"
  },
  ["vim-clap"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-clap",
    url = "https://github.com/liuchengxu/vim-clap"
  },
  ["vim-coffee-script"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-coffee-script",
    url = "https://github.com/kchmck/vim-coffee-script"
  },
  ["vim-crystal"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-crystal",
    url = "https://github.com/rhysd/vim-crystal"
  },
  ["vim-css3-syntax"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-css3-syntax",
    url = "https://github.com/hail2u/vim-css3-syntax"
  },
  ["vim-ctrlxa"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-ctrlxa",
    url = "https://github.com/Konfekt/vim-ctrlxa"
  },
  ["vim-dyon"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-dyon",
    url = "https://github.com/thyrgle/vim-dyon"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-elixir"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-elixir",
    url = "https://github.com/elixir-lang/vim-elixir"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-eunuch",
    url = "https://github.com/tpope/vim-eunuch"
  },
  ["vim-exeline"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-exeline",
    url = "https://github.com/romgrk/vim-exeline"
  },
  ["vim-fetch"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-fetch",
    url = "https://github.com/wsdjeg/vim-fetch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-gh-line"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-gh-line",
    url = "https://github.com/ruanyl/vim-gh-line"
  },
  ["vim-gitbranch"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-gitbranch",
    url = "https://github.com/itchyny/vim-gitbranch"
  },
  ["vim-gitgutter"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-gitgutter",
    url = "https://github.com/airblade/vim-gitgutter"
  },
  ["vim-haml"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-haml",
    url = "https://github.com/tpope/vim-haml"
  },
  ["vim-hexokinase"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-hexokinase",
    url = "https://github.com/RRethy/vim-hexokinase"
  },
  ["vim-highlightedyank"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-highlightedyank",
    url = "https://github.com/machakann/vim-highlightedyank"
  },
  ["vim-illuminate"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate"
  },
  ["vim-indent-object"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-indent-object",
    url = "https://github.com/michaeljsmith/vim-indent-object"
  },
  ["vim-javascript"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-javascript",
    url = "https://github.com/pangloss/vim-javascript"
  },
  ["vim-js-file-import"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-js-file-import",
    url = "https://github.com/kristijanhusak/vim-js-file-import"
  },
  ["vim-jsx-improve"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-jsx-improve",
    url = "https://github.com/neoclide/vim-jsx-improve"
  },
  ["vim-less"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-less",
    url = "https://github.com/groenewege/vim-less"
  },
  ["vim-liquid"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-liquid",
    url = "https://github.com/tpope/vim-liquid"
  },
  ["vim-llvm"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-llvm",
    url = "https://github.com/rhysd/vim-llvm"
  },
  ["vim-log-syntax"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-log-syntax",
    url = "https://github.com/dzeban/vim-log-syntax"
  },
  ["vim-markdown"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-markdown",
    url = "https://github.com/plasticboy/vim-markdown"
  },
  ["vim-misc"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-misc",
    url = "https://github.com/xolox/vim-misc"
  },
  ["vim-multiple-cursors"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-multiple-cursors",
    url = "https://github.com/terryma/vim-multiple-cursors"
  },
  ["vim-niceblock"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-niceblock",
    url = "https://github.com/kana/vim-niceblock"
  },
  ["vim-node"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-node",
    url = "https://github.com/moll/vim-node"
  },
  ["vim-notes"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-notes",
    url = "https://github.com/xolox/vim-notes"
  },
  ["vim-prisma"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-prisma",
    url = "https://github.com/pantharshit00/vim-prisma"
  },
  ["vim-pug"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-pug",
    url = "https://github.com/digitaltoad/vim-pug"
  },
  ["vim-reasonml"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-reasonml",
    url = "https://github.com/jordwalke/vim-reasonml"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-session"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-session",
    url = "https://github.com/romgrk/vim-session"
  },
  ["vim-shell"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-shell",
    url = "https://github.com/xolox/vim-shell"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-sleuth",
    url = "https://github.com/tpope/vim-sleuth"
  },
  ["vim-sneak"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-sneak",
    url = "https://github.com/romgrk/vim-sneak"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-snippets",
    url = "https://github.com/honza/vim-snippets"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-syntax-extra"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-syntax-extra",
    url = "https://github.com/justinmk/vim-syntax-extra"
  },
  ["vim-template"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vim-template",
    url = "https://github.com/aperezdc/vim-template"
  },
  ["vim-toml"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-toml",
    url = "https://github.com/cespare/vim-toml"
  },
  ["vim-tsx"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-tsx",
    url = "https://github.com/ianks/vim-tsx"
  },
  ["vista.vim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/vista.vim",
    url = "https://github.com/liuchengxu/vista.vim"
  },
  ["visual-split.vim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/visual-split.vim",
    url = "https://github.com/wellle/visual-split.vim"
  },
  ["winteract.vim"] = {
    commands = { "InteractiveWindow" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/winteract.vim",
    url = "https://github.com/romgrk/winteract.vim"
  },
  ["xml.vim"] = {
    loaded = true,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/start/xml.vim",
    url = "https://github.com/othree/xml.vim"
  },
  ["xterm-color-table.vim"] = {
    commands = { "XtermColorTable" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/romgrk/.local/share/nvim/site/pack/packer/opt/xterm-color-table.vim",
    url = "https://github.com/guns/xterm-color-table.vim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file XtermColorTable lua require("packer.load")({'xterm-color-table.vim'}, { cmd = "XtermColorTable", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file InteractiveWindow lua require("packer.load")({'winteract.vim'}, { cmd = "InteractiveWindow", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType javascript.jsx ++once lua require("packer.load")({'vim-jsx-improve'}, { ft = "javascript.jsx" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript.node ++once lua require("packer.load")({'vim-node'}, { ft = "javascript.node" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'typescript-vim'}, { ft = "typescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType gyp ++once lua require("packer.load")({'gyp.vim'}, { ft = "gyp" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript.tsx ++once lua require("packer.load")({'vim-tsx'}, { ft = "typescript.tsx" }, _G.packer_plugins)]]
vim.cmd [[au FileType toml ++once lua require("packer.load")({'vim-toml'}, { ft = "toml" }, _G.packer_plugins)]]
vim.cmd [[au FileType coffee ++once lua require("packer.load")({'vim-coffee-script'}, { ft = "coffee" }, _G.packer_plugins)]]
vim.cmd [[au FileType fsharp ++once lua require("packer.load")({'Ionide-vim'}, { ft = "fsharp" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-markdown', 'markdown-preview.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'vim-css3-syntax'}, { ft = "css" }, _G.packer_plugins)]]
vim.cmd [[au FileType prisma ++once lua require("packer.load")({'vim-prisma'}, { ft = "prisma" }, _G.packer_plugins)]]
vim.cmd [[au FileType vim-plug ++once lua require("packer.load")({'markdown-preview.nvim'}, { ft = "vim-plug" }, _G.packer_plugins)]]
vim.cmd [[au FileType rust ++once lua require("packer.load")({'rust.vim'}, { ft = "rust" }, _G.packer_plugins)]]
vim.cmd [[au FileType sass ++once lua require("packer.load")({'vim-css3-syntax', 'vim-haml'}, { ft = "sass" }, _G.packer_plugins)]]
vim.cmd [[au FileType scss ++once lua require("packer.load")({'vim-css3-syntax', 'vim-haml'}, { ft = "scss" }, _G.packer_plugins)]]
vim.cmd [[au FileType dyon ++once lua require("packer.load")({'vim-dyon'}, { ft = "dyon" }, _G.packer_plugins)]]
vim.cmd [[au FileType haml ++once lua require("packer.load")({'vim-haml'}, { ft = "haml" }, _G.packer_plugins)]]
vim.cmd [[au FileType swift ++once lua require("packer.load")({'swift.vim'}, { ft = "swift" }, _G.packer_plugins)]]
vim.cmd [[au FileType less ++once lua require("packer.load")({'vim-css3-syntax', 'vim-less'}, { ft = "less" }, _G.packer_plugins)]]
vim.cmd [[au FileType reason ++once lua require("packer.load")({'vim-reasonml'}, { ft = "reason" }, _G.packer_plugins)]]
vim.cmd [[au FileType elixir ++once lua require("packer.load")({'vim-elixir'}, { ft = "elixir" }, _G.packer_plugins)]]
vim.cmd [[au FileType jade ++once lua require("packer.load")({'vim-pug'}, { ft = "jade" }, _G.packer_plugins)]]
vim.cmd [[au FileType pug ++once lua require("packer.load")({'vim-pug'}, { ft = "pug" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'SimpylFold', 'python-syntax'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'vim-liquid', 'html5-syntax.vim', 'html5.vim', 'MatchTagAlways', 'sparkup'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType Jenkinsfile ++once lua require("packer.load")({'Jenkinsfile-vim-syntax'}, { ft = "Jenkinsfile" }, _G.packer_plugins)]]
vim.cmd [[au FileType crystal ++once lua require("packer.load")({'vim-crystal'}, { ft = "crystal" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'vim-javascript', 'vim-js-file-import'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd [[au FileType log ++once lua require("packer.load")({'vim-log-syntax'}, { ft = "log" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-liquid/ftdetect/liquid.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-liquid/ftdetect/liquid.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-liquid/ftdetect/liquid.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/swift.vim/ftdetect/swift.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/swift.vim/ftdetect/swift.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/swift.vim/ftdetect/swift.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-node/ftdetect/node.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-node/ftdetect/node.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-node/ftdetect/node.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-prisma/ftdetect/prisma.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-prisma/ftdetect/prisma.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-prisma/ftdetect/prisma.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/typescript-vim/ftdetect/typescript.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/typescript-vim/ftdetect/typescript.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/typescript-vim/ftdetect/typescript.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-pug/ftdetect/pug.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-pug/ftdetect/pug.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-pug/ftdetect/pug.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-reasonml/ftdetect/dune.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-reasonml/ftdetect/dune.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-reasonml/ftdetect/dune.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-reasonml/ftdetect/reason.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-reasonml/ftdetect/reason.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-reasonml/ftdetect/reason.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-coffee-script/ftdetect/coffee.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-coffee-script/ftdetect/coffee.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-coffee-script/ftdetect/coffee.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-coffee-script/ftdetect/vim-literate-coffeescript.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-coffee-script/ftdetect/vim-literate-coffeescript.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-coffee-script/ftdetect/vim-literate-coffeescript.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-crystal/ftdetect/crystal.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-crystal/ftdetect/crystal.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-crystal/ftdetect/crystal.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-crystal/ftdetect/ecrystal.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-crystal/ftdetect/ecrystal.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-crystal/ftdetect/ecrystal.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-log-syntax/ftdetect/log.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-log-syntax/ftdetect/log.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-log-syntax/ftdetect/log.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/Jenkinsfile-vim-syntax/ftdetect/Jenkinsfile.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/Jenkinsfile-vim-syntax/ftdetect/Jenkinsfile.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/Jenkinsfile-vim-syntax/ftdetect/Jenkinsfile.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-tsx/ftdetect/typescript.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-tsx/ftdetect/typescript.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-tsx/ftdetect/typescript.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-dyon/ftdetect/dyon.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-dyon/ftdetect/dyon.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-dyon/ftdetect/dyon.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/Ionide-vim/ftdetect/fsharp.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/Ionide-vim/ftdetect/fsharp.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/Ionide-vim/ftdetect/fsharp.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-elixir/ftdetect/elixir.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-elixir/ftdetect/elixir.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-elixir/ftdetect/elixir.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-haml/ftdetect/haml.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-haml/ftdetect/haml.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-haml/ftdetect/haml.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/rust.vim/ftdetect/rust.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/rust.vim/ftdetect/rust.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/rust.vim/ftdetect/rust.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-javascript/ftdetect/flow.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-javascript/ftdetect/flow.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-javascript/ftdetect/flow.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-javascript/ftdetect/javascript.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-javascript/ftdetect/javascript.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-javascript/ftdetect/javascript.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-less/ftdetect/less.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-less/ftdetect/less.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-less/ftdetect/less.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/sparkup/ftdetect/hsb.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/sparkup/ftdetect/hsb.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/sparkup/ftdetect/hsb.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-toml/ftdetect/toml.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-toml/ftdetect/toml.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/vim-toml/ftdetect/toml.vim]], false)
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/gyp.vim/ftdetect/gyp.vim]], true)
vim.cmd [[source /home/romgrk/.local/share/nvim/site/pack/packer/opt/gyp.vim/ftdetect/gyp.vim]]
time([[Sourcing ftdetect script at: /home/romgrk/.local/share/nvim/site/pack/packer/opt/gyp.vim/ftdetect/gyp.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
