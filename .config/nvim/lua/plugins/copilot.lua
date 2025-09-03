return {
  {
   "olimorris/codecompanion.nvim", 

    event = "VeryLazy",
    dependencies = {
      "github/copilot.vim",
    },
    init = function()
      vim.g.copilot_enabled = false
    end,
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = {
              name = "copilot",
              model = "gpt-4.1",
            },
            variables = {
              ["buffer"] = {
                opts = {
                  default_params = 'pin', -- or 'watch'
                },
              },
            },
          },
        }
      })
      vim.keymap.set({ "x", "n" }, "<leader>aa", ":CodeCompanion #{buffer} ")
      vim.keymap.set({ "n", "x" }, "<leader>ad", ":CodeCompanionChat #{buffer} #{lsp} ")
      vim.keymap.set({ "x", "n" }, "<leader>ac", ":CodeCompanionChat #{buffer} ")
      vim.keymap.set("n", "<leader>ta", "<cmd>CodeCompanionChat Toggle<cr>")
    end,
  }
}
