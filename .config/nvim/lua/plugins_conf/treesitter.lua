-- Install parsers
require("nvim-treesitter").install({
	"c",
	"cpp",
	"lua",
	"python",
	"rust",
	"vimdoc",
	"vim",
	"bash",
})

-- Enable highlighting for all filetypes with parsers
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

-- Textobjects config
require("nvim-treesitter-textobjects").setup({
	select = {
		lookahead = true,
	},
	move = {
		set_jumps = true,
	},
})

local select = require("nvim-treesitter-textobjects.select")
local move = require("nvim-treesitter-textobjects.move")

-- Select textobjects
vim.keymap.set({ "x", "o" }, "af", function()
	select.select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
	select.select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
	select.select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
	select.select_textobject("@class.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ab", function()
	select.select_textobject("@block.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ib", function()
	select.select_textobject("@block.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "al", function()
	select.select_textobject("@loop.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "il", function()
	select.select_textobject("@loop.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "a/", function()
	select.select_textobject("@comment.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "i/", function()
	select.select_textobject("@comment.outer", "textobjects")
end)

-- Move to next/prev function
vim.keymap.set({ "n", "x", "o" }, "gj", function()
	move.goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "gJ", function()
	move.goto_next_end("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "gk", function()
	move.goto_previous_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "gK", function()
	move.goto_previous_end("@function.outer", "textobjects")
end)

-- Move to next/prev class
vim.keymap.set({ "n", "x", "o" }, "]c", function()
	move.goto_next_start("@class.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "]C", function()
	move.goto_next_end("@class.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[c", function()
	move.goto_previous_start("@class.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[C", function()
	move.goto_previous_end("@class.outer", "textobjects")
end)

-- Move to next/prev parameter
vim.keymap.set({ "n", "x", "o" }, "]a", function()
	move.goto_next_start("@parameter.inner", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "]A", function()
	move.goto_next_end("@parameter.inner", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[a", function()
	move.goto_previous_start("@parameter.inner", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[A", function()
	move.goto_previous_end("@parameter.inner", "textobjects")
end)
