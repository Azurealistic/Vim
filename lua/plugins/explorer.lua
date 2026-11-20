return {
    "folke/snacks.nvim",
    opts = {
        explorer = {},
        picker = {
            sources = {
                explorer = {
                    hidden = true, -- show dotfiles
                    ignored = true, -- show gitignored files (optional)
                },
            },
        },
    },
}
