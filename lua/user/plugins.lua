local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
  use { "wbthomason/packer.nvim" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim" } -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs" } -- Autopairs, integrates with both cmp and treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use { "kyazdani42/nvim-web-devicons", branch = "master" }
  use { "kyazdani42/nvim-tree.lua" }
  use { "akinsho/bufferline.nvim" }
  use { "moll/vim-bbye" }
  use { "nvim-lualine/lualine.nvim" }
  use { "ahmedkhalf/project.nvim" }
  use { "lewis6991/impatient.nvim" }
  use { "goolord/alpha-nvim" }
  use { "folke/which-key.nvim" }
  use { "lukas-reineke/indent-blankline.nvim" }

  -- Search
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-telescope/telescope-live-grep-args.nvim" },
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end
  }

	-- Colorschemes
  use { "flazz/vim-colorschemes" }
  use { "catppuccin/nvim", as = "catppuccin" }

	-- Completion
  use { "hrsh7th/nvim-cmp" } -- The completion plugin
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-buffer" } -- buffer completions
  use { "hrsh7th/cmp-path" } -- path completions
  use { "hrsh7th/vim-vsnip" } -- snippet completions

	-- Snippets
  use { "L3MON4D3/LuaSnip" } --snippet engine
  use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

	-- LSP
  use { "neovim/nvim-lspconfig",
    requires = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim"
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      require('mason').setup()
      local mason_lspconfig = require 'mason-lspconfig'
      mason_lspconfig.setup {
        ensure_installed = { "pyright" }
      }
      require("lspconfig").pyright.setup {
        capabilities = capabilities,
      }
    end

  }
  use { "onsails/lspkind-nvim" }
  use { "mhanberg/elixir.nvim", requires = { "nvim-lua/plenary.nvim" } }

  -- Syntax Highlight
  use { "elixir-editors/vim-elixir" }

  -- Git
  use { "lewis6991/gitsigns.nvim" }

  -- trailing whitespace and lines
  use {
    "mcauley-penney/tidy.nvim",
    config = function()
      require("tidy").setup({
        filetype_exclude = { "markdown", "diff" },
      })
    end
  }

  -- Run tests inside neovim
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python",
      "theHamsta/nvim-dap-virtual-text",
    }
  }

  -- Code Format
  use { "stevearc/conform.nvim" }

  -- Terminal inside neovim
  use { "akinsho/toggleterm.nvim" }

  -- Python related
  use { "Vimjas/vim-python-pep8-indent", ft = { "python" } }
  use { "jeetsukumaran/vim-pythonsense", ft = { "python" } }

  -- Ruby related
  use { "melopilosyan/rspec-integrated.nvim" }

  -- -- PHP Setup
  -- use {
  --   "gbprod/phpactor.nvim",
  --   run = require("phpactor.handler.update"), -- To install/update phpactor when installing this plugin
  --   requires = {
  --     "nvim-lua/plenary.nvim", -- required to update phpactor
  --     "neovim/nvim-lspconfig" -- required to automaticly register lsp serveur
  --   },
  --   config = function()
  --     require("phpactor").setup({
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     })
  --   end
  -- }

  -- ChatGPT
  use({
    "jackMort/ChatGPT.nvim",
      config = function()
        require("chatgpt").setup({
          keymaps = {
            close = "<C-c>",
            yank_last = "<C-y>",
            yank_last_code = "<C-k>",
            scroll_up = "<C-u>",
            scroll_down = "<C-d>",
            new_session = "<C-n>",
            cycle_windows = "<Tab>",
            cycle_modes = "<C-f>",
            next_message = "<C-j>",
            prev_message = "<C-k>",
            select_session = "<C-Space>",
            rename_session = "r",
            delete_session = "d",
            draft_message = "<C-r>",
            edit_message = "e",
            delete_message = "d",
            toggle_settings = "<C-o>",
            toggle_sessions = "<C-p>",
            toggle_help = "<C-h>",
            toggle_message_role = "<C-r>",
            toggle_system_role_open = "<C-s>",
            stop_generating = "<C-x>",
          },
        })
      end,
      requires = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim",
        "nvim-telescope/telescope.nvim"
      }
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
