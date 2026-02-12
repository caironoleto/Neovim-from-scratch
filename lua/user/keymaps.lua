local opts = { noremap = true, silent = true }
local resize_opts = { silent = true, noremap = true, nowait = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

local function resize_mode()
  print("Resize mode: ↑↓←→ | <Esc> to leave")

  while true do
    local key = vim.fn.getcharstr()

    if key == "\027" then
      break
    elseif key == vim.keycode("<Up>") then
      vim.cmd("resize +2")
    elseif key == vim.keycode("<Down>") then
      vim.cmd("resize -2")
    elseif key == vim.keycode("<Right>") then
      vim.cmd("vertical resize -2")
    elseif key == vim.keycode("<Left>") then
      vim.cmd("vertical resize +2")
    else
      break
    end

    vim.cmd("redraw")
  end

  print("")
end

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<cs-Down>", "<C-w>j", opts)
keymap("n", "<cs-Up>", "<C-w>k", opts)
keymap("n", "<cs-Left>", "<C-w>h", opts)
keymap("n", "<cs-Right>", "<C-w>l", opts)

-- Resize with arrows

vim.keymap.set("n", "<Leader>r", resize_mode, { noremap = true, silent = true, desc = "Resize mode" })
-- keymap("n", " <Up>", ":resize +2<CR>", resize_opts)
-- keymap("n", " <Down>", ":resize -2<CR>", resize_opts)
-- keymap("n", " <Right>", ":vertical resize -2<CR>", resize_opts)
-- keymap("n", " <Left>", ":vertical resize +2<CR>", resize_opts)

-- Navigate find files
keymap("n", "<cs-p>", ":Telescope find_files<CR>", opts)
keymap("n", "<cs-b>", ":lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>", opts)
keymap("n", "<cs-f>", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", opts)


-- Navigate buffers
keymap("n", "<cs-[>", ":bp<CR>", opts)
keymap("n", "<cs-]>", ":bn<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- RSpec --
keymap("n", "<leader>tI", "<cmd>lua require('rspec.integrated').run_spec_file()<cr>", { silent = true, noremap = true })

-- Terminal --
-- Better terminal navigation
keymap("n", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("n", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("n", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("n", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- ć -> ç
keymap('i', 'ć', 'ç', opts)
keymap('i', 'Ć', 'Ç', opts)
