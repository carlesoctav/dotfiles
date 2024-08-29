return {
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim", -- required by telescope
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
            'rcarriga/nvim-notify',
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            -- configuration goes here
            lang = "golang",
            storage = {
                home = "/home/carlesoctav/personal/proof-by-ac/leetcode/",
                cache = vim.fn.stdpath("cache") .. "/leetcode",
            },
            injector = { 
                ["cpp"] = {
                    before = { "#include <bits/stdc++.h>", "using namespace std;" },
                    after = "int main() {}",
                },
                ["python3"] = {
                    before = "from typing import *"
                },
                ["java"] = {
                    before = "import java.util.*;",
                },
                ["golang"] = {
                    before = "package main",
                }
            }
        },
    }
}
