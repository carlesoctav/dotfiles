local opts = {
	create_keymaps = false,
}
require("debugprint").setup({ opts })
Hydra = require("hydra")
Hydra({
	name = "debug mode",
	config = {
		color = "pink",
		invoke_on_body = true,
		on_enter = function() end,
		on_exit = function() end,
	},
	mode = { "n", "x" },
	body = "<leader>d",
	heads = {
		{
			"p",
			function()
				return require("debugprint").debugprint()
			end,
			{ silent = true, desc = "print below", expr = true },
		},
		{
			"P",
			function()
				return require("debugprint").debugprint({ above = true })
			end,
			{ silent = true, desc = "print above", expr = true },
		},
		{
			"o",
			function()
				return require("debugprint").debugprint({ variable = true })
			end,
			{ silent = true, desc = "print var below", expr = true },
		},
		{
			"O",
			function()
				return require("debugprint").debugprint({ above = true, variable = true })
			end,
			{ silent = true, desc = "print var above", expr = true },
		},
		{ "td", "<Cmd>DeleteDebugPrints<Cr>", { silent = true, desc = "delete" } },
		{ "q", nil, { exit = true, nowait = true, desc = "exit" } },
		{ "<Esc>", nil, { exit = true, nowait = true, desc = "exit" } },
	},
})
