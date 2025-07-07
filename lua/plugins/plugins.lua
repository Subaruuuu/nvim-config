-- if true then return {} end

return {
    {
		'rhysd/accelerated-jk',
		config = function ()
			vim.keymap.set('n', 'j', '<Plug>(accelerated_jk_gj)')
			vim.keymap.set('n', 'k', '<Plug>(accelerated_jk_gk)')
		end
	},
	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",
		opts = {
			enable_check_bracket_line = false,
		},
	},
	{
		"folke/flash.nvim",
		config = function()
			require("flash").setup()
			vim.keymap.set({"n","x","o"},"s",
				function()
					require("flash").jump({
						search = {
							mode = function(str)
								return "\\<" .. str
							end,
						},
					})
				end
			)
			vim.keymap.set({"n","x","o"},"S",
				function()
					require("flash").treesitter()
				end
			)
			vim.keymap.set({"o"},"r",
				function()
					require("flash").remote()
				end
			)
			vim.keymap.set({"o","x"},"R",
				function()
					require("flash").treesitter_search()
				end
			)
		end,
	},
}
