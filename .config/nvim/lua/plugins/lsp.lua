local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    nmap('gR', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap("gr", function() require("trouble").toggle("lsp_references") end)
    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end)
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
        require('conform').format()
    end, { desc = 'Format current buffer with LSP' })
end




return {
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = true
    },
    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'rafamadriz/friendly-snippets',
            'hrsh7th/cmp-nvim-lsp-signature-help',
        },
        config = function()

            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            require('neogen').setup({ snippet_engine = "luasnip" })
            local neogen = require('neogen')
            require('luasnip.loaders.from_vscode').lazy_load()
            luasnip.config.setup {}

            vim.keymap.set('n', '<leader>ct', function()
                neogen.generate()
            end, {})

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                },

                mapping = cmp.mapping.preset.insert {
                    ['<C-Space>'] = cmp.mapping.complete {},
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-e>'] = cmp.mapping.close(),
                    ['<Tab>'] = cmp.mapping.confirm{
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif neogen.jumpable() then
                            neogen.jump_next()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),

                    ['<S-tab>'] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        elseif neogen.jumpable(true) then
                            neogen.jump_prev()
                        else
                            fallback()
                        end
                    end, { 'i', 's' })
                },
                sources = {
                    -- { name = "copilot",  group_index = 2 },
                    -- { name = 'nvim_lsp_signature_help' },
                    { name = "nvim_lsp"},
                    { name = "buffer"},
                    { name = "path",
                        option = {
                            get_cwd = function() return vim.fn.getcwd() end
                        }
                    },
                    { name = "luasnip"},
                },
            }
        end
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',
            { 'j-hui/fidget.nvim',       opts = {} },
            'folke/neodev.nvim',
        },
        config = function()
            require('mason').setup()
            require('mason-lspconfig').setup()
            require('neodev').setup()

            local servers = {
                gopls = {},
                pyright = {},
            }

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            local mason_lspconfig = require 'mason-lspconfig'

            mason_lspconfig.setup {
                ensure_installed = vim.tbl_keys(servers),
            }

            mason_lspconfig.setup_handlers {
                function(server_name)
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes,
                    }
                end,
            }
        end
    },
}
