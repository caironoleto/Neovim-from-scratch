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
		lualine_b = { mode },
		lualine_c = { filetype, searchcount, filename },
		lualine_x = { diff, spaces, codeium },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
