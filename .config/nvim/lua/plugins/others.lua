return{

    'Asheq/close-buffers.vim',
    { 'LunarVim/bigfile.nvim'}, 
    { 'numToStr/Comment.nvim', opts = {} },
    'tpope/vim-sleuth',
    'Asheq/close-buffers.vim',
    { 'nvim-tree/nvim-web-devicons' },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },
    {
        'echasnovski/mini.nvim',
        config = function()
            require('mini.ai').setup { n_lines = 500 }
            require('mini.pairs').setup()
            require('mini.surround').setup()
            require('mini.tabline').setup()
            require('mini.statusline').setup()
            require('mini.jump').setup()
        end,
    },

}
