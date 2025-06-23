return {
	{
		"echasnovski/mini.diff",
		config = function()
			local diff = require("mini.diff")
			diff.setup({
				-- Disabled by default
				source = diff.gen_source.none(),
			})
		end,
	},

	{
		"olimorris/codecompanion.nvim",

		dependencies = {
			"github/copilot.vim",
		},
		init = function()
			vim.g.copilot_enabled = false
		end,
		config = function()
			require("codecompanion").setup({
				strategies = {
					chat = {
						adapter = {
							name = "copilot",
							model = "claude-sonnet-4",
						},

						variables = {
							["buffer"] = {
								opts = {
									default_params = 'pin', -- or 'watch'
								},
							},
						},
					},
				}
			})
			vim.keymap.set("n", "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>")
		end,
	}
}
