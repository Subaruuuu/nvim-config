return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make',
		},
	},
	config = function ()
		require('telescope').setup({
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = 'smart_case',
				}
			}
		})
		require('telescope').load_extension('fzf')
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'find files' })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'live grep' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'buffers' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'help tags' })
		vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
		vim.keymap.set('n', '<leader>/', function ()
			-- you can pass additional configuration to telescope to change theme, layout, etc.
			require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
				winblend = 10,
				previewer = false,
			})
		end, { desc = '[/] Fuzzily search in current buffer' })
	end
}
