local status_ok, nvd = pcall(require, "nvim-ruby-debugger")
if not status_ok then
  return
end

nvd.setup({
  rails_port = 38698,
  worker_port = 38699,
  minitest_port = 38700,
  host = "127.0.0.1",
})
