--
-- utils.lua
--

local vim = vim
local stdpath = vim.fn.stdpath

local function starts_with(str, start)
  return str:sub(1, #start) == start
end

local function ends_with(str, ending)
  return ending == '' or str:sub(-#ending) == ending
end

local function join(a, b)
  return vim.fn.resolve(a .. '/' .. b)
end

local function try_and_warn(fn, arg)
  local ok, result = pcall(fn, arg)
  if ok then return end
  vim.api.nvim_err_writeln('Error while running "' .. arg .. '": ' .. tostring(result))
end

local function load(path)
  local filepath =
    starts_with(path, '/')
      and path
      or join(stdpath('config'), path)

  if ends_with(filepath, '.lua') then
    try_and_warn(vim.cmd, string.format('luafile %s', filepath))
  end
  if ends_with(filepath, '.vim') then
    try_and_warn(vim.cmd, string.format('source %s', filepath))
  end
end

return {
  starts_with = starts_with,
  ends_with = ends_with,
  join = join,
  load = load,
}
