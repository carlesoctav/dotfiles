return {
    -- {
    --     "polarmutex/git-worktree.nvim",
    --     branch = "v2",
    --     dependencies = { "nvim-lua/plenary.nvim" },
    --     config = function()
    --         local gwt = require("git-worktree")
    --         local Hooks = require("git-worktree.hooks")
    --
    --         gwt:setup()
    --         gwt:hooks({
    --             SWITCH = Hooks.builtins.update_current_buffer_on_switch
    --         })
    --         require('telescope').load_extension('git_worktree')
    --         vim.keymap.set('n', '<leader>st', function() require('telescope').extensions.git_worktree.git_worktree() end)
    --
    --
    --     end
    -- }
}
