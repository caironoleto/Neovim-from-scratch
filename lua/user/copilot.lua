-- Setup copilot.

vim.g.copilot_assume_mapped = true

-- assign <M-]> to <D-]

-- Define a custom function that emulates "<M-]>" using both Ctrl and Shift
function next_rigth_buffer()
  -- Press and release Ctrl and Shift keys
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-S-]>', true, true, true), 'n', true)
end

-- Map "<M-]>" to the custom function
vim.api.nvim_set_keymap('n', '<M-]>', ':lua next_rigth_buffer()<CR>', { noremap = true, silent = true })

function next_left_buffer()
  -- Press and release Ctrl and Shift keys
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-S-[>', true, true, true), 'n', true)
end

-- Map "<M-]>" to the custom function
vim.api.nvim_set_keymap('n', '<M-[>', ':lua next_left_buffer()<CR>', { noremap = true, silent = true })
