-- Loaded in both terminal Neovim and VSCode.
-- `S` / `R` use flash's treesitter modes, which need a parser for the current
-- filetype -- see `plugins/common/treesitter.lua`, which is why treesitter is
-- installed under VSCode too (parsers only, highlighting stays off).
return {
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
