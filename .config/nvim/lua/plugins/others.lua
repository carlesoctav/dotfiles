return {
	{ "numToStr/Comment.nvim", opts = {} },
	"tpope/vim-sleuth",
	"folke/todo-comments.nvim",
	{ "nvim-tree/nvim-web-devicons" },
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup({ n_lines = 500 })
			require("mini.pairs").setup()
			require("mini.surround").setup()
			require("mini.tabline").setup()
			require("mini.statusline").setup()
			require("mini.jump").setup()
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = { char = "┊" },
			whitespace = { highlight = { "Whitespace", "NonText" } },
			scope = { exclude = { language = { "lua" } } },
		},
	},
	{ "LunarVim/bigfile.nvim" },
	{ "nvim-tree/nvim-web-devicons" },
}
