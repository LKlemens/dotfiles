map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", options)
map("n", "<leader>ag", "<cmd>Telescope grep_string<cr>", options)
map("n", "<leader>we", "<cmd>Telescope buffers<cr>", options)
-- map("n", "<leader>qw", "<cmd>:Telescope frecency workspace=CWD <cr>", options)
-- map("n", "<leader>qw", "<cmd>:Telescope oldfiles<cr>", options)
-- map("n", "<c-p>", "<cmd>Telescope find_files<cr>", options)
-- require("telescope").extensions["recent-files"].recent_files({})

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local attach_mappings = function(_, map)
	actions.select_default:replace(function(prompt_bufnr)
		local picker = action_state.get_current_picker(prompt_bufnr)
		local multi_selection = picker:get_multi_selection()
		local selection = action_state.get_selected_entry()
		actions.close(prompt_bufnr)
		if #multi_selection == 0 then
			vim.cmd(string.format(":edit %s", selection.path))
		else
			for _, entry in ipairs(multi_selection) do
				vim.cmd(string.format(":edit %s", entry.path))
			end
		end
	end)
	return true
end

vim.keymap.set("n", "<c-p>", function()
	require("telescope").extensions["recent-files"].recent_files({ attach_mappings = attach_mappings })
end, {
	noremap = true,
	silent = true,
})

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<C-l>"] = actions.preview_scrolling_up,
				["<C-h>"] = actions.preview_scrolling_down,
				["<C-t>"] = actions.select_default,
				["<C-u>"] = function(prompt_bufnr)
					local picker = action_state.get_current_picker(prompt_bufnr)
					picker:set_prompt("")
				end,
				["<Tab>"] = function(prompt_bufnr)
					local picker = action_state.get_current_picker(prompt_bufnr)
					local multi_select = require("telescope.actions").toggle_selection
					multi_select(prompt_bufnr)
					actions.move_selection_next(prompt_bufnr)
				end,
				-- Optionally, map <S-Tab> to add selection and move to the previous item
				["<S-Tab>"] = function(prompt_bufnr)
					local picker = action_state.get_current_picker(prompt_bufnr)
					local multi_select = require("telescope.actions").toggle_selection
					multi_select(prompt_bufnr)
					actions.move_selection_previous(prompt_bufnr)
				end,
			},
		},
	},
	pickers = {
		find_files = {},
		buffers = {
			sort_mru = true,
			ignore_current_buffer = true,
		},
		oldfiles = {
			cwd_only = true,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		frecency = {
			-- This has the 2nd precedence.
			path_display = { "shorten" },
		},
		recent_files = {
			attach_mappings = function(_, j)
				actions.select_default:replace(function(prompt_bufnr)
					local picker = action_state.get_current_picker(prompt_bufnr)
					local multi_selection = picker:get_multi_selection()
					actions.close(prompt_bufnr)
					for _, entry in ipairs(multi_selection) do
						vim.cmd(string.format(":edit %s", entry.path))
					end
				end)
				return true
			end,
		},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("recent-files")
