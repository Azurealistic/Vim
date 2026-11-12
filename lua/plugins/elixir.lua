return {
    {
        "tpope/vim-projectionist",
        config = function()
            vim.g.projectionist_heuristics = {
                ["*"] = {
                    ["lib/*.ex"] = {
                        alternate = "test/{}_test.exs",
                        type = "source",
                    },
                    ["test/*_test.exs"] = {
                        alternate = "lib/{}.ex",
                        type = "test",
                    },
                },
            }
        end,
        lazy = false,
    },
}
