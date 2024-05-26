local formatter_ok, formatter = pcall(require, "formatter")
if not formatter_ok then
	return
end

local prettier = function()
	if not vim.g.formatter then
		return {}
	else
		return {
			require("formatter.filetypes.javascript").prettier,
		}
	end
end

local remove_trailing_whitespace = function()
	if not vim.g.formatter then
		return {}
	else
		-- write sleep in lua
		return {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		}
	end
end

vim.g.formatter = true

formatter.setup({
	logging = true,
	filetype = {
		javascript = { prettier },
		json = { prettier },
		typescript = { prettier },
		html = { prettier },
		css = { prettier },
		scss = { prettier },
		markdown = { prettier },
		yaml = { require("formatter.filetypes.yaml").yamlfmt },
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		elixir = {
			-- mix format
			function()
				if not vim.g.formatter then
					return {}
				else
					return {
						exe = "mix format",
						args = { vim.api.nvim_buf_get_name(0) },
						stdin = false,
						ignore_exitcode = false,
					}
				end
			end,
		},
		["*"] = {
			-- "formatter.filetypes.any" defines default configurations for any
			-- filetype
			remove_trailing_whitespace,
		},
	},
})

local format_augroup = vim.api.nvim_create_augroup("format-custom", { clear = true })
local function refresh()
	vim.cmd("e!")
end
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = format_augroup,
	callback = function()
		vim.cmd("Format")
		vim.defer_fn(refresh, 1000)
	end,
})
