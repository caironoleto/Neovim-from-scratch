local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diff = {
	"diff",
	colored = false,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width
}

local mode = {
	"mode",
	fmt = function(str)
		return "" .. str .. ""
	end,
}

local filetype = {
	"filetype",
	icons_enabled = true,
  icon_only = true,
}

local filename = {
  "filename",
  file_status = true,      -- Displays file status (readonly status, modified status)
  newfile_status = true,  -- Display new file status (new file means no write after created)
  path = 1,                -- 0: Just the filename
                           -- 1: Relative path
                           -- 2: Absolute path
                           -- 3: Absolute path, with tilde as the home directory
                           -- 4: Filename and parent dir, with tilde as the home directory

  shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
  -- for other components. (terrible name, any suggestions?)
  symbols = {
    modified = '',      -- Text to show when the file is modified.
    readonly = '',      -- Text to show when the file is non-modifiable or readonly.
    unnamed = '',       -- Text to show for unnamed buffers.
    newfile = '󰎔',       -- Text to show for newly created file before first write
  }
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
  fmt = function(display_string, context)
    if #display_string > 20 then
      return display_string:sub(1, 20) .. '...'
    else
      return display_string
    end
  end,
}

local lsp_status = {
  'lsp_status',
  icon = '', -- f013
  symbols = {
    -- Standard unicode symbols to cycle through for LSP progress:
    spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
    -- Standard unicode symbol for when LSP is done:
    done = '✓',
    -- Delimiter inserted between LSP names:
    separator = ' ',
  },
  -- List of LSP names to ignore (e.g., `null-ls`):
  ignore_lsp = {},
  -- Display the LSP name
  show_name = true,
}

local searchcount = {
  'searchcount',
  maxcount = 999,
  timeout = 500,
}

local spaces = function()
	return "󱁐 " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local codeium = function()
  return " " .. vim.api.nvim_call_function("codeium#GetStatusString", {})
end

local my_filetype = require('lualine.components.filename'):extend()
my_filetype.apply_icon = require('lualine.components.filetype').apply_icon

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
	},
	sections = {
		lualine_a = { branch },
		lualine_b = { searchcount, filetype },
		lualine_c = { filename },
		lualine_x = { diff, spaces, lsp_status },
	},
	inactive_sections = {
		lualine_a = { branch },
		lualine_b = { searchcount, filetype },
		lualine_c = { filename },
		lualine_x = { diff, spaces, lsp_status },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
