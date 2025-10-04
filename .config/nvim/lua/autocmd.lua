-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Remember last edit position of a file",
	group = vim.api.nvim_create_augroup("remember-last-edit-position", { clear = true }),
	callback = function()
		local filename = vim.api.nvim_buf_get_name(0)
		if filename:match("%.git/COMMIT_EDITMSG$") then
			return
		end
		if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.fn.setpos(".", vim.fn.getpos("'\""))
		end
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Set different indentation for .c and .h files",
	group = vim.api.nvim_create_augroup("c-h-indentation", { clear = true }),
	pattern = { "*.c", "*.h" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = true
	end,
})

vim.api.nvim_create_autocmd("VimResized", {
	group = vim.api.nvim_create_augroup("auto-resize", { clear = true }),
	desc = "Automatically resize windows during splits",
	pattern = "*",
	command = "wincmd =",
})
