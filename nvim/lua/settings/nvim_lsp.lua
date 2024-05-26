-- mappings

local map_opts = { noremap = true, silent = true }
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", map_opts)
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", map_opts)
map("n", "gd", "<cmd>lua vim.lsp.buf.show_line_diagnostics()<cr>", map_opts)
map("n", "dt", "<cmd>lua vim.lsp.buf.definition()<cr>", map_opts)
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", map_opts)
map("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<cr>", map_opts)
map("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<cr>", map_opts)
map("n", "<leader>va", "<cmd>lua vim.lsp.buf.code_action()<cr>", map_opts)

-- Key mapping for going to the next diagnostic
vim.api.nvim_set_keymap(
	"n",
	"]d",
	"<cmd>lua vim.diagnostic.goto_next({ severity = { min = vim.diagnostic.severity.HINT }})<CR>",
	{ noremap = true, silent = true }
)
-- Key mapping for going to the previous diagnostic
vim.api.nvim_set_keymap(
	"n",
	"[d",
	"<cmd>lua vim.diagnostic.goto_prev({ severity = { min = vim.diagnostic.severity.WARN }})<CR>",
	{ noremap = true, silent = true }
)

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local path_to_elixirls = vim.fn.expand("~/.elixir-ls/0.21.3/language_server.sh")

local lspconfig = require("lspconfig")

lspconfig.tsserver.setup({})
lspconfig.lua_ls.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.elixirls.setup({
	cmd = { path_to_elixirls },
	capabilities = capabilities,
	settings = {
		elixirLS = {
			-- I choose to disable dialyzer for personal reasons, but
			-- I would suggest you also disable it unless you are well
			-- aquainted with dialzyer and know how to use it.
			dialyzerEnabled = false,
			-- I also choose to turn off the auto dep fetching feature.
			-- It often get's into a weird state that requires deleting
			-- the .elixir_ls directory and restarting your editor.
			fetchDeps = false,
		},
	},
})

lspconfig.efm.setup({
	capabilities = capabilities,
	filetypes = { "elixir" },
})
