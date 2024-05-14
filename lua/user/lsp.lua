-- Add additional capabilities supported by nvim-cmp
local nvim_lsp = require("cmp_nvim_lsp")
local capabilities = nvim_lsp.default_capabilities()

local luasnip = require 'luasnip'
local cmp = require 'cmp'

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  formatting = {
    format = require("lspkind").cmp_format({
      with_text = true,
      menu = {
        nvim_lsp = "[LSP]",
      },
    }),
  },
   mapping = {
     ['<C-p>'] = cmp.mapping.select_prev_item(),
     ['<C-n>'] = cmp.mapping.select_next_item(),
     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
     -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
     ['<C-Space>'] = cmp.mapping.complete(),
     ['<C-e>'] = cmp.mapping.close(),
     ['<CR>'] = cmp.mapping.confirm {
       behavior = cmp.ConfirmBehavior.Replace,
       select = true,
     },
     ['<Tab>'] = function(fallback)
       if cmp.visible() then
         cmp.select_next_item()
       elseif luasnip.expand_or_jumpable() then
         luasnip.expand_or_jump()
       else
         fallback()
       end
     end,
     ['<S-Tab>'] = function(fallback)
       if cmp.visible() then
         cmp.select_prev_item()
       elseif luasnip.jumpable(-1) then
         luasnip.jump(-1)
       else
         fallback()
       end
     end,
   },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- A callback that will get called when a buffer connects to the language server.
-- Here we create any key maps that we want to have on that buffer.
local on_attach = function(_, bufnr)
  local function map(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local map_opts = {noremap = true, silent = true}

  -- tell nvim-cmp about our desired capabilities
  require("cmp_nvim_lsp").default_capabilities(capabilities)
end

-- Configure ElixirLS as the LSP server for Elixir.

local elixir_ls_sh = "/opt/homebrew/opt/elixir-ls/libexec/language_server.sh"
require'lspconfig'.elixirls.setup{
  cmd = { elixir_ls_sh },
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  elixirLS = {
    dialyzerEnabled = true,
    fetchDeps = false,
    enableTestLenses = true,
    suggestSpecs = false,
  },
}

-- Configure solargraph as the LSP server for Ruby.
require'lspconfig'.solargraph.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {
	  debounce_text_changes = 150,
	}
}

-- Configure pylsp as the LSP server for Python.
-- require("lspconfig").pylsp.setup{
--   capabilities = capabilities,
--   on_attach = on_attach,
--   settings = {
--     pylsp = {
--       plugins = {
--         pycodestyle = {
--           maxLineLength = 120
--         }
--       }
--     }
--   }
-- }

-- Configure tsserver as the LSP server for TypeScript.
-- require("lspconfig").tsserver.setup{
--   capabilities = capabilities,
--   on_attach = on_attach,
--   filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
--   cmd = { "typescript-language-server", "--stdio" },
-- }
--
