return {
  {
    'NickvanDyke/opencode.nvim',
    opts = {
      provider_id = "anthropic",
      model_id = "claude-sonnet-4-20250514",
      auto_reload = true,
    },
    keys = {
      { '<leader>oa', function() require('opencode').ask('@file ') end, desc = 'Ask opencode about current file', mode = 'n' },
      { '<leader>oA', function() require('opencode').ask('@files ') end, desc = 'Ask opencode about current file', mode = 'n' },
      { '<leader>oa', function() require('opencode').ask('@selection ') end, desc = 'Ask opencode about selection', mode = 'v' },
      { '<leader>od', function() require('opencode').ask('@diagnostics ') end, desc = 'Run diagnostics', mode = 'n' },
    },
  },

  {
    "github/copilot.vim",
    init = function()
      vim.g.copilot_enabled = false
    end,
  },
}
