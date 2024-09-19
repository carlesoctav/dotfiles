return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	version = false,
	build = "make",
	dependencies = {
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"github/copilot.vim",
	},
	init = function()
		vim.g.copilot_enabled = false
	end,

	config = function()
		require("plugins_conf.avante")
	end,
}
