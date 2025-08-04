return {
  {
    "olimorris/codecompanion.nvim",

    dependencies = {
      "github/copilot.vim",
      {
        "echasnovski/mini.diff",
        config = function()
          local diff = require("mini.diff")
          diff.setup({
            -- Disabled by default
            source = diff.gen_source.none(),
          })
        end,
      },
    },
    init = function()
      vim.g.copilot_enabled = false
    end,
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
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
      vim.keymap.set("x", "<leader>ad", ":CodeCompanion #{buffer} replace<cr>")
      vim.keymap.set("x", "<leader>aa", ":CodeCompanion #{buffer} #{lsp} replace<cr>")
      vim.keymap.set("n", "<leader>aa", "<cmd>CodeCompanionChatToggle<cr>")
    end,
  }
}
