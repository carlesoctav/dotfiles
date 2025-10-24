local function create_opencode_acp_adapter()
	local helpers = require("codecompanion.adapters.acp.helpers")
	local executable = vim.fn.exepath("opencode")
	if executable == "" then
		executable = "opencode"
	end

	return {
		name = "opencode",
		formatted_name = "OpenCode",
		type = "acp",
		roles = {
			llm = "assistant",
			user = "user",
		},
		opts = {
			vision = true,
		},
		commands = {
			default = {
				executable,
				"acp",
			},
		},
		defaults = {
			mcpServers = {},
			timeout = 20000,
		},
		parameters = {
			protocolVersion = 1,
			clientCapabilities = {
				fs = { readTextFile = true, writeTextFile = true },
			},
			clientInfo = {
				name = "CodeCompanion.nvim",
				version = "1.0.0",
			},
		},
		handlers = {
			setup = function(_)
				return true
			end,
			form_messages = function(self, messages, capabilities)
				return helpers.form_messages(self, messages, capabilities)
			end,
			on_exit = function(_, _code) end,
		},
	}
end

return {
	{
		"olimorris/codecompanion.nvim",

		event = "VeryLazy",
		dependencies = {
			"github/copilot.vim",
			"ravitemer/codecompanion-history.nvim",
		},
		init = function()
			vim.g.copilot_enabled = false
		end,
		config = function()
			require("codecompanion").setup({
				extensions = {
					history = {
						enabled = true,
						opts = {
							-- Keymap to open history from chat buffer (default: gh)
							keymap = "gh",
							-- Keymap to save the current chat manually (when auto_save is disabled)
							save_chat_keymap = "sc",
							-- Save all chats by default (disable to save only manually using 'sc')
							auto_save = true,
							-- Number of days after which chats are automatically deleted (0 to disable)
							expiration_days = 0,
							-- Picker interface (auto resolved to a valid picker)
							picker = "telescope", --- ("telescope", "snacks", "fzf-lua", or "default")
							---Optional filter function to control which chats are shown when browsing
							chat_filter = nil, -- function(chat_data) return boolean end
							-- Customize picker keymaps (optional)
							picker_keymaps = {
								rename = { n = "r", i = "<M-r>" },
								delete = { n = "d", i = "<M-d>" },
								duplicate = { n = "<C-y>", i = "<C-y>" },
							},
							---Automatically generate titles for new chats
							auto_generate_title = true,
							title_generation_opts = {
								---Adapter for generating titles (defaults to current chat adapter)
								adapter = nil, -- "copilot"
								---Model for generating titles (defaults to current chat model)
								model = nil, -- "gpt-4o"
								---Number of user prompts after which to refresh the title (0 to disable)
								refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
								---Maximum number of times to refresh the title (default: 3)
								max_refreshes = 3,
								format_title = function(original_title)
									-- this can be a custom function that applies some custom
									-- formatting to the title.
									return original_title
								end,
							},
							---On exiting and entering neovim, loads the last chat on opening chat
							continue_last_chat = false,
							---When chat is cleared with `gx` delete the chat from history
							delete_on_clearing_chat = false,
							---Directory path to save the chats
							dir_to_save = "~/personal/proof-im-good-to-ai",
							---Enable detailed logging for history extension
							enable_logging = false,

							-- Summary system
							summary = {
								-- Keymap to generate summary for current chat (default: "gcs")
								create_summary_keymap = "gcs",
								-- Keymap to browse summaries (default: "gbs")
								browse_summaries_keymap = "gbs",

								generation_opts = {
									adapter = nil, -- defaults to current chat adapter
									model = nil, -- defaults to current chat model
									context_size = 90000, -- max tokens that the model supports
									include_references = true, -- include slash command content
									include_tool_outputs = true, -- include tool execution results
									system_prompt = nil, -- custom system prompt (string or function)
									format_summary = nil, -- custom function to format generated summary e.g to remove <think/> tags from summary
								},
							},
						},
					},
				},
				adapters = {
					acp = {
						codex = function()
							return require("codecompanion.adapters").extend("codex", {
								defaults = {
									auth_method = "chatgpt", -- "openai-api-key"|"codex-api-key"|"chatgpt"
								},
								env = {
									OPENAI_API_KEY = "my-api-key",
								},
							})
						end,
						opencode = function()
							return require("codecompanion.adapters").extend(create_opencode_acp_adapter())
						end,
					},
				},
				strategies = {
					chat = {
						adapter = {
							name = "copilot",
							model = "gpt-4.1",
						},
						variables = {
							["buffer"] = {
								opts = {
									default_params = "pin", -- or 'watch'
								},
							},
						},
					},
				},
			})
			vim.keymap.set({ "x", "n" }, "<leader>aa", ":CodeCompanion #{buffer} ")
			vim.keymap.set({ "n", "x" }, "<leader>ad", ":CodeCompanionChat #{buffer} #{lsp} ")
			vim.keymap.set({ "x", "n" }, "<leader>ac", ":CodeCompanionChat #{buffer} ")
			vim.keymap.set("n", "<leader>ta", "<cmd>CodeCompanionChat Toggle<cr>")
		end,
	},
}
