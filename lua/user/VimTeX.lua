local status_ok, vimtex = pcall(require, "VimTeX")
if not status_ok then
  return
end

vim.cmd('filetype plugin indent on')
vim.cmd('syntax enable')

-- vim.g.vimtex_view_method = 'zathura'
-- vim.g.vimtex_view_general_viewer = 'okular'
-- -- vim.g.vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
-- vim.g.vimtex_compiler_method = 'latexrun'
-- vim.g.maplocalleader = ","
-- vim.g.vimtex_compiler_latexrun_engines = {
--         '_'                : 'pdflatex',
--         'pdflatex'         : 'pdflatex',
--         'lualatex'         : 'lualatex',
--         'xelatex'          : 'xelatex',
--         }
--
