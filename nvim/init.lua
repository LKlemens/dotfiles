local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set options

opt.hidden = true -- Enable background buffers
opt.backspace = { "indent", "eol", "start" }
opt.hlsearch = true -- Highlight found searches
opt.joinspaces = false -- No double spaces with join
opt.list = false -- Show some invisible characters
opt.linebreak = true -- Stop words being broken on wrap
opt.numberwidth = 5 -- Make the gutter wider by default
opt.relativenumber = true -- Relative line numbers

opt.clipboard = "unnamedplus"
opt.foldmethod = "syntax"
opt.foldlevelstart = 99
opt.smartindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.number = true
opt.termguicolors = true
opt.backupdir = vim.fn.expand("~/.tmp/backup")
opt.directory = vim.fn.expand("~/.tmp/swp")
opt.splitbelow = true
opt.splitright = true
opt.lazyredraw = true
opt.showmode = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.undofile = true
opt.undodir = vim.fn.expand("~/.tmp")
opt.mouse = "a"
opt.errorbells = false
opt.visualbell = true
-- opt.t_vb = ""
opt.cursorline = true
opt.inccommand = "nosplit"
opt.background = "dark"
opt.autoread = true
opt.swapfile = false --  Disables creating swap files.
vim.g.forest_night_enable_italic = 1
vim.g.forest_night_diagnostic_text_highlight = 1

-- Map leader to comma
g.mapleader = ","

options = { noremap = true }
local map = vim.api.nvim_set_keymap
map("i", "jk", "<esc>", options)
map("i", "kj", "<esc>", options)

map("n", "<leader>t", "<cmd>:tabe<cr>", options)

map("n", "<space>", "i<space><esc>", options)

-- Open nvimrc file
map("n", "vv", "<cmd>tabe $MYVIMRC<CR>", options)

-- Source nvimrc file
map("n", "<Leader>so", ":luafile %<CR>", options)

-- Easier file save
map("n", "<Leader>w", "<cmd>:w<CR>", options)

-- Close
map("n", "qq", "<cmd>q<CR>", options)

-- get date
map("i", "<F6>", "<C-R>=strftime('%d/%m/%Y')<cr><cr>##########", options)

-- clear highlight
map("n", "<leader><cr>", "<cmd>:nohlsearch<cr>", options)

-- [w ]w - Forward and backwards tabs
map("n", "[w", "<cmd>:tabmove -1<cr>", options)
map("n", "]w", "<cmd>:tabmove +1<cr>", options)

--autocmds
vim.cmd("source ~/.config/nvim/auto.vim")

vim.cmd([[packadd packer.nvim]])

local startup = require("packer").startup

startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- language server configurations
  use("neovim/nvim-lspconfig")

  -- autocomplete and snippets
  use("hrsh7th/nvim-compe")
  use("hrsh7th/vim-vsnip")
  use("hrsh7th/vim-vsnip-integ")
  use("sainnhe/everforest")
  use("elixir-editors/vim-elixir")
  use("mhartington/formatter.nvim")
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
  })
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use({
    "hoob3rt/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })
  use("easymotion/vim-easymotion")
  use({
    "phaazon/hop.nvim",
    as = "hop",
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
    end,
  })
  use("glepnir/lspsaga.nvim")
  use("alvan/vim-closetag")
  use("b3nj5m1n/kommentary")
  use("windwp/nvim-autopairs")
  use({
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    -- tag = 'release' -- To use the latest release
  })
  use("p00f/nvim-ts-rainbow") -- TODO won't work
  use("rmagatti/auto-session")
  use("tpope/vim-repeat")
  use("tpope/vim-surround")
  use("wellle/targets.vim")
  use("michaeljsmith/vim-indent-object")
  use("christoomey/vim-tmux-navigator")

  -- Plug 'osyo-manga/vim-brightest'
  -- Plug 'wellle/visual-split.vim'
  -- Plug 'hauleth/asyncdo.vim'
  -- Plug 'haya14busa/vim-metarepeat'
  -- Plug 'haya14busa/vim-gtrans'
  --
  use("eapache/rainbow_parentheses.vim")
  use("junegunn/fzf")
  use("junegunn/fzf.vim")
  use("mbbill/undotree")
  use("alok/notational-fzf-vim") -- nice flow through notations
  --
  -- Plug 'MattesGroeger/vim-bookmarks'
  --
  --   use("inkarkat/vim-mark") -- Highlight several words in different colors simultaneously
  use("rhysd/clever-f.vim")
  use("unblevable/quick-scope") -- Vim plugin that highlights which characters to target for f, F and family.
  use("sickill/vim-pasta") -- correct indent when pasting
  --
  -- textobj
  use("kana/vim-textobj-function")
  use("glts/vim-textobj-comment")
  use("kana/vim-textobj-indent")
  use("kana/vim-textobj-user")
  --
  -- Plug 'FooSoft/vim-argwrap'
  --
  --
  -- Plug 'tommcdo/vim-exchange' "exchange words cx
  use("tpope/vim-endwise") -- add #endif etc at the end
  --
  use("vim-utils/vim-interruptless") -- load file automatically
  -- Plug 'vim-utils/vim-vertical-move' -- . These move a cursor 'up' or 'down' as many lines as possible without changing the cursor column [v ]v
  -- Plug 'osyo-manga/vim-anzu' " count appearances of search pattern
  use("tpope/vim-eunuch") -- Vim sugar for the UNIX shell commands that need it the most. Move,Rename etc
  -- Plug 'tpope/vim-unimpaired' " pairs of handy bracket mappings
  -- Plug 'junegunn/vim-easy-align'
  use("szw/vim-maximizer")
  -- Plug 'tenfyzhong/axring.vim' " ax enhancement c-a c-x
  --
  -- Plug 'Chiel92/vim-autoformat'
  -- Plug 'justinmk/vim-dirvish'
  --
  use("rhysd/committia.vim") -- more pleasant git commit
  use("f-person/git-blame.nvim")
  --
  -- Plug 'terryma/vim-expand-region'
  -- Plug 'machakann/vim-swap'
  -- Plug 'nelstrom/vim-visual-star-search'
  -- Plug 'jaxbot/selective-undo.vim'
  -- Plug 'Rykka/riv.vim'
  -- Plug 'Rykka/InstantRst'
  use("inside/vim-search-pulse")
  use("karb94/neoscroll.nvim")
  use("TC72/telescope-tele-tabby.nvim")
  use({
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({})
    end,
  })
  --use "lewis6991/gitsigns.nvim" --
  -- use("ray-x/lsp_signature.nvim") -- signature hints
  -- Plug 'chrisbra/vim-diff-enhanced'
  -- Plug 'dbmrq/vim-ditto' " Ditto Stop repeating yourself
  -- Plug 'reedes/vim-wordy' "Uncover usage problems in your writing, Wordy tab
  -- Plug 'rhysd/vim-grammarous' " GrammarousCheck
  -- Plug 'beloglazov/vim-online-thesaurus' "OnlineThesaurusCurrentWord, Thesaurus word ,K
  -- Plug 'sedm0784/vim-you-autocorrect'
  -- Plug 'reedes/vim-pencil' "Pencil , SoftPencil
end)

-- nvim-tree
require("nvim-tree").setup()
map("n", "<C-n>", "<cmd>:NvimTreeToggle<CR>", options)

--telescope tabs
map("n", "<leader>we", "<cmd>:Telescope tele_tabby list<cr>", options)

--neoscroll
require("neoscroll").setup()

-- autosession
local opts = {
  log_level = "info",
  auto_session_enable_last_session = false,
  auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
  auto_session_enabled = false,
  auto_save_enabled = true,
  auto_restore_enabled = nil,
  auto_session_suppress_dirs = nil,
}

require("auto-session").setup(opts)

-- gitsigns
require("gitsigns").setup()

-- autopairs
require("nvim-autopairs").setup({})

-- HOP
map("n", "s", "<cmd>HopChar2<cr>", options)

local lspconfig = require("lspconfig")

--lualine
-- require("lualine").setup({
--   options = { theme = "gruvbox" },
-- })
-- require("nvim-web-devicons").setup()

-- location icon: ?
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "gruvbox",
  },
  sections = {
    lualine_c = {
      { "diagnostics", sources = { "nvim_lsp" } },
      function()
        return "%="
      end,
      "filename",
      { getWords },
    },
  },
})

-- treesitter
require("nvim-treesitter.configs").setup({
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  },
})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("fzf")

-- Neovim doesn't support snippets out of the box, so we need to mutate the
-- capabilities we send to the language server to let them know we want snippets.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Setup our autocompletion. These configuration options are the default ones
-- copied out of the documentation.
require("compe").setup({
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "disabled",
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,
  source = {
    path = true,
    buffer = true,
    calc = true,
    vsnip = true,
    nvim_lsp = true,
    nvim_lua = true,
    spell = true,
    tags = true,
    treesitter = true,
  },
})

