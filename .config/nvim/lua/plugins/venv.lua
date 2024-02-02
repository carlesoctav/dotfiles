return {
    {
        'linux-cultist/venv-selector.nvim',
        dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
        event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
        config = function()
            require('venv-selector').setup {
                name = { 'venv', 'env', '.venv' },
            }
            vim.keymap.set('n', '<leader>vs', '<cmd>VenvSelect<CR>')
            vim.keymap.set('n', '<leader>vc', '<cmd>VenvSelectCached<CR>')
        end
    }
}
