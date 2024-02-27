return {
   "rest-nvim/rest.nvim",
   dependencies = { { "nvim-lua/plenary.nvim" } },
   config = function()
     require("rest-nvim").setup({
    })
   vim.keymap.set('n','<leader>re', '<Plug>RestNvim')
   vim.keymap.set('n','<leader>rp', '<Plug>RestNvimPreview')
   vim.keymap.set('n','<leader>rl', '<Plug>RestNvimLast')
  end
}
