-- Lightweight editing plugins that behave sensibly in both hosts.
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
		-- VSCode does its own auto-closing brackets; running both stacks them
		-- and typing `(` produces `(())`.
		cond = not vim.g.vscode,
		event = "VeryLazy",
		opts = {
			enable_check_bracket_line = false,
		},
	},
	{
		"ethanholz/nvim-lastplace",
		config = true,
	},
	{
		'echasnovski/mini.ai',
		event = "VeryLazy",
		config = true,
	},
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		config = true,
	},
}
