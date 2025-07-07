return {
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
