-- Loaded in both hosts, but for different reasons:
--   terminal nvim -> parsers + highlighting + indent + textobjects
--   VSCode        -> parsers only, so flash's `S` / `R` treesitter modes work.
--                    VSCode owns highlighting and indentation there.
--
-- NOTE: `branch = "main"` is load-bearing, not decoration.
-- nvim-treesitter has two live branches and they are NOT interchangeable:
--   master -> the old `nvim-treesitter.configs` opts-table API. Frozen upstream,
--             and its README states Neovim 0.12 is not supported. Concretely, its
--             query.lua calls `iter_matches(..., { all = false })`, and 0.12
--             removed that option -- every textobject then dies with
--             "attempt to call method 'start' (a nil value)".
--   main   -> the current rewrite. Requires Neovim 0.12+, which we have.
-- Leaving the branch unpinned is the worst option: lazy follows the default
-- branch, which upstream has switched, so the spec silently breaks.
local is_vscode = vim.g.vscode ~= nil

-- No `jsonc` parser exists; jsonc buffers are parsed with the json one (registered below).
local ensure_installed = {
	"bash",
	"c",
	"diff",
	"html",
	"javascript",
	"jsdoc",
	"json",
	"lua",
	"luadoc",
	"luap",
	"markdown",
	"markdown_inline",
	"printf",
	"python",
	"query",
	"regex",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"xml",
	"yaml",
	"go",
}

return {
	{
		'nvim-treesitter/nvim-treesitter',
		branch = 'main',
		build = ':TSUpdate',
		-- BufReadPre fires before filetype detection, so the FileType autocmd
		-- below is registered in time for the very first buffer.
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local ts = require("nvim-treesitter")
			ts.setup()

			vim.treesitter.language.register("json", "jsonc")

			-- Installing an already-present parser is a no-op, but filtering first
			-- keeps startup off the install path entirely.
			local installed = require("nvim-treesitter.config").get_installed("parsers")
			local missing = vim.tbl_filter(function(lang)
				return not vim.tbl_contains(installed, lang)
			end, ensure_installed)
			if #missing > 0 then
				ts.install(missing)
			end

			-- On the `main` branch, highlighting and indent are plain Neovim
			-- features opted into per buffer -- there is no `highlight = {...}` opt.
			-- VSCode does its own, so we stop here and keep only the parsers.
			if is_vscode then
				return
			end

			local function start(buf)
				-- No parser for this filetype -> leave the buffer alone.
				if not pcall(vim.treesitter.start, buf) then
					return
				end
				vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
				callback = function(args)
					start(args.buf)
				end,
			})

			-- Catch buffers that were already open when this plugin loaded.
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_is_loaded(buf) then
					start(buf)
				end
			end
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		branch = 'main',
		cond = not is_vscode,
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,
					selection_modes = {
						['@parameter.outer'] = 'v', -- charwise
						['@function.outer'] = 'V', -- linewise
						['@class.outer'] = '<c-v>', -- blockwise
					},
					include_surrounding_whitespace = false,
				},
			})

			-- On `main` the keymaps are no longer declared in an opts table.
			local function textobj(query, group)
				return function()
					require("nvim-treesitter-textobjects.select")
						.select_textobject(query, group or "textobjects")
				end
			end

			-- NOTE: function objects are on `am`/`im`, not `af`/`if`. mini.ai
			-- (plugins/common/editing.lua) already owns `af`/`if` for *function
			-- calls*; mapping both means whichever configures last silently wins.
			local map = vim.keymap.set
			map({ "x", "o" }, "am", textobj("@function.outer"), { desc = "a function" })
			map({ "x", "o" }, "im", textobj("@function.inner"), { desc = "inner function" })
			map({ "x", "o" }, "ac", textobj("@class.outer"), { desc = "a class" })
			map({ "x", "o" }, "ic", textobj("@class.inner"), { desc = "inner part of a class region" })
			-- captures from other query groups work too, e.g. `locals.scm`
			map({ "x", "o" }, "as", textobj("@local.scope", "locals"), { desc = "language scope" })
		end,
	},
}
