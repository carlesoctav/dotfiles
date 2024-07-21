vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "q", "<nop>")

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<PageDown>", "<C-d>zz")
vim.keymap.set("n", "<PageUp>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("n", "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>P", [["+P]])
vim.keymap.set({ "n", "v" }, "<leader>c", [["_c]])

vim.keymap.set("n", "[b", "<cmd>bprevious<CR>")
vim.keymap.set("n", "]b", "<cmd>bnext<CR>")
vim.keymap.set("n", "<C-q>", "<cmd>bdelete<CR>")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set({ "v" }, "/", [["hy:/<C-r>h<CR>]])



vim.keymap.set("n","gd", vim.lsp.buf.definition)
vim.keymap.set("n","gr", vim.lsp.buf.references)
vim.keymap.set("n","gI", vim.lsp.buf.implementation)
vim.keymap.set("n","<leader>D", vim.lsp.buf.type_definition)
vim.keymap.set("n","<leader>ds", vim.lsp.buf.document_symbol)
vim.keymap.set("n","<leader>ws", vim.lsp.buf.workspace_symbol)
vim.keymap.set("n","<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n","[d", vim.diagnostic.goto_prev)
vim.keymap.set("n","]d", vim.diagnostic.goto_next)
vim.keymap.set("n","<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n","K", vim.lsp.buf.hover)
vim.keymap.set("n","gD", vim.lsp.buf.declaration)
vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help)
vim.keymap.set("n","<leader>f", vim.lsp.buf.format)
