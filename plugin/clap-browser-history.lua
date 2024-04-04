--
-- clap-browser-history.lua
--

local vim = vim

local history_path = os.getenv('HOME') .. '/.config/BraveSoftware/Brave-Browser/Profile 2/History'
local copy_path = os.getenv('HOME') .. '/.cache/nvim/browser_history.db'

local lines = {'empty'}

local function is_valid(url)
  if vim.startswith(url, 'chrome-extension://') then
    return false
  end
  if vim.startswith(url, 'file://') then
    return false
  end
  return true
end

local function setup()
  vim.fn.system(string.format('cp "%s" "%s"', history_path, copy_path))

  local output = vim.fn.system(
    string.format('sqlite3 --init /dev/null "%s" "select url from urls order by visit_count desc limit 2000"', copy_path)
  )
  local all_lines = vim.split(output, "\n")

  lines = vim.tbl_filter(is_valid, all_lines)
end

setup()

-- Global functions
-- (callbacks for clap)

function browser_history_get()
  return lines
end

function browser_history_open(url)
  vim.fn.system(string.format('xdg-open "%s"', url))
end
