-- lazy config
-- .local/share/nvim/lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	-- LSP
	"neovim/nvim-lspconfig",
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "rust_analyzer", "elixirls", "tsserver" },
			})
		end,
	},
	"L3MON4D3/LuaSnip",

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	-- cmp
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "saadparwaiz1/cmp_luasnip" }, -- snippet completions
	{ "hrsh7th/cmp-nvim-lua" },
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mollerhoj/telescope-recent-files.nvim",
		},
	},

	-- Treesitter
	"nvim-treesitter/nvim-treesitter",
	"xiyaowong/nvim-transparent",

	-- colorschemes
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	"sainnhe/everforest",

	--fzf
	"junegunn/fzf",
	"junegunn/fzf.vim",
	"alok/notational-fzf-vim", -- nice flow through notations

	{
		"smoka7/hop.nvim",
		version = "*",
		opts = {
			keys = "etovxqpdygfblzhckisuran",
		},
	},

	{
		"jiaoshijie/undotree",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
		keys = { -- load the plugin only when using it's keybinding:
			{ "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
		},
	},
	"christoomey/vim-tmux-navigator",
	"mhartington/formatter.nvim",
	"lewis6991/gitsigns.nvim",
	"sickill/vim-pasta", -- correct indent when pasting
	"f-person/git-blame.nvim",
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({})
		end,
	},
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	"tpope/vim-endwise", -- add #endif etc at the end
	"rhysd/clever-f.vim",
	"unblevable/quick-scope", -- Vim plugin that highlights which characters to target for f, F and family.
	"tpope/vim-repeat",
	"tpope/vim-surround",
	"tpope/vim-eunuch", -- Vim sugar for the UNIX shell commands that need it the most. Move,Rename etc
	"szw/vim-maximizer",
	"inside/vim-search-pulse",

	"wellle/targets.vim",
	"michaeljsmith/vim-indent-object",
	"alvan/vim-closetag",
	"b3nj5m1n/kommentary",
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equalent to setup({}) function
	},

	"vim-utils/vim-interruptless", -- preventing the interruption

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({})
		end,
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
		},
	},
	"mfussenegger/nvim-lint",
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	-- <C-e>
	"simeji/winresizer",
	{
		"cbochs/grapple.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", lazy = true },
		},
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		config = function()
			require("telescope").load_extension("frecency")
		end,
	},
	"edkolev/tmuxline.vim",
	{
		"ethanholz/nvim-lastplace",
		config = function()
			require("nvim-lastplace").setup({})
		end,
	},
	{
		"Shatur/neovim-session-manager",
		config = function()
			local config = require("session_manager.config")
			require("session_manager").setup({
				autosave_only_in_session = true,
				autoload_mode = config.AutoloadMode.CurrentDir,
			})
		end,
	},
}

require("lazy").setup(plugins)
