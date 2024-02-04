return {

	{
		"quarto-dev/quarto-nvim",
		dev = false,
		dependencies = {
			{
				"jmbuhr/otter.nvim",
				dev = false,
				dependencies = {
					{ "neovim/nvim-lspconfig" },
				},
				opts = {
					lsp = {
						hover = {
							border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
						},
					},
					buffers = {
						-- if set to true, the filetype of the otterbuffers will be set.
						-- otherwise only the autocommand of lspconfig that attaches
						-- the language server will be executed without setting the filetype
						set_filetype = true,
					},
				},
			},
		},
		opts = {
			lspFeatures = {
				languages = { "r", "python", "julia", "bash", "lua", "html", "dot" },
			},
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		tag = nil,
		branch = "master",
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"r",
					"python",
					"markdown",
					"markdown_inline",
					"julia",
					"bash",
					"yaml",
					"lua",
					"vim",
					"query",
					"vimdoc",
					"latex",
					"html",
					"css",
					"dot",
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
					-- optional (with quarto-vim extension and pandoc-syntax)
					-- additional_vim_regex_highlighting = { 'markdown' },

					-- note: the vim regex based highlighting from
					-- quarto-vim / vim-pandoc sets the wrong comment character
					-- for some sections where there is `$` math.
				},
				indent = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn",
						node_incremental = "grn",
						scope_incremental = "grc",
						node_decremental = "grm",
					},
				},
				-- textobjects = {
				-- 	select = {
				-- 		enable = true,
				-- 		lookahead = true,
				-- 		keymaps = {
				-- 			-- You can use the capture groups defined in textobjects.scm
				-- 			["af"] = "@function.outer",
				-- 			["if"] = "@function.inner",
				-- 			["ac"] = "@class.outer",
				-- 			["ic"] = "@class.inner",
				-- 		},
				-- 	},
				-- 	move = {
				-- 		enable = true,
				-- 		set_jumps = true, -- whether to set jumps in the jumplist
				-- 		goto_next_start = {
				-- 			["]m"] = "@function.outer",
				-- 			["]]"] = "@class.inner",
				-- 		},
				-- 		goto_next_end = {
				-- 			["]M"] = "@function.outer",
				-- 			["]["] = "@class.outer",
				-- 		},
				-- 		goto_previous_start = {
				-- 			["[m"] = "@function.outer",
				-- 			["[["] = "@class.inner",
				-- 		},
				-- 		goto_previous_end = {
				-- 			["[M"] = "@function.outer",
				-- 			["[]"] = "@class.outer",
				-- 		},
				-- 	},
				-- },
			})
		end,
	},
	-- { "nvim-treesitter/nvim-treesitter-textobjects" },
	{
		"neovim/nvim-lspconfig",
		tag = nil,
		version = nil,
		branch = "master",
		event = "BufReadPre",
		dependencies = {
			{ "williamboman/mason-lspconfig.nvim" },
			{ "williamboman/mason.nvim" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "folke/neodev.nvim", opt = {} },
			{
				"microsoft/python-type-stubs",
				cond = false,
			},
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				automatic_installation = true,
			})

			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local util = require("lspconfig.util")

			local on_attach = function(client, bufnr)
				local function buf_set_keymap(...)
					vim.api.nvim_buf_set_keymap(bufnr, ...)
				end
				local function buf_set_option(...)
					vim.api.nvim_buf_set_option(bufnr, ...)
				end

				buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
				local opts = { noremap = true, silent = true }

				buf_set_keymap("n", "gS", "<cmd>Telescope lsp_document_symbols<CR>", opts)
				buf_set_keymap("n", "gD", "<cmd>Telescope lsp_type_definitions<CR>", opts)
				buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
				buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
				buf_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
				buf_set_keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
				buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
				buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
				buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
				buf_set_keymap("n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)
				buf_set_keymap("n", "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
				buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
				client.server_capabilities.document_formatting = true
			end

			local on_attach_qmd = function(client, bufnr)
				local function buf_set_keymap(...)
					vim.api.nvim_buf_set_keymap(bufnr, ...)
				end
				local function buf_set_option(...)
					vim.api.nvim_buf_set_option(bufnr, ...)
				end

				buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
				local opts = { noremap = true, silent = true }

				buf_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
				buf_set_keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
				buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
				buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
				buf_set_keymap("n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)
				client.server_capabilities.document_formatting = true
			end

			local lsp_flags = {
				allow_incremental_sync = true,
				debounce_text_changes = 150,
			}

			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					virtual_text = true,
					signs = true,
					underline = true,
					update_in_insert = false,
				})
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
				vim.lsp.handlers.hover,
				{ border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } }
			)
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
				vim.lsp.handlers.signature_help,
				{ border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } }
			)

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			-- See https://github.com/neovim/neovim/issues/23291
			if capabilities.workspace == nil then
				capabilities.workspace = {}
				capabilities.workspace.didChangeWatchedFiles = {}
			end
			capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

			-- also needs:
			-- $home/.config/marksman/config.toml :
			-- [core]
			-- markdown.file_extensions = ["md", "markdown", "qmd"]
			lspconfig.marksman.setup({
				on_attach = on_attach_qmd,
				capabilities = capabilities,
				filetypes = { "markdown", "quarto" },
				root_dir = util.root_pattern(".git", ".marksman.toml", "_quarto.yml"),
			})

			-- -- another optional language server for grammar and spelling
			-- -- <https://github.com/valentjn/ltex-ls>
			-- lspconfig.ltex.setup {
			--   on_attach = on_attach_qmd,
			--   capabilities = capabilities,
			--   filetypes = { "markdown", "tex", "quarto" },
			-- }
			-- LaTeX
			lspconfig["ltex"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "markdown", "tex", "quarto" },
			})
			lspconfig["texlab"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "tex", "plaintex", "bib", "rmd", "quarto" },
			})

			lspconfig.r_language_server.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				flags = lsp_flags,
				settings = {
					r = {
						lsp = {
							rich_documentation = false,
						},
					},
				},
			})

			lspconfig.cssls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				flags = lsp_flags,
			})

			lspconfig.html.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				flags = lsp_flags,
			})

			lspconfig.emmet_language_server.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				flags = lsp_flags,
			})

			lspconfig.yamlls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				flags = lsp_flags,
				settings = {
					yaml = {
						schemaStore = {
							enable = true,
							url = "",
						},
					},
				},
			})

			lspconfig.dotls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				flags = lsp_flags,
			})

			local function strsplit(s, delimiter)
				local result = {}
				for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
					table.insert(result, match)
				end
				return result
			end

			local function get_quarto_resource_path()
				local f = assert(io.popen("quarto --paths", "r"))
				local s = assert(f:read("*a"))
				f:close()
				return strsplit(s, "\n")[2]
			end

			local lua_library_files = vim.api.nvim_get_runtime_file("", true)
			local lua_plugin_paths = {}
			local resource_path = get_quarto_resource_path()
			if resource_path == nil then
				vim.notify_once("quarto not found, lua library files not loaded")
			else
				table.insert(lua_library_files, resource_path .. "/lua-types")
				table.insert(lua_plugin_paths, resource_path .. "/lua-plugin/plugin.lua")
			end

			-- not upadated yet in automatic mason-lspconfig install,
			-- open mason manually with `<space>vm` and `/` search for lua.
			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				flags = lsp_flags,
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						runtime = {
							version = "LuaJIT",
							plugin = lua_plugin_paths,
						},
						diagnostics = {
							globals = { "vim", "quarto", "pandoc", "io", "string", "print", "require", "table" },
							disable = { "trailing-space" },
						},
						workspace = {
							library = lua_library_files,
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			-- See https://github.com/neovim/neovim/issues/23291
			-- disable lsp watcher.
			-- Too slow on linux for
			-- python projects
			-- where pyright and nvim both create many watchers otherwise
			-- if it is not fixed by
			-- capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
			-- up top
			-- local ok, wf = pcall(require, "vim.lsp._watchfiles")
			-- if ok then
			--   wf._watchfunc = function()
			--     return function() end
			--   end
			-- end

			lspconfig.pyright.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				flags = lsp_flags,
				settings = {
					python = {
						stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = false,
							diagnosticMode = "openFilesOnly",
						},
					},
				},
				root_dir = function(fname)
					return util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(
						fname
					) or util.path.dirname(fname)
				end,
			})

			-- lspconfig.jedi_language_server.setup({
			--   on_attach = on_attach,
			--   capabilities = capabilities,
			--   flags = lsp_flags,
			--   settings = {
			--   },
			--   root_dir = function(fname)
			--     return util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(
			--       fname
			--     ) or util.path.dirname(fname)
			--   end,
			-- })

			-- to install pylsp plugins run:
			-- cd ~/.local/share/nvim/mason/packages/python-lsp-server
			-- source venv/bin/activate
			-- pip install mypy
			-- pip install rope
			-- pip install pylsp-rope
			-- pip install python-lsp-black
			-- pip install pylsp-mypy
			--
			-- lspconfig.pylsp.setup({
			--   on_attach = on_attach,
			--   capabilities = capabilities,
			--   flags = lsp_flags,
			--   settings = {
			--     pylsp = {
			--       configurationSources = {
			--       },
			--       plugins = {
			--         pycodestyle = {
			--           ignore = {
			--             'W391',
			--             'W292', -- no blank line after file
			--             'E303', -- blank lines in otter document
			--             'E302', -- blank lines in otter document
			--             'E305', -- blank lines in otter document
			--             'E111', -- indentation is not a multiple of four
			--             'E265', -- magic comments
			--             'E402', -- imports not at top
			--             'E741', -- ambiguous variable name
			--           },
			--           maxLineLength = 120
			--         },
			--         black = {
			--           enabled = true
			--         },
			--         mypy = {
			--           enabled = true,
			--           dmypy = true,
			--           live_mode = false,
			--         },
			--         rope = {
			--
			--         },
			--       }
			--     }
			--   },
			--   root_dir = function(fname)
			--     return util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(
			--       fname
			--     ) or util.path.dirname(fname)
			--   end,
			-- })

			lspconfig.julials.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				flags = lsp_flags,
			})

			lspconfig.bashls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				flags = lsp_flags,
				filetypes = { "sh", "bash" },
			})

			-- Add additional languages here.
			-- See `:h lspconfig-all` for the configuration.
			-- Like e.g. Haskell:
			-- lspconfig.hls.setup {
			--   on_attach = on_attach,
			--   capabilities = capabilities,
			--   flags = lsp_flags
			-- }

			-- lspconfig.rust_analyzer.setup{
			--   on_attach = on_attach,
			--   capabilities = capabilities,
			--   settings = {
			--     ['rust-analyzer'] = {
			--       diagnostics = {
			--         enable = false;
			--       }
			--     }
			--   }
			-- }
		end,
	},

	-- completion
	{
		"hrsh7th/nvim-cmp",
		branch = "main",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-calc" },
			{ "hrsh7th/cmp-emoji" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "f3fora/cmp-spell" },
			{ "ray-x/cmp-treesitter" },
			{ "kdheepak/cmp-latex-symbols" },
			{ "jmbuhr/cmp-pandoc-references" },
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
			{ "onsails/lspkind-nvim" },
			{ "kawre/neotab.nvim" },

			-- optional
			-- more things to try:
			-- {
			-- 	"zbirenbaum/copilot.lua",
			-- 	config = function()
			-- 		require("copilot").setup({
			-- 			suggestion = {
			-- 				enabled = true,
			-- 				auto_trigger = true,
			-- 				debounce = 75,
			-- 				keymap = {
			-- 					accept = "<c-a>",
			-- 					accept_word = false,
			-- 					accept_line = false,
			-- 					next = "<M-]>",
			-- 					prev = "<M-[>",
			-- 					dismiss = "<C-]>",
			-- 				},
			-- 			},
			-- 			panel = { enabled = false },
			-- 		})
			-- 	end,
			-- },
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")
			local neotab = require("neotab")
			lspkind.init()

			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.setup({
				completion = {
					completeopt = "menu,menuone,preview,noselect",
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = {
					["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
					["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.jumpable(1) then
							luasnip.jump(1)
						else
							neotab.tabout()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				autocomplete = false,
				formatting = {
					-- CONFIG 1: SOURCE NAME
					-- format = function(entry, vim_item)
					-- 	local icons = {
					-- 		otter = "[🦦]",
					-- 		copilot = "[]",
					-- 		luasnip = "[snip]",
					-- 		nvim_lsp = "[LSP]",
					-- 		buffer = "[buf]",
					-- 		path = "[path]",
					-- 		spell = "[spell]",
					-- 		pandoc_references = "[ref]",
					-- 		tags = "[tag]",
					-- 		treesitter = "[TS]",
					-- 		calc = "[calc]",
					-- 		latex_symbols = "[tex]",
					-- 		emoji = "[emoji]",
					-- 	}
					-- 	if entry.source.name == "nvim_lsp" then
					-- 		vim_item.menu =
					-- 			string.format("%s %s", icons[entry.source.name], entry.source.source.client.name)
					-- 	else
					-- 		vim_item.menu = icons[entry.source.name]
					-- 	end
					-- 	return vim_item
					-- end,
					-- CONFIG 2: ORIGINAL
					-- format = lspkind.cmp_format({
					--        mode = "text_symbol",
					-- 	menu = {
					-- 		otter = "[🦦]",
					-- 		nvim_lsp = "[LSP]",
					-- 		luasnip = "[snip]",
					-- 		buffer = "[buf]",
					-- 		path = "[path]",
					-- 		spell = "[spell]",
					-- 		pandoc_references = "[ref]",
					-- 		tags = "[tag]",
					-- 		treesitter = "[TS]",
					-- 		calc = "[calc]",
					-- 		latex_symbols = "[tex]",
					-- 		emoji = "[emoji]",
					-- 	},
					-- }),
					-- CONFIG 3: devcons
					-- format = function(entry, vim_item)
					--   if vim.tbl_contains({ 'path' }, entry.source.name) then
					--     local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
					--     if icon then
					--       vim_item.kind = icon
					--       vim_item.kind_hl_group = hl_group
					--       return vim_item
					--     end
					--   end
					--   return require('lspkind').cmp_format({ with_text = false })(entry, vim_item)
					-- end
					-- CONFIG 5: custom
					fields = { "abbr", "kind", "menu" },
					format = function(entry, vim_item)
						local menu
						local kind
						local icons = {
							otter = "[🦦]",
							nvim_lsp = "[LSP]",
							luasnip = "[snip]",
							buffer = "[buf]",
							path = "[path]",
							spell = "[spell]",
							pandoc_references = "[ref]",
							tags = "[tag]",
							treesitter = "[TS]",
							calc = "[calc]",
							latex_symbols = "[tex]",
							emoji = "[emoji]",
						}
            
            if require("lspkind").symbol_map[vim_item.kind] and vim_item.kind then
              kind = require("lspkind").symbol_map[vim_item.kind] .. " " .. vim_item.kind
            else
              kind = vim_item.kind
            end

						if entry.source.name == "nvim_lsp" and entry.source.source.client.name then
							menu = icons[entry.source.name] .. " " .. entry.source.source.client.name
						else
							menu = icons[entry.source.name] or entry.source.name
						end

						vim_item.kind = kind
						vim_item.menu = menu
						return vim_item
					end,
				},
				sources = {
					{ name = "otter" }, -- for code chunks in quarto
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "luasnip" },
					{ name = "pandoc_references" },
					{ name = "buffer" },
					{ name = "spell" },
					{ name = "treesitter" },
					{ name = "calc" },
					{ name = "latex_symbols" },
					{ name = "emoji" },
				},
				-- view = {
				-- 	entries = "native",
				-- },
				-- window = {
				-- 	documentation = {
				-- 		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				-- 	},
				-- },
			})

			-- for friendly snippets
			require("luasnip.loaders.from_vscode").lazy_load()
			-- for custom snippets
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snips" } })
			-- link quarto and rmarkdown to markdown snippets
			luasnip.filetype_extend("quarto", { "markdown" })
			luasnip.filetype_extend("rmarkdown", { "markdown" })
		end,
	},

	-- send code from python/r/qmd documets to a terminal or REPL
	-- like ipython, R, bash
	{
		"jpalardy/vim-slime",
		init = function()
			vim.b["quarto_is_" .. "python" .. "_chunk"] = false
			Quarto_is_in_python_chunk = function()
				require("otter.tools.functions").is_otter_language_context("python")
			end

			vim.cmd([[
      let g:slime_dispatch_ipython_pause = 100
      function SlimeOverride_EscapeText_quarto(text)
      call v:lua.Quarto_is_in_python_chunk()
      if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk
      return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
      else
      return a:text
      end
      endfunction
      ]])

			-- local function mark_terminal()
			-- 	vim.g.slime_last_channel = vim.b.terminal_job_id
			-- 	vim.print(vim.g.slime_last_channel)
			-- end
			--
			-- local function set_terminal()
			-- 	vim.b.slime_config = { jobid = vim.g.slime_last_channel }
			-- end

			vim.b.slime_cell_delimiter = "# %%"
			vim.g.slime_no_mappings = 1

			-- -- slime, neovvim terminal
			-- vim.g.slime_target = "neovim"
			-- vim.g.slime_python_ipython = 1

			-- slime, tmux
			vim.g.slime_target = "tmux"
			vim.g.slime_bracketed_paste = 1
			vim.g.slime_default_config = { socket_name = "default", target_pane = "2" }
			vim.g.slime_dont_ask_default = 1

			-- local function toggle_slime_tmux_nvim()
			-- 	if vim.g.slime_target == "tmux" then
			-- 		pcall(function()
			-- 			vim.b.slime_config = nil
			-- 			vim.g.slime_default_config = nil
			-- 		end)
			-- 		-- slime, neovvim terminal
			-- 		vim.g.slime_target = "neovim"
			-- 		vim.g.slime_bracketed_paste = 0
			-- 		vim.g.slime_python_ipython = 1
			-- 	elseif vim.g.slime_target == "neovim" then
			-- 		pcall(function()
			-- 			vim.b.slime_config = nil
			-- 			vim.g.slime_default_config = nil
			-- 		end)
			-- 		-- -- slime, tmux
			-- 		vim.g.slime_target = "tmux"
			-- 		vim.g.slime_bracketed_paste = 1
			-- 		vim.g.slime_default_config = { socket_name = "default", target_pane = "2" }
			-- 	end
			-- end
			--
			-- require("which-key").register({
			-- 	["<leader>cm"] = { mark_terminal, "mark terminal" },
			-- 	["<leader>cs"] = { set_terminal, "set terminal" },
			-- 	["<leader>ct"] = { toggle_slime_tmux_nvim, "toggle tmux/nvim terminal" },
			-- })
		end,
	},

	-- paste an image to markdown from the clipboard
	-- :PasteImg,
	{
		"dfendr/clipboard-image.nvim",
		keys = {
			{ "<leader>ip", ":PasteImg<cr>", desc = "image paste" },
		},
		cmd = {
			"PasteImg",
		},
		config = function()
			require("clipboard-image").setup({
				quarto = {
					img_dir = "img",
					affix = "![](%s)",
				},
			})
		end,
	},

	-- preview equations
	{
		"jbyuki/nabla.nvim",
		keys = {
			{ "<leader>ee", ':lua require"nabla".toggle_virt()<cr>', "toggle equations" },
			{ "<leader>eh", ':lua require"nabla".popup()<cr>', "hover equation" },
		},
	},

	-- {
	--   "benlubas/molten-nvim",
	--   build = ":UpdateRemotePlugins",
	--   init = function()
	--     vim.g.molten_image_provider = "image.nvim"
	--     vim.g.molten_output_win_max_height = 20
	--     vim.g.molten_auto_open_output = false
	--   end,
	--   keys = {
	--     { "<leader>mi", ":MoltenInit<cr>",                desc = "molten init" },
	--     { "<leader>mv", ":<C-u>MoltenEvaluateVisual<cr>", mode = "v",                  desc = "molten eval visual" },
	--     { "<leader>mr", ":MoltenReevaluateCell<cr>",      desc = "molten re-eval cell" },
	--   }
	-- },
}
