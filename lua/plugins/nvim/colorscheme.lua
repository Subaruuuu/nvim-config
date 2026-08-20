return {
	-- 文字主題
	{
		"folke/tokyonight.nvim",
		lazy = false,
		main = "tokyonight",
		priority = 1000,
		opts = {
			style = "moon",
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
		init = function()
			vim.cmd("colorscheme tokyonight") -- you still must apply the colorscheme manually
		end
	},
	-- {
	--   "catppuccin/nvim",
	--   name = "catppuccin",
	--   priority = 1000,
	--   init = function()
	--     vim.cmd("colorscheme catppuccin-mocha")
	--   end
	-- },
}
