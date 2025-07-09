return {
	{
		"lewis6991/gitsigns.nvim",
		config = function(opts)
			require('gitsigns').setup({
				sign_priority = 100,
				on_attach = function(bufnr)
					local gitsigns = require('gitsigns')
					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					map('n', ']h', function()
						gitsigns.nav_hunk('next')
					end)

					map('n', '[h', function()
						gitsigns.nav_hunk('prev')
					end)

					map('n', '<leader>th', function()
						local trouble = require("trouble")
						gitsigns.setqflist('all', { open = false })
						trouble.toggle('qflist')
					end)

					map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
				end
			})
		end
	},

	{
		"sindrets/diffview.nvim",
		keys = {
			{
				"<leader>tv",
				function()
					if next(require("diffview.lib").views) == nil then
						vim.cmd("DiffviewOpen")
					else
						vim.cmd("DiffviewClose")
					end
				end,
				desc = "Toggle Diffview window",
			},
		},
	},

	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"sindrets/diffview.nvim"
		},
		config = function()
			require("neogit").setup({ kind = "replace" })
		end,
	},
	{
		"aaronhallaert/advanced-git-search.nvim",
		cmd = { "AdvancedGitSearch" },
	},
}