-- A callback that will get called when a buffer connects to the language server.
-- Here we create any key maps that we want to have on that buffer.
local on_attach = function(_, bufnr)
  local function map(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local map_opts = { noremap = true, silent = true }

  -- lsp config klemens
  map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", map_opts)
  map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", map_opts)
  map("n", "df", "<cmd>lua vim.lsp.buf.formatting()<cr>", map_opts)
  map("n", "gd", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", map_opts)
  map("n", "dt", "<cmd>lua vim.lsp.buf.definition()<cr>", map_opts)
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", map_opts)
  map("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<cr>", map_opts)
  map("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", map_opts)
  map("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<cr>", map_opts)

  -- These have a different style than above because I was fiddling
  -- around and never converted them. Instead of converting them
  -- now, I'm leaving them as they are for this article because this is
  -- what I actually use, and hey, it works ¯\_(ツ)_/¯.
  vim.cmd([[imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']])
  vim.cmd([[smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']])

  vim.cmd([[imap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']])
  vim.cmd([[smap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']])
  vim.cmd([[imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']])
  vim.cmd([[smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']])

  vim.cmd([[inoremap <silent><expr> <C-Space> compe#complete()]])
  vim.cmd([[inoremap <silent><expr> <CR> compe#confirm('<CR>')]])
  vim.cmd([[inoremap <silent><expr> <C-e> compe#close('<C-e>')]])
  vim.cmd([[inoremap <silent><expr> <C-f> compe#scroll({ 'delta': +4 })]])
  vim.cmd([[inoremap <silent><expr> <C-d> compe#scroll({ 'delta': -4 })]])
end

-- Finally, let's initialize the Elixir language server

-- Replace the following with the path to your installation
local path_to_elixirls = vim.fn.expand("~/.elixir-ls/release/language_server.sh")

lspconfig.elixirls.setup({
  cmd = { path_to_elixirls },
  capabilities = capabilities,
  on_attach = on_attach,
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
  on_attach = on_attach,
  filetypes = { "elixir" },
})

-- Find files using Telescope command-line sugar.
map("n", "<c-p>", "<cmd>Telescope find_files<cr>", options)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", options)
map("n", "<leader>ag", "<cmd>Telescope grep_string<cr>", options)
-- map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", options)
-- map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", options)

-- Colourscheme config
vim.g.everforest_background = "hard"
vim.g.everforest_enable_italic = 1
vim.g.everforest_diagnostic_text_highlight = 1
vim.g.everforest_diagnostic_virtual_text = "colored"
vim.g.everforest_current_word = "bold"

-- Load the colorscheme
cmd([[colorscheme everforest]]) -- Put your favorite colorscheme here

-- Prettier function for formatter
local prettier = function()
  return {
    exe = "prettier",
    args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--double-quote" },
    stdin = true,
  }
end

require("formatter").setup({
  logging = false,
  filetype = {
    javascript = { prettier },
    json = { prettier },
    typescript = { prettier },
    html = { prettier },
    css = { prettier },
    scss = { prettier },
    markdown = { prettier },
    lua = {
      -- Stylua
      function()
        return {
          exe = "stylua",
          args = { "--indent-width", 2, "--indent-type", "Spaces" },
          stdin = false,
        }
      end,
    },
    elixir = {
      -- mix format
      function()
        return {
          exe = "mix format",
          stdin = false,
        }
      end,
    },
  },
})

-- Runs Formatter on save
vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.json,*.ts,*.css,*.scss,*.md,*.html,*.lua,*.ex,*.exs,*.html.leex : FormatWrite
augroup END
]],
  true
)

-- Telescope Global remapping
-- local action_state = require("telescope.actions.state")
-- local actions = require("telescope.actions")
-- require("telescope").setup({
--   defaults = {
--     -- winblend = 20,
--     -- sorting_strategy = "descending",
--     -- layout_strategy = "horizontal",
--     mappings = {
--       i = {
--         ["<esc>"] = actions.close,
--         ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
--       },
--     },
--   },
--   pickers = {
--     buffers = {
--       sort_lastused = true,
--       mappings = {
--         i = {
--           ["<C-w>"] = "delete_buffer",
--         },
--         n = {
--           ["<C-w>"] = "delete_buffer",
--         },
--       },
--     },
--     -- https://gitter.im/nvim-telescope/community?at=6113b874025d436054c468e6 Fabian David Schmidt
--     -- find_files = {
--     --   on_input_filter_cb = function(prompt)
--     --     local find_colon = string.find(prompt, ":")
--     --     if find_colon then
--     --       local ret = string.sub(prompt, 1, find_colon - 1)
--     --       vim.schedule(function()
--     --         local prompt_bufnr = vim.api.nvim_get_current_buf()
--     --         local picker = action_state.get_current_picker(prompt_bufnr)
--     --         local lnum = tonumber(prompt:sub(find_colon + 1))
--     --         if type(lnum) == "number" then
--     --           local win = picker.previewer.state.winid
--     --           local bufnr = picker.previewer.state.bufnr
--     --           local line_count = vim.api.nvim_buf_line_count(bufnr)
--     --           vim.api.nvim_win_set_cursor(win, { math.max(1, math.min(lnum, line_count)), 0 })
--     --         end
--     --       end)
--     --       return { prompt = ret }
--     --     end
--     --   end,
--     --   attach_mappings = function()
--     --     actions.select_default:enhance({
--     --       post = function()
--     --         -- if we found something, go to line
--     --         local prompt = action_state.get_current_line()
--     --         local find_colon = string.find(prompt, ":")
--     --         if find_colon then
--     --           local lnum = tonumber(prompt:sub(find_colon + 1))
--     --           vim.api.nvim_win_set_cursor(0, { lnum, 0 })
--     --         end
--     --       end,
--     --     })
--     --     return true
--     --   end,
--     -- },
--   },
-- })
--
map(
  "n",
  "<leader>fs",
  '<cmd>lua require("telescope.builtin").treesitter(require("telescope.themes").get_dropdown({}))<cr>',
  options
)

-- map(
--   "n",
--   "<leader>p",
--   '<cmd>lua require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({}))<cr>',
--   options
-- )
-- -- map("n", "<leader>r", '<cmd>lua require("telescope.builtin").registers()<cr>', options)
-- map(
--   "n",
--   "<leader>g",
--   '<cmd>lua require("telescope.builtin").live_grep(require("telescope.themes").get_dropdown({}))<cr>',
--   options
-- )
-- map(
--   "n",
--   "<leader>b",
--   '<cmd>lua require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({}))<cr>',
--   options
-- )
-- map("n", "<leader>j", '<cmd>lua require("telescope.builtin").help_tags()<cr>', options)
-- map(
--   "n",
--   "<leader>f",
--   '<cmd>lua require("telescope.builtin").file_browser(require("telescope.themes").get_dropdown({}))<cr>',
--   options
-- )
-- -- map("n", "<leader>s", '<cmd>lua require("telescope.builtin").spell_suggest()<cr>', options)
-- map(
--   "n",
--   "<leader>i",
--   '<cmd>lua require("telescope.builtin").git_status(require("telescope.themes").get_dropdown({}))<cr>',
--   options
-- )

-- LSP Saga config & keys https://github.com/glepnir/lspsaga.nvim
-- TODO - it doesn't work for elixir
local saga = require("lspsaga")
saga.init_lsp_saga({
  code_action_icon = "? ",
  definition_preview_icon = "?  ",
  dianostic_header_icon = " ?  ",
  error_sign = "? ",
  finder_definition_icon = "?  ",
  finder_reference_icon = "?  ",
  hint_sign = "?",
  infor_sign = "?",
  warn_sign = "?",
})

map("n", "<Leader>cf", ":Lspsaga lsp_finder<CR>", { silent = true })
map("n", "<leader>ca", ":Lspsaga code_action<CR>", { silent = true })
map("v", "<leader>ca", ":<C-U>Lspsaga range_code_action<CR>", { silent = true })
map("n", "<leader>ch", ":Lspsaga hover_doc<CR>", { silent = true })
map("n", "<leader>ck", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', { silent = true })
map("n", "<leader>cj", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', { silent = true })
map("n", "<leader>cs", ":Lspsaga signature_help<CR>", { silent = true })
map("n", "<leader>ci", ":Lspsaga show_line_diagnostics<CR>", { silent = true })
map("n", "<leader>cn", ":Lspsaga diagnostic_jump_next<CR>", { silent = true })
map("n", "<leader>cp", ":Lspsaga diagnostic_jump_prev<CR>", { silent = true })
map("n", "<leader>cr", ":Lspsaga rename<CR>", { silent = true })
map("n", "<leader>cd", ":Lspsaga preview_definition<CR>", { silent = true })

-- notational
vim.g.nv_search_paths = { "~/Documents/notes" }
vim.g.nv_use_short_pathnames = 1
vim.g.nv_default_extension = ".rst"

map("n", "<leader>nv", "<cmd>:NV<CR>", { silent = true })
map("n", "<leader>nz", '<cmd>:lua vim.g.nv_search_paths = { "~/Documents/notki" }<cr><cmd>:NV<CR>', { silent = true })

-- change dir
map("n", "<leader>cd", "<cmd>:cd %:p:h<cr><cmd>:pwd<cr>", options)
map("n", "<leader>gd", "<cmd>:cd /Users/klemenslukaszczyk/Documents/trainig<cr><cmd>:pwd<cr>", options)
