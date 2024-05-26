-- Function and autocommand configuration
local function close_tab_if_no_buffers()
	local buffers = vim.api.nvim_list_bufs()
	local buffer_count = 0

	for _, buf in ipairs(buffers) do
		local buf_name = vim.api.nvim_buf_get_name(buf)
		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted and (buf_name ~= "") then
			buffer_count = buffer_count + 1
		end
	end

	if buffer_count == 0 then
		vim.cmd("confirm q")
	else
	end
end

vim.api.nvim_create_autocmd("BufDelete", {
	callback = function()
		close_tab_if_no_buffers()
	end,
})
