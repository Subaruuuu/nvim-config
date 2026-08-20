-- Settings that only make sense in a real terminal Neovim UI.
-- Under vscode-neovim these are either no-ops or fight with VSCode's own rendering.

local option = vim.opt

-- Appearance --
option.showmode = false
option.number = true
option.relativenumber = true
option.cursorline = true
option.termguicolors = true
option.signcolumn = "yes"
option.title = true
option.wrap = true

-- Windows & command line --
option.splitright = true
option.wildmenu = true
option.completeopt = { "menuone", "noselect" }

-- Misc --
option.mouse = "a"
option.exrc = true

-- Key mappings --
local map = vim.keymap.set

map("n", "<leader>bc", "<cmd>bd<CR>")
map("n", "<S-h>", "<cmd>bprevious<cr>")
map("n", "<S-l>", "<cmd>bnext<cr>")
