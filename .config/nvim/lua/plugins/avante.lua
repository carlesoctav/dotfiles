return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	build = "make",
	opts = {
		provider = "openai",
		openai = {
			endpoint = "https://api.deepseek.com/v1",
			model = "deepseek-coder",
			temperature = 0,
			max_tokens = 4096,
		},
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
}
