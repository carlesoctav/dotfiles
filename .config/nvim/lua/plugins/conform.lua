return {
    {
        'stevearc/conform.nvim',
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "ruff" },
                    javascript = { { "prettierd", "prettier" } },
                },
            })
        end

    }
}
