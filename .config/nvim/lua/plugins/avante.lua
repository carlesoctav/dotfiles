return {
{
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = true,
	version = false,
	build = "make",
	dependencies = {
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"github/copilot.vim",
	},
	opts = {
		provider = "copilot",
		copilot = {
			model = "claude-3.7-sonnet",
		},
	},
	init = function()
		vim.g.copilot_enabled = false
	end,

	config = function(_, opts)
		-- require("plugins_conf.avante")
		local available_models = {
			["claude-3.7-sonnet"] = { model = "claude-3.7-sonnet" },
			["claude-3.7-sonnet🙅‍♂️🛠️"] = { model = "claude-3.7-sonnet", disable_tools = true },
			["claude-3.5-sonnet"] = { model = "claude-3.5-sonnet" },
			["o3-mini-high"] = { model = "o3-mini", reasoning_effort = "high" },
			["o4-mini-high"] = { model = "o4-mini", reasoning_effort = "high" },
			["o4-mini-high🙅‍♂️🛠️"] = { model = "o4-mini", reasoning_effort = "high", disable_tools = true },
			["o3-mini"] = { model = "o3-mini" },
			["o4-mini"] = { model = "o4-mini" },
			["4o"] = { model = "gpt-4o" },
			["4.1"] = { model = "gpt-4.1" },
			["4.1🙅‍♂️🛠️"] = { model = "gpt-4.1", disable_tools = true },
			["4.1-mini"] = { model = "gpt-4.1-mini" },
			["gemini-2.5-pro"] = { model = "gemini-2.5-pro" },
			["gemini-2.5-pro🙅‍♂️🛠️"] = { model = "gemini-2.5-pro", disable_tools = true },
			["gemini-2.0-flash"] = { model = "gemini-2.0-flash" },
			["o2"] = { model = "o2" },
			["o3"] = { model = "o3" },
			["o1"] = { model = "o1", reasoning_effort = "high" },
		}

		local function switch_model()
			local model_keys = vim.tbl_keys(available_models)
			vim.ui.select(model_keys, { prompt = "Select Avante Model:" }, function(selected)
				if selected then
					opts.copilot = available_models[selected]
					require("avante").setup(opts)
					print("Switched Copilot model to: " .. selected)
				else
					print("Model selection canceled.")
				end
			end)
		end

		vim.keymap.set("n", "<leader>am", switch_model, { desc = "Avante: Switch Copilot Model" })

		require("avante").setup(opts)
	end,
	},
}

