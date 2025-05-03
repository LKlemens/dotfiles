local config = require("session_manager.config")
local session_manager = require("session_manager")
require("session_manager").setup({
	autosave_only_in_session = true,
	autoload_mode = config.AutoloadMode.CurrentDir,
})

map("n", "<leader>x", "<cmd>SessionManager save_current_session<cr>", options)

-- Function to count open buffers
local function count_buffers()
	local count = 0
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
			local buf_name = vim.api.nvim_buf_get_name(buf)
			-- Check if the buffer name contains "rst"
			if not string.match(buf_name, "rst") then
				count = count + 1
			end
		end
	end
	return count
end

-- Create a new augroup
local session_manager_group = vim.api.nvim_create_augroup("SessionManager", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	group = session_manager_group,
	nested = true,
	callback = session_manager.autoload_session,
})
-- Autocommand to save session when there are more than 4 buffers
vim.api.nvim_create_autocmd("VimLeavePre", {
	group = session_manager_group,
	callback = function()
		if count_buffers() > 3 then
			session_manager.save_current_session()
		end
	end,
})
vim.api.nvim_create_autocmd({ "StdinReadPre" }, {
	group = session_manager_group,
	callback = function()
		vim.g.started_with_stdin = true
	end,
})

-- Timer to save session every 15 minutes (900000 milliseconds)
local timer = vim.loop.new_timer()
timer:start(
	0,
	900000,
	vim.schedule_wrap(function()
		if count_buffers() > 2 then
			session_manager.save_current_session()
		end
	end)
)
