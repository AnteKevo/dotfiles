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
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
		{ "neovim/nvim-lspconfig", import = "plugins.lsp" },

		-- Autoformat
		{ "stevearc/conform.nvim", import = "plugins.autofmt" },
		{ "saghen/blink.cmp", import = "plugins.autofmt" },

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
		-- GitHub Copilot chat
		{ "CopilotC-Nvim/CopilotChat.nvim", import = "plugins.copilotchat" },
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
