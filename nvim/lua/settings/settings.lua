vim.loader.enable()

local vcmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')

local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set options

g.mapleader = ","

opt.undofile = true
opt.undodir = vim.fn.expand("~/.tmp")

opt.hidden = true -- Enable background buffers
opt.backspace = { "indent", "eol", "start" }
opt.hlsearch = true -- Highlight found searches
opt.joinspaces = false -- No double spaces with join
opt.list = false -- Show some invisible characters
opt.linebreak = true -- Stop words being broken on wrap
opt.numberwidth = 5 -- Make the gutter wider by default
opt.relativenumber = true -- Relative line numbers
opt.number = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.clipboard = "unnamedplus"
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.smartindent = true
opt.swapfile = false --  Disables creating swap files.
opt.background = "dark"
opt.cursorline = true
opt.scrolloff = 8
opt.termguicolors = true
opt.sessionoptions="globals,buffers"

-- mappings
options = { noremap = true }
map = vim.api.nvim_set_keymap

map("i", "jk", "<esc>", options)
map("i", "kj", "<esc>", options)

map("n", "<leader>t", "<cmd>:tabe<cr>", options)

map("n", "<space>", "i<space><esc>", options)

-- Open nvimrc file
map("n", "vv", "<cmd>edit $MYVIMRC<CR>", options)

-- Source nvimrc file
map("n", "<Leader>so", ":luafile %<CR>", options)

-- Easier file save
map("n", "<Leader>w", "<cmd>:w<CR>", options)

-- Close
map("n", "qq", "<cmd>bd<CR>", options)
map("n", "QQ", "<cmd>q<CR>", options)

-- get date
map("i", "<F6>", "<C-R>=strftime('%d/%m/%Y')<cr><cr>##########", options)

-- clear highlight
map("n", "<leader><cr>", "<cmd>:nohlsearch<cr>", options)

-- [w ]w - Forward and backwards tabs
map("n", "[w", "<cmd>:tabmove -1<cr>", options)
map("n", "]w", "<cmd>:tabmove +1<cr>", options)

map("n", "<Leader>ts", "<cmd>:Telescope session-lens search_session<cr>", options)

map("n", "<leader>cd", "<cmd>:cd %:p:h<cr><cmd>:pwd<cr>", options)

-- maximazer
map("n", "<leader>ma", "<cmd>:MaximizerToggle<CR>", options)

vim.cmd([[
nnoremap <leader>gd :call GetGitRoot()<cr>
function! GetGitRoot()
  let l:gitErr = system("git rev-parse --show-toplevel | grep fatal")
  let l:deletedEOF=substitute(l:gitErr, '\n$', '', '')

  if empty(l:deletedEOF)
    let l:gitRoot=system("git rev-parse --show-toplevel")
    execute ":cd " . l:gitRoot
  else
    let g:pathPwd=system("pwd")
    g:pathPwd=substitute(g:pathPwd, '\n$', '', '')
    execute ":cd " . g:pathPwd
  endif

endfunction
]])

vim.cmd([[
let g:languagetool_server_jar="/usr/local/opt/languagetool/libexec/languagetool-server.jar"
vnoremap <F2> d:execute 'normal i' . join(sort(split(getreg('"'))), ' ')<CR>
map <leader>pp :call CopyPath()<CR>
nnoremap <leader>cf :call CopyFileName()<CR>
function! CopyFileName()
  let @+=expand('%:t')
endfunction

function! CopyPath()
  let @+=expand('%:p')
endfunction
]])
