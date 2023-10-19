return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header
		dashboard.section.header.val = {
			[[ ███    ███  █████  ██████   ██████  ██████      ██    ██ ██ ███    ███ ]],
			[[ ████  ████ ██   ██ ██   ██ ██      ██    ██     ██    ██ ██ ████  ████ ]],
			[[ ██ ████ ██ ███████ ██████  ██      ██    ██     ██    ██ ██ ██ ████ ██ ]],
			[[ ██  ██  ██ ██   ██ ██   ██ ██      ██    ██      ██  ██  ██ ██  ██  ██ ]],
			[[ ██      ██ ██   ██ ██   ██  ██████  ██████        ████   ██ ██      ██ ]],
		}

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
			dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button(
				"p",
				" " .. " Find project",
				":lua require('telescope').extensions.projects.projects()<CR>"
			),
			dashboard.button("r", "" .. " Recent files", ":Telescope oldfiles <CR>"),
			dashboard.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
			dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
			dashboard.button("q", " " .. " Quit", ":qa<CR>"),
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
