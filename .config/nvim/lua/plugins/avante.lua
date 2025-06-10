return {
	{
		"ravitemer/mcphub.nvim",
		build = "npm install -g mcp-hub@latest",
		config = function()
			require("mcphub").setup()
		end
	},

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
				extensions = {
					mcphub = {
						callback = "mcphub.extensions.codecompanion",
						opts = {
							show_result_in_chat = true, -- Show mcp tool results in chat
							make_vars = true, -- Convert resources to #variables
							make_slash_commands = true, -- Add prompts as /slash commands
						}
					}
				},
				strategies = {
					chat = {
						adapter = {
							name = "copilot",
							model = "claude-sonnet-4-20250514",
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
