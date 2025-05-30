--
-- grug-far.after.lua
--

local grug = require('grug-far')

-- nnoremap <silent><C-f><C-f> <cmd>lua require('grug-far').toggle_instance({ instanceName='default', transient=true })<CR>
-- nnoremap <silent><C-f><C-w> :lua require('grug-far').hide_instance('default')<CR>viw:lua require('grug-far').with_visual_selection({ instanceName='default', transient=true, startInInsertMode=false })<CR><Esc>
-- nnoremap <silent><C-f>w     :lua require('grug-far').hide_instance('default')<CR>viw:lua require('grug-far').with_visual_selection({ instanceName='default', transient=true, startInInsertMode=false })<CR><Esc>
-- nnoremap <silent><C-f>.     <cmd>lua require('grug-far').open({ instanceName='default', transient=true, prefills = { paths = vim.fn.expand("%") } })<CR>
-- nnoremap <silent><C-f><C-n> <cmd>lua require('grug-far').open()<CR>
-- nnoremap <silent><C-f>n     <cmd>lua require('grug-far').open()<CR>

function getVisualSelection()
  local start = vim.fn.getpos('.')
  local end_ = vim.fn.getpos('v')
  if (not start or not end_) then
    return ''
  end
  return vim.fn.getregion(start, end_)[1]
end

function grug_defaultToggle(prefills)
  if (grug.has_instance('default')) then
    local instance = grug.get_instance('default')
    if (instance:is_open()) then
      instance:close()
    end
  else
    grug.open({ instanceName = 'default', prefills = prefills })
  end
end

function grug_defaultSearch(prefills)
  if (grug.has_instance('default')) then
    local instance = grug.get_instance('default')
    instance:ensure_open();

    local buffer = instance:get_buf()
    local window = vim.fn.bufwinid(buffer) or 1
    vim.api.nvim_set_current_win(window)

    if (prefills) then
      instance:update_input_values(prefills, false)
    else
      instance:goto_first_input()
      vim.cmd('normal! cc')
      vim.cmd('startinsert')
    end
  else
    grug.open({ instanceName = 'default', prefills = prefills })
  end
end

function grug_defaultSearchVisual()
  return grug_defaultSearch({ search = getVisualSelection(), flags = '--fixed-strings' })
end

function grug_nextInput()
  local instance = grug.get_instance(vim.fn.bufnr())
  if (instance) then
    instance:goto_next_input()
  end
end

function grug_previousInput()
  local instance = grug.get_instance(vim.fn.bufnr())
  if (instance) then
    instance:goto_next_input()
  end
end

function grug_nextMatch()
  local instance = grug.get_instance('default')
  if (instance) then
    instance:goto_next_match()
    instance:goto_location()
  end
end

function grug_prevMatch()
  local instance = grug.get_instance('default')
  if (instance) then
    instance:goto_prev_match()
    instance:goto_location()
  end
end
