return {
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add          = { text = '│' },
                change       = { text = '│' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
        },
    },

    {
        "nvimtools/hydra.nvim",
        dependencies = {

            'lewis6991/gitsigns.nvim',
            'NeogitOrg/neogit'
        },
        config = function()
            local Hydra = require("hydra")
            local gitsigns = require('gitsigns')
            Hydra({
                name = 'Git',
                config = {
                    buffer = bufnr,
                    color = 'pink',
                    invoke_on_body = true,
                    on_enter = function()
                        vim.cmd 'mkview'
                        vim.cmd 'silent! %foldopen!'
                        vim.bo.modifiable = false
                        gitsigns.toggle_signs(true)
                        gitsigns.toggle_linehl(true)
                    end,
                    on_exit = function()
                        local cursor_pos = vim.api.nvim_win_get_cursor(0)
                        vim.cmd 'loadview'
                        vim.api.nvim_win_set_cursor(0, cursor_pos)
                        vim.cmd 'normal zv'
                        gitsigns.toggle_signs(true)
                        gitsigns.toggle_linehl(false)
                        gitsigns.toggle_deleted(false)
                    end,
                },
                mode = {'n','x'},
                body = '<leader>h',
                heads = {
                    { 'J',
                        function()
                            if vim.wo.diff then return ']c' end
                            vim.schedule(function() gitsigns.next_hunk() end)
                            return '<Ignore>'
                        end,
                        { expr = true, desc = 'next hunk' } },
                    { 'K',
                        function()
                            if vim.wo.diff then return '[c' end
                            vim.schedule(function() gitsigns.prev_hunk() end)
                            return '<Ignore>'
                        end,
                        { expr = true, desc = 'prev hunk' } },
                    { 's', ':Gitsigns stage_hunk<CR>', { silent = true, desc = 'stage hunk' } },
                    { 'u', gitsigns.undo_stage_hunk, { desc = 'undo last stage' } },
                    { 'S', gitsigns.stage_buffer, { desc = 'stage buffer' } },
                    { 'p', gitsigns.preview_hunk, { desc = 'preview hunk' } },
                    { 'b', gitsigns.blame_line, { desc = 'blame' } },
                    { 'B', function() gitsigns.blame_line{ full = true } end, { desc = 'blame show full' } },
                    { 'q', nil, { exit = true, nowait = true, desc = 'exit' } },
                    { '<Esc>', nil, { exit = true, nowait = true, desc = 'exit' } },
                }
            })
        end
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function ()
           require("neogit").setup({})
        end
    },
}
