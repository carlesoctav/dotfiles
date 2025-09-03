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
						gitsigns.setqflist('all')
					end)

					map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
				end
			})
		end
	},

	"tpope/vim-fugitive",
	{'akinsho/git-conflict.nvim', version = "*", config = true}

}
