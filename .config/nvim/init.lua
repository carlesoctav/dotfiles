require("options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

if vim.g.vscode then
	require("vscode_remap")
	vim.opt.rtp:prepend(lazypath)
	require("lazy").setup({
		spec = {
			{ import = "vscode_plugins" }, -- {import = "plugins.python"},
		},
	})

else
	vim.opt.rtp:prepend(lazypath)
	require("lazy").setup({
		spec = {
			{ import = "plugins" },
			-- {import = "plugins.python"},
		},
	})
	require("remap")
	require("snip.go")
end
