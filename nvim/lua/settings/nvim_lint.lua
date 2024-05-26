--[[ local cmp_status_ok, cmp = pcall(require, "nvim-lint")
if not cmp_status_ok then
	return
end ]]

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })

local lint = require("lint")

lint.linters_by_ft = {
	elixir = { "credo" },
	javascript = { "biomejs" },
	typescript = { "biomejs" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

local function try_lint()
	lint.try_lint()
end

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
	group = lint_augroup,
	callback = function()
		vim.defer_fn(try_lint, 3000)
	end,
})
