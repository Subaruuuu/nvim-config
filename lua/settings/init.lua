-- Settings shared by every host (terminal Neovim and VSCode + vscode-neovim).
-- Host-specific options and keymaps live in `settings/nvim.lua` / `settings/vscode.lua`,
-- which this file dispatches to at the bottom.

local option = vim.opt
local global = vim.g

-- Indentation --
option.tabstop = 4
option.shiftwidth = 4
option.expandtab = true
option.shiftround = true
option.autoindent = true
option.smartindent = true

-- Search --
option.hlsearch = false
option.ignorecase = true
option.smartcase = true

-- Files & history --
option.fileencoding = "utf-8"
option.swapfile = false
option.backup = false
option.undofile = true
option.undodir = vim.fn.expand('$HOME/.local/share/nvim/undo')
option.autoread = true
option.updatetime = 50

-- Editing --
option.backspace = { "indent", "eol", "start" }

-- Global Settings --
global.mapleader = " "

-- Key mappings --
local map = vim.keymap.set

-- force to cancel arrows key
map({ "n", "i", "v" }, "<Left>", "<Nop>")
map({ "n", "i", "v" }, "<Right>", "<Nop>")
map({ "n", "i", "v" }, "<Up>", "<Nop>")
map({ "n", "i", "v" }, "<Down>", "<Nop>")

-- copy to the clipboard
map({ "v", "n" }, "<leader>y", "\"+y")

-- move up or down selected lines
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- indentation adjustment
map("v", "<Tab>", ">gv", { noremap = true, silent = true })
map("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

-- Host-specific settings --
require(vim.g.vscode and "settings.vscode" or "settings.nvim")
