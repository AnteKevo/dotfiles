local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		-- Detect tabstop and shiftwidth automatically
		"tpope/vim-sleuth",
		-- Adds git related signs to the gutter, as well as utilities for managing
		-- changes
		{ "lewis6991/gitsigns.nvim", import = "plugins.gitsigns" },
		-- Useful plugin to show you pending keybinds.
		{ "folke/which-key.nvim", import = "plugins.which-key" },
		-- Fuzzy Finder (files, lsp, etc)
		{ "nvim-telescope/telescope.nvim", import = "plugins.telescope" },

		-- LSP Plugins
		{
			-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
			-- used for completion, annotations and signatures of Neovim apis
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					-- Load luvit types when the `vim.uv` word is found
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
				},
			},
		},
		{ "Bilal2453/luvit-meta", lazy = true },
		{ "neovim/nvim-lspconfig", import = "plugins.lsp" },
		{ -- Autoformat
			"stevearc/conform.nvim",
			event = { "BufWritePre" },
			cmd = { "ConformInfo" },
			keys = {
				{
					"<leader>f",
					function()
						require("conform").format({ async = true, lsp_format = "fallback" })
					end,
					mode = "",
					desc = "[F]ormat buffer",
				},
			},
			opts = {
				notify_on_error = false,
				format_on_save = function(bufnr)
					-- Disable "format_on_save lsp_fallback" for languages that don't
					-- have a well standardized coding style. You can add additional
					-- languages here or re-enable it for the disabled ones.
					local disable_filetypes = { c = true, cpp = true }
					local lsp_format_opt
					if disable_filetypes[vim.bo[bufnr].filetype] then
						lsp_format_opt = "never"
					else
						lsp_format_opt = "fallback"
					end
					return {
						timeout_ms = 500,
						lsp_format = lsp_format_opt,
					}
				end,
				formatters_by_ft = {
					lua = { "stylua" },
					rust = { "rustfmt" },
					go = { "gofmt" },
					-- Conform can also run multiple formatters sequentially
					-- python = { "isort", "black" },
					--
					-- You can use 'stop_after_first' to run the first available formatter from the list
					-- javascript = { "prettierd", "prettier", stop_after_first = true },
				},
			},
		},

		-- Autoformatter
		{ "hrsh7th/nvim-cmp", import = "plugins.autofmt" },

		-- Statusline
		{ "echasnovski/mini.nvim", import = "plugins.mini" },
		{ -- You can easily change to a different colorscheme.
			-- Change the name of the colorscheme plugin below, and then
			-- change the command in the config to whatever the name of that colorscheme is.
			--
			-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
			"shaunsingh/nord.nvim",
			priority = 1000, -- Make sure to load this before all the other start plugins.
			init = function()
				-- Load the colorscheme here.
				-- Like many other themes, this one has different styles, and you could load
				-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
				vim.cmd.colorscheme("nord")

				-- You can configure highlights by doing something like:
				vim.cmd.hi("Comment gui=none")
			end,
		},

		-- Highlight todo, notes, etc in comments
		{
			"folke/todo-comments.nvim",
			event = "VimEnter",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = { signs = false },
		},

		-- Highlight, edit, and navigate code
		{ "nvim-treesitter/nvim-treesitter", import = "plugins.treesitter" },
		-- Auto add parathenis
		{ "windwp/nvim-autopairs", import = "plugins.autopairs" },
		-- File system navigator
		{ "nvim-neo-tree/neo-tree.nvim", import = "plugins.neo-tree" },
		ui = {
			icons = vim.g.have_nerd_font and {} or {
				cmd = "⌘",
				config = "🛠",
				event = "📅",
				ft = "📂",
				init = "⚙",
				keys = "🗝",
				plugin = "🔌",
				runtime = "💻",
				require = "🌙",
				source = "📄",
				start = "🚀",
				task = "📌",
				lazy = "💤 ",
			},
		},
	},
})
