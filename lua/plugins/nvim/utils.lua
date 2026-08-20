-- Terminal-only utilities. Anything that also works under VSCode
-- (flash, accelerated-jk, autopairs, lastplace, mini.*) lives in `plugins/common/`.
return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			-- direction = "horizontal",
			direction = "float",
			open_mapping = [[<C-\>]],
		},
	},
	{
		"folke/persistence.nvim",
		config = function()
			require("persistence").setup()
			vim.keymap.set("n","<leader>qs", [[<cmd>lua require("persistence").load()<cr>]])
			vim.keymap.set("n","<leader>ql", [[<cmd>lua require("persistence").load({ last = true})<cr>]])
			vim.keymap.set("n","<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]])
		end
	},
	{
		"kamykn/spelunker.vim",
		event = "VeryLazy",
		config = function()
			vim.g.spelunker_check_type = 2
		end
	},
	{
		"ellisonleao/glow.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({})
			vim.keymap.set({"n", "v"},"<leader>e",[[<cmd>Neotree toggle<CR>]])
			vim.keymap.set("n", "<leader>n",
				function()
					vim.cmd("wincmd h")        -- move cursor to the Neotree window
				end, { desc = "Focus Neotree" })
			vim.keymap.set("n", "<leader>l", "<C-w>p", { desc = "Go to previous window" })
		end
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = true,
	},
	-- 以下有需要開啟多 window split 再用
	{
		"s1n7ax/nvim-window-picker",
		config = function()
			require("window-picker").setup({
				filter_rules = {
					include_current_win = true,
					bo = {
						filetype = { "fidget", "neo-tree" },
						buftype = { 'terminal' },
					}
				}
			})
			vim.keymap.set("n",
				"<c-w>p",
				function()
					local window_number = require('window-picker').pick_window()
					if window_number then vim.api.nvim_set_current_win(window_number) end
				end
			)
		end
	},
}
