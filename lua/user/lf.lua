local status_ok, lf = pcall(require, "lf")
if not status_ok then
  return
end

vim.g.lf_width = 10
vim.g.lf_height = 5
