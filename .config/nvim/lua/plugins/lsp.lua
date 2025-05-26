return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"Saghen/blink.cmp",
		{ "j-hui/fidget.nvim", opts = {} },
		'stevearc/conform.nvim',
	},
	config = function()
		require("plugins_conf.lsp")
	end,
}
