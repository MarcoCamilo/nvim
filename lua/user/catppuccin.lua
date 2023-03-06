-- local colorscheme = "catppuccin"

-- local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
-- if not status_ok then
--   return
-- end

local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
  return
end


catppuccin.setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
			term_colors = true,
			transparent_background = false,
			no_italic = false,
			no_bold = false,
			styles = {
				comments = {},
				conditionals = {},
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
			},
			color_overrides = {
        all = {
            text = "#ffffff",},
				mocha = {
					base = "#000000",
					mantle = "#000000",
					crust = "#000000",
				},
			},})

