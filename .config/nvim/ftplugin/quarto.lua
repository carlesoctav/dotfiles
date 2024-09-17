local quarto = require("quarto")
vim.keymap.set("n", "<leader>qp", quarto.quartoPreview, { silent = true, noremap = true })
local runner = require("quarto.runner")
vim.keymap.set("n", "<leader>rc", runner.run_cell, { desc = "run cell", silent = true })
vim.keymap.set("n", "<leader>ra", runner.run_above, { desc = "run cell and above", silent = true })
vim.keymap.set("n", "<leader>rA", runner.run_all, { desc = "run all cells", silent = true })
vim.keymap.set("n", "<leader>rl", runner.run_line, { desc = "run line", silent = true })
vim.keymap.set("v", "<leader>r", runner.run_range, { desc = "run visual range", silent = true })
vim.keymap.set("n", "<leader>RA", function()
	runner.run_all(true)
end, { desc = "run all cells of all languages", silent = true })

vim.g.slime_input_pid = false
vim.g.slime_suggest_default = true
vim.g.slime_menu_config = false
vim.g.slime_neovim_ignore_unlisted = true

local function mark_terminal()
	local job_id = vim.b.terminal_job_id
	vim.print("job_id: " .. job_id)
end

local function set_terminal()
	vim.fn.call("slime#config", {})
end
vim.keymap.set("n", "<leader>rm", mark_terminal)
vim.keymap.set("n", "<leader>rs", set_terminal)
