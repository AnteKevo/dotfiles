-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Remember last edit position of a file
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

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
