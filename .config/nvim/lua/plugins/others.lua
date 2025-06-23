return {
	{ "numToStr/Comment.nvim",      opts = {} },
	"tpope/vim-sleuth",
	"folke/todo-comments.nvim",
	{ "nvim-tree/nvim-web-devicons" },
	{
		'nvim-focus/focus.nvim',
		version = '*',
		config = function()
			require("plugins_conf.focus")
		end
	},
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup({ n_lines = 500 })
			require("mini.pairs").setup()
			require("mini.surround").setup()
			require("mini.tabline").setup()
			require("mini.statusline").setup()
			require("mini.jump").setup()
			require("mini.bufremove").setup()
			vim.keymap.set("n", "<C-q>", function()
				require("mini.bufremove").delete(0, false)
			end)
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
