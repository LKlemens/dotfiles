map("n", "[w", "<cmd>:BufferLineMovePrev<cr>", options)
map("n", "]w", "<cmd>:BufferLineMoveNext<cr>", options)
map("n", "<C-M-k>", "<cmd>BufferLineCycleNext<cr>", { silent = true })
map("n", "<C-M-j>", "<cmd>BufferLineCyclePrev<cr>", { silent = true })
map("n", "<leader>bp", "<cmd>BufferLineTogglePin<CR>", options)
map("n", "<leader>bgt", "<cmd>BufferLineGroupToggle Tests<CR>", options)
map("n", "<leader>bc", "<cmd>BufferLineCloseOthers<CR>", options)

local groups = require("bufferline.groups")

require("bufferline").setup({
	options = {
		separator_style = "slope",
		buffer_close_icon = "",
		hover = {
			enabled = true,
			delay = 200,
			reveal = { "close" },
		},
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
		show_close_icon = false,
		sort_by = "insert_at_end",
		persist_buffer_sort = true,
		groups = {
			options = {
				toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
			},
			items = {
				{
					name = "Tests", -- Mandatory
					highlight = { underline = true, sp = "lightblue" }, -- Optional
					auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
					priority = 2, -- determines where it will appear relative to other groups (Optional)
					icon = "", -- Optional
					matcher = function(buf) -- Mandatory
						if buf.id ~= nil then
							return buf.name:match("%_test") or buf.name:match("%_spec")
						else
							return false
						end
					end,
				},
				{
					name = "Docs",
					highlight = { underline = true, sp = "lightgreen" },
					auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
					priority = 3, -- determines where it will appear relative to other groups (Optional)
					matcher = function(buf)
						-- todo
						return false
					end,
				},
			},
		},
	},
})
