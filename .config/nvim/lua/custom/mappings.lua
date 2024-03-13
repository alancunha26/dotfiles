---@type MappingsTable
local M = {}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		["<leader>to"] = {
			function()
				require("base46").toggle_transparency()
			end,
			"Toggle transparency",
		},
	},
	v = {
		[">"] = { ">gv", "indent" },
	},
}

M.obsidian = {
	n = {
		["<leader>fl"] = {
			"<cmd>ObsidianLinks<CR>",
			"Open current file links in telescope",
		},
		["tc"] = {
			function() end, -- See custom/configs/overrides
			"Toggle checkbox under cursor",
		},
	},
}

return M
