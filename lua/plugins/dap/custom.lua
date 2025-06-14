local M = {}

M.auto_attach_node_process = function()
	local Job = require("plenary.job")

	-- This job lists all processes and greps for node with --inspect
	Job:new({
		command = "ps",
		args = { "aux" },
		on_exit = function(j)
			local result = j:result()
			for _, line in ipairs(result) do
				if line:match("node") and line:match("%-%-inspect") then
					-- Extract PID
					local pid = line:match("%S+%s+(%d+)")
					if pid then
						vim.schedule(function()
							require("dap").run({
								type = "node2",
								name = "Auto Attach (found process)",
								request = "attach",
								processId = tonumber(pid),
								cwd = vim.loop.cwd(),
								sourceMaps = true,
								skipFiles = { "<node_internals>/**" },
							})
						end)
						return
					end
				end
			end

			-- If no process found
			vim.notify("No debuggable Node.js process found with --inspect", vim.log.levels.WARN)
		end,
	}):start()
end

return M
