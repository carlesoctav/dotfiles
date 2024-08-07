return{
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },
                sync_install = false,
                auto_install = true,
                ignore_install = {},
                modules = {},
                highlight = { enable = true },
                indent = { enable = true},
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<c-space>',
                        node_incremental = '<c-space>',
                        scope_incremental = '<c-s>',
                        node_decremental = '<M-space>',
                    },
                },
                textobjects = {
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["gj"] = "@function.outer",
                            ["]]"] = "@class.outer",
                            -- ["]b"] = "@block.outer",
                            ["]a"] = "@parameter.inner",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["gJ"] = "@function.outer",
                            ["]["] = "@class.outer",
                            -- ["]B"] = "@block.outer",
                            ["]A"] = "@parameter.inner",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["gk"] = "@function.outer",
                            ["[["] = "@class.outer",
                            -- ["[b"] = "@block.outer",
                            ["[a"] = "@parameter.inner",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["gK"] = "@function.outer",
                            ["[]"] = "@class.outer",
                            -- ["[B"] = "@block.outer",
                            ["[A"] = "@parameter.inner",
                        },
                    },
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["ab"] = "@block.outer",
                            ["ib"] = "@block.inner",
                            ["al"] = "@loop.outer",
                            ["il"] = "@loop.inner",
                            ["a/"] = "@comment.outer",
                            ["i/"] = "@comment.outer", 
                            ["aa"] = "@parameter.outer", 
                            ["ia"] = "@parameter.inner",
                        },
                    },
                },
            }
        end,

    },
    {'nvim-treesitter/nvim-treesitter-textobjects'},
    -- {'nvim-treesitter/nvim-treesitter-context'}
}
