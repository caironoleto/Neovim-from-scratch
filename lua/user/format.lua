local status_ok, conform = pcall(require, "conform")
if not status_ok then
  return
end

conform.setup({
  formatters_by_ft = {
    python = { "isort", "black" },
  },
  format_on_save = {
    -- I recommend these options. See :help conform.format for details.
    lsp_fallback = true,
    timeout_ms = 500,
  },
  notify_on_error = true,
})
