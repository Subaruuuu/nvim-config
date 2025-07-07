local option = vim.opt
local buffer = vim.b
local global = vim.g

-- Globol Settings --
option.showmode = false
option.backspace = { "indent", "eol", "start" }
option.tabstop = 4
option.shiftwidth = 4
option.expandtab = true
option.shiftround = true
option.autoindent = true
option.smartindent = true
option.number = true
option.relativenumber = true
option.wildmenu = true
option.hlsearch = false
option.ignorecase = true
option.smartcase = true
option.completeopt = { "menuone", "noselect" }
option.cursorline = true
option.termguicolors = true
option.signcolumn = "yes"
option.autoread = true
option.title = true
option.swapfile = false
option.backup = false
option.updatetime = 50
option.mouse = "a"
option.undofile = true
option.undodir = vim.fn.expand('$HOME/.local/share/nvim/undo')
option.exrc = true
option.wrap = true
option.splitright = true

-- Buffer Settings --
buffer.fileenconding = "utf-8"

-- Global Settings --
global.mapleader = " "

-- Key mappings --
local map = vim.keymap.set

-- force to cancel arrows key
map({ "n", "i", "v" }, "<Left>", "<Nop>")
map({ "n", "i", "v" }, "<Right>", "<Nop>")
map({ "n", "i", "v" }, "<Up>", "<Nop>")
map({ "n", "i", "v" }, "<Down>", "<Nop>")

-- has conflict with "accelerated-jk"
-- map({ "n", "x" }, "j", "v:count == 0 and 'gj' or 'j'", { desc = "Down", expr = true, silent = true })
-- map({ "n", "x" }, "k", "v:count == 0 and 'gk' or 'k'", { desc = "Up", expr = true, silent = true })

-- move up or down selected lines
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- copy to the clipboard
map({ "v", "n" }, "<leader>y", "\"+y")

-- for VScode Neovim setup
if vim.g.vscode then
	local vscode = require('vscode')

	-- indentation adjustment
	map("v", "<Tab>", ">gv", { noremap = true, silent = true })
	map("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

	map("n", "<S-h>", function()
		vscode.action("workbench.action.previousEditor")
	end)

	map("n", "<S-l>", function()
		vscode.action("workbench.action.nextEditor")
	end)
end
