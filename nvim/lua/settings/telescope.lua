map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", options)
map("n", "<leader>ag", "<cmd>Telescope grep_string<cr>", options)
map("n", "<leader>we", "<cmd>Telescope buffers<cr>", options)
map("n", "<leader>y", "<cmd>Telescope neoclip<cr>", options)
map("n", "<leader>fs", "<cmd>:Telescope lsp_document_symbols<cr>", options)
map("n", "<leader>dc", "<cmd>:AdvancedGitSearch diff_commit_file<cr>", options)
map("n", "<leader>dv", "<cmd>:AdvancedGitSearch search_log_content<cr>", options)
-- map("n", "<leader>ag", "<cmd>Telescope live_grep<cr>", options)
-- map("n", "<leader>qw", "<cmd>:Telescope frecency workspace=CWD <cr>", options)
-- map("n", "<leader>qw", "<cmd>:Telescope oldfiles<cr>", options)
-- map("n", "<c-p>", "<cmd>Telescope find_files<cr>", options)
-- require("telescope").extensions["recent-files"].recent_files({})

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local attach_mappings = function(_, _)
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
				["<C-p>"] = actions.cycle_history_prev,
				["<C-n>"] = actions.cycle_history_next,
				["<C-u>"] = function(prompt_bufnr)
					local picker = action_state.get_current_picker(prompt_bufnr)
					picker:set_prompt("")
				end,
				["<Tab>"] = function(prompt_bufnr)
					local multi_select = require("telescope.actions").toggle_selection
					multi_select(prompt_bufnr)
					actions.move_selection_next(prompt_bufnr)
				end,
				-- Optionally, map <S-Tab> to add selection and move to the previous item
				["<S-Tab>"] = function(prompt_bufnr)
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
		recent_files = {},
	},
})

local mapping = require("yanky.telescope.mapping")

require("yanky").setup({
	ring = {
		history_length = 2000,
	},
	picker = {
		telescope = {
			mappings = {
				default = mapping.put("p"),
				i = {
					["<c-g>"] = mapping.put("p"),
					["<c-x>"] = mapping.delete(),
					["<c-r>"] = mapping.set_register("s"),
					["<c-k>"] = actions.move_selection_previous,
					["<c-j>"] = actions.move_selection_next,
				},
			},
		},
	},
})

-- Define a custom command to alias Telescope live_grep
vim.api.nvim_create_user_command(
	"Ag", -- The name of your new command
	function()
		local telescope = require("telescope.builtin")
		telescope.live_grep()
	end,
	{ nargs = 0 } -- No arguments required for this command
)
require("neoclip").setup({
	history = 1000,
	enable_persistent_history = true,
	continuous_sync = true,
	default_register = { '"', "+", "*" },
	keys = {
		telescope = {
			i = {
				select = "<cr>",
				paste = "<c-p>",
				paste_behind = "<c-p>",
				replay = "<c-q>", -- replay a macro
				delete = "<c-d>", -- delete an entry
				edit = "<c-e>", -- edit an entry
				["<c-k>"] = actions.move_selection_previous,
				["<c-j>"] = actions.move_selection_next,
				custom = {
					["<cr>"] = function(opts)
						local handlers = require("neoclip.handlers")
						handlers.set_registers(opts.register_names, opts.entry)
						print(vim.inspect(opts))
					end,
				},
			},
			n = {
				select = "<cr>",
				paste = "p",
				--- It is possible to map to more than one key.
				-- paste = { 'p', '<c-p>' },
				paste_behind = "P",
				replay = "q",
				delete = "d",
				edit = "e",
				["<c-k>"] = actions.move_selection_previous,
				["<c-j>"] = actions.move_selection_next,
				custom = {},
			},
		},
		fzf = {
			select = "default",
			paste = "ctrl-p",
			paste_behind = "ctrl-p",
			["<c-k>"] = actions.move_selection_previous,
			["<c-j>"] = actions.move_selection_next,
			custom = {},
		},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("recent-files")
-- require("telescope").load_extension("yank_history")
require("telescope").load_extension("neoclip")
require("telescope").load_extension("advanced_git_search")
