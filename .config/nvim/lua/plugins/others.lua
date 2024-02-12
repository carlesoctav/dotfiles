return{
    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        dependencies = {
            "barklan/capslock.nvim"
        },
        opts = {
            options = {
                icons_enabled = false,
                theme = 'auto',
                component_separators = '|',
                section_separators = '',
            },
        },
    },
    -- 'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    -- 'tpope/vim-sleuth',

    'rhysd/clever-f.vim',

    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {},
    },

    { 'numToStr/Comment.nvim', opts = {} },

    {
        'nmac427/guess-indent.nvim',
        config = function() require('guess-indent').setup {} end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
        }
    },

    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    }
}
