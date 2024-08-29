return {
    { "andrewferrier/debugprint.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvimtools/hydra.nvim"
        },
        version = "*",
        config = function()
            require("plugins_conf.debugprint")
        end
    }

}
