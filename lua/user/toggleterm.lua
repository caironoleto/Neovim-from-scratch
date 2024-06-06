local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup {
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.3
    end
  end,
  -- direction values: 'vertical' | 'horizontal' | 'tab' | 'float'
  direction = 'vertical',
  hide_numbers = true,
  open_mapping = [[<F12>]],
}
