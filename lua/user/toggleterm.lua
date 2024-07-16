local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup {
  size = function(term)
    if term.direction == "horizontal" then
      return 30
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.35
    end
  end,
  -- direction values: 'vertical' | 'horizontal' | 'tab' | 'float'
  direction = 'vertical',
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,
  open_mapping = [[<F12>]],
  hide_numbers = false,
}

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end
