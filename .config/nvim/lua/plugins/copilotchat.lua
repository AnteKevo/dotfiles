return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		enabled = function()
			return vim.uv.fs_stat("~/.workrc")
		end,
		build = "make tiktoken",
		opts = {
			-- See Configuration section for options
		},
		lazy = false,
		keys = {
			{ "<leader>zc", ":CopilotChat<CR>", mode = "n", desc = "Chat with Copilot" },
		},
	},
}
