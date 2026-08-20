return {
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = {
			"mfussenegger/nvim-dap",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"nvim-telescope/telescope-dap.nvim",
			{
				-- mason-lspconfig only ensures LSP servers; DAP adapters need this.
				-- `handlers` is deliberately omitted so this plugin installs the
				-- adapter but does NOT define any dap.adapters/configurations --
				-- those are spelled out explicitly below.
				"jay-babu/mason-nvim-dap.nvim",
				dependencies = { "mason-org/mason.nvim" },
				opts = { ensure_installed = { "js" } }, -- "js" -> js-debug-adapter
			},
		},
		config = function()
			vim.keymap.set('n', '<F5>', function() require 'telescope'.extensions.dap.configurations {} end)
			vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
			vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
			vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
			vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end)
			vim.keymap.set('n', '<Leader>dB', function() require('dap').set_breakpoint() end)
			vim.keymap.set('n', '<Leader>dL',
				function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
			vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
			vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
			vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
				require('dap.ui.widgets').hover()
			end)
			vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
				require('dap.ui.widgets').preview()
			end)
			vim.keymap.set('n', '<Leader>df', function()
				local widgets = require('dap.ui.widgets')
				widgets.centered_float(widgets.frames)
			end)
			vim.keymap.set('n', '<Leader>ds', function()
				local widgets = require('dap.ui.widgets')
				widgets.centered_float(widgets.scopes)
			end)

			local dap, dapui = require("dap"), require("dapui")
			require("nvim-dap-virtual-text").setup()
			require("dapui").setup()

			-- dap.set_log_level("TRACE")

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- ╭──────────────────────────────────────────────────────────╮
			-- │ Icons                                                    │
			-- ╰──────────────────────────────────────────────────────────╯
			vim.fn.sign_define("DapBreakpoint", { text = "🔵", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "🔴", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapConditionalBreakpoint", { text = "🟡", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "🟢", texthl = "", linehl = "", numhl = "" })

			-- vscode-js-debug, installed by mason as "js-debug-adapter".
			-- Replaces node-debug2-adapter: Microsoft archived it and mason removed
			-- it from the registry in v1.43.0, so it cannot be installed at all on a
			-- new machine. The adapter is a server, not an executable -- nvim-dap
			-- fills in ${port} and js-debug listens on it.
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
					args = { "${port}" },
				},
			}

			for _, language in ipairs {
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
			} do
				dap.configurations[language] = {
					{
						type = "pwa-node",
						name = "Launch file",
						request = "launch",
						program = "${file}",
						cwd = "${workspaceFolder}",
						sourceMaps = true,
						skipFiles = { "<node_internals>/**" },
					},
					{
						type = "pwa-node",
						name = "Attach to process",
						request = "attach",
						processId = require('dap.utils').pick_process,
						cwd = "${workspaceFolder}",
						sourceMaps = true,
						skipFiles = { "<node_internals>/**" },
					},
				}
			end

			local custom = require("plugins.nvim.dap.custom")

			vim.api.nvim_create_user_command("DapAutoAttach", custom.auto_attach_node_process, {})

			-- below attach way is deprecated, don't use it
			local Terminal  = require('toggleterm.terminal').Terminal

			vim.api.nvim_create_user_command("DebugNode", function(opts)
				local raw = opts.args ~= "" and opts.args or "./index.js"

				local node_cmd = "node --inspect " .. raw

				-- Open a new toggleterm and run the command
				local term = Terminal:new({
					cmd = node_cmd,
					direction = "tab",
					close_on_exit = false,
					start_in_insert = true,
				})

				term:toggle()

				vim.defer_fn(function()
					-- require("dap").continue()
					require('telescope').extensions.dap.configurations({})
				end, 1500)

				end, {
				nargs = "*", -- now supports multiple words like "--watch file.js"
				complete = "file",
			})
		end
	},
}
