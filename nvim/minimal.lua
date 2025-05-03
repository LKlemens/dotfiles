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
  "nvim-treesitter/nvim-treesitter",
  {
    "akinsho/bufferline.nvim",
    version = "v4.6.0",
    dependencies = "nvim-tree/nvim-web-devicons",
  },
  {
    "Shatur/neovim-session-manager",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local config = require("session_manager.config")
      require("session_manager").setup({
        autosave_only_in_session = false,
        autoload_mode = config.AutoloadMode.CurrentDir,
      })
    end,
  },
}

require("lazy").setup(plugins)
require("settings.bufferline_min")
