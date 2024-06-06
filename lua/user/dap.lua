local status_ok, dap = pcall(require, "dap-python")
if not status_ok then
  return
end

dap.setup("python")

local status_ok, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if not status_ok then
  return
end

dap_virtual_text.setup()
