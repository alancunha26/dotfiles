local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

	-- Override plugin definition options
	{
		"NvChad/base46",
		lazy = false,
		branch = "v2.0",
		config = function()
			require("base46").load_all_highlights()
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},

	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				tailwind = true,
			},
		},
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
		},
		opts = function(_, opts)
			-- original LazyVim kind icon formatter
			local format_kinds = opts.formatting.format
			opts.formatting.format = function(entry, item)
				format_kinds(entry, item) -- add icons
				return require("tailwindcss-colorizer-cmp").formatter(entry, item)
			end
		end,
	},

	-- override plugin configs
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},

	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},

	-- To make a plugin not be loaded
	-- {
	--   "NvChad/nvim-colorizer.lua",
	--   enabled = false
	-- },

	-- All NvChad plugins are lazy-loaded by default
	-- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
	-- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
	-- {
	--   "mg979/vim-visual-multi",
	--   lazy = false,
	-- }

	-- {
	-- 	"epwalsh/obsidian.nvim",
	-- 	version = "*",
	-- 	lazy = true,
	-- 	ft = "markdown",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	opts = overrides.obsidian,
	-- },

	-- {
	-- 	"gaoDean/autolist.nvim",
	-- 	ft = "markdown",
	-- 	config = function()
	-- 		require("autolist").setup()
	--
	-- 		vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
	-- 		vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
	-- 		vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
	-- 		vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
	-- 		vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
	-- 		vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>")
	-- 		vim.keymap.set("n", "<C-r>", "<cmd>AutolistRecalculate<cr>")
	-- 		vim.keymap.set("v", "<C-r>", "<cmd>AutolistRecalculate<cr>")
	-- 	end,
	-- },
}

return plugins
