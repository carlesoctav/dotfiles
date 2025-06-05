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
			"zbirenbaum/copilot.lua",
		},
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
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
				}
			})
		end,
	}
}
