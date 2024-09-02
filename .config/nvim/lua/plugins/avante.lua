return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		opts = {
			-- add any opts here
		},
		build = ":AvanteBuild", -- This is optional, recommended tho. Also note that this will block the startup for a bit since we are compiling bindings in Rust.
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("plugins_conf.avante")
		end,
	},
}
