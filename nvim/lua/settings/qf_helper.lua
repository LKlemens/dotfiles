local status_ok, gitsigns = pcall(require, "qf_helper")
if not status_ok then
	return
end

-- use <C-N> and <C-P> for next/prev.
vim.keymap.set("n", "[q", "<CMD>QNext<CR>")
vim.keymap.set("n", "]q", "<CMD>QPrev<CR>")
-- toggle the quickfix open/closed without jumping to it
vim.keymap.set("n", "<leader>q", "<CMD>QFToggle!<CR>")
vim.keymap.set("n", "<leader>a", "<CMD>LLToggle!<CR>")
