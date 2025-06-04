return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
			"folke/neoconf.nvim",
			"folke/neodev.nvim",
			"j-hui/fidget.nvim",
		},
		config = function()
			require("neoconf").setup()
			require("neodev").setup()
			require("fidget").setup()
			require("mason").setup()

			-- mason-lspcofig 2025/05/06 breaking change deprecated "handlers" and "setup_handlers"
			-- use native "vim.lsp.config()" API or "automatic_enable" instead
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- "ts_ls",
					"lua_ls",
					"gopls",
					"pyright",
					"jsonls",
					"eslint",
					"html",
					"cssls",
					"marksman",
					"dockerls",
					"docker_compose_language_service",
					"bashls",
				},
				automatic_enable = true,
				automatic_installation = true,
			})

			-- Global LSP keymaps via LspAttach
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local function opts(desc)
						return { buffer = bufnr, desc = "LSP: " .. desc }
					end

					local map = vim.keymap.set
					-- map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
					-- map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
					map("n", "gr", vim.lsp.buf.references, opts "Go to references")
					map("n", "gd", require "telescope.builtin".lsp_definitions, opts "Go to definition")
					map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
					map("n", "gi", require "telescope.builtin".lsp_implementations, opts "Go to implementation")
					map("n", "gr", require "telescope.builtin".lsp_references, opts "Go to references")
					map("n", "K", vim.lsp.buf.hover, opts "Hover info")
					map("n", "<leader>da", require "telescope.builtin".diagnostics, opts "Diagnostics")
					map("n", "<leader>rn", vim.lsp.buf.rename, opts "Rename")
					map("n", "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
					map("n", "<leader>f", function()
						vim.lsp.buf.format { async = true }
					end, opts "Format")
				end,
			})

			-- Diagnostic visuals
			vim.diagnostic.config({
				virtual_text = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "✘",
						[vim.diagnostic.severity.WARN] = "▲",
						[vim.diagnostic.severity.HINT] = "⚑",
						[vim.diagnostic.severity.INFO] = "",
					},
				},
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()

			-- local capabilities = vim.tbl_deep_extend("force",
			-- 	vim.lsp.protocol.make_client_capabilities(),
			-- 	require('cmp_nvim_lsp').default_capabilities()
			-- )

			vim.lsp.config("ts_ls", {
				init_options = {
					preferences = {
						disableSuggestions = true,
					},
				},
				on_init = function(client)
					if client.supports_method "textDocument/semanticTokens" then
						client.server_capabilities.semanticTokensProvider = nil
					end
				end,
				capabilities = capabilities,
			})

			vim.lsp.enable("ts_ls")
		end
	}
}
