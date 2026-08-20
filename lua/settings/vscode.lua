-- Settings that only apply when running inside VSCode via vscode-neovim.
-- Anything VSCode already owns (rendering, file tree, search, LSP UI) is delegated
-- back to VSCode through `vscode.action`, so the terminal muscle memory still works.

local vscode = require("vscode")
local map = vim.keymap.set

-- has conflict with "accelerated-jk"
-- map({ "n", "x" }, "j", "v:count == 0 and 'gj' or 'j'", { desc = "Down", expr = true, silent = true })
-- map({ "n", "x" }, "k", "v:count == 0 and 'gk' or 'k'", { desc = "Up", expr = true, silent = true })

-- Buffer / editor navigation --
map("n", "<S-h>", function() vscode.action("workbench.action.previousEditor") end)
map("n", "<S-l>", function() vscode.action("workbench.action.nextEditor") end)
map("n", "<leader>bc", function() vscode.action("workbench.action.closeActiveEditor") end)

-- Mirror the terminal keymaps onto their VSCode equivalents --
map("n", "<leader>e", function() vscode.action("workbench.view.explorer") end)
map("n", "<leader>ff", function() vscode.action("workbench.action.quickOpen") end)
map("n", "<leader>fg", function() vscode.action("workbench.action.findInFiles") end)
map("n", "<leader>rn", function() vscode.action("editor.action.rename") end)
map("n", "<leader>ca", function() vscode.action("editor.action.quickFix") end)
