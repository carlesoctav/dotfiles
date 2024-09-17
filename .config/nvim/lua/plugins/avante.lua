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
		"zbirenbaum/copilot.lua", 
	},
	config = function()
		require("plugins_conf.avante")
	end
}
