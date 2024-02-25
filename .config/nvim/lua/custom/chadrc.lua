---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {}
M.ui.theme = "ayu_dark"
M.ui.theme_toggle = { "ayu_dark", "ayu_dark" }
M.ui.transparency = false
M.ui.hl_override = highlights.override
M.ui.hl_add = highlights.add
M.ui.nvdash = { load_on_startup = true }
M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
