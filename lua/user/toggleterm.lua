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

-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Toggleterm
keymap("n", "<F11>", "<cmd>2ToggleTerm direction=vertical<cr>", opts)
keymap("n", "<F10>", "<cmd>3ToggleTerm direction=horizontal<cr>", opts)
keymap("n", "<F9>", "<cmd>4ToggleTerm direction=float<cr>", opts)
keymap('t', '<C-ESC>', [[<C-\><C-n>]], opts)
keymap("t", "jk", "<ESC>", opts)
keymap("t", "kj", "<ESC>", opts)
