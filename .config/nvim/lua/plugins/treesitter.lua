return {
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require("plugins_conf.treesitter")
        end,

    },
    {'nvim-treesitter/nvim-treesitter-textobjects'},
}
