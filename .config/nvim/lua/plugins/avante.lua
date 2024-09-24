return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = true,
	version = false,
	build = "make BUILD_FROM_SOURCE=true",
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
