return {
    'tpope/vim-sleuth',
    {
        'echasnovski/mini.nvim',
        config = function()
            require('mini.ai').setup { n_lines = 500 }
            require('mini.pairs').setup()
            require('mini.surround').setup()
            require('mini.jump').setup()
            require('mini.comment').setup()
        end,
    },
    { "LunarVim/bigfile.nvim" },
}

