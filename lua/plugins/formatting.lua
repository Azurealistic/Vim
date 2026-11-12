return {
	-- Disable Indent Guides (Snacks.indent & mini.indentscope)
	{
		"folke/snacks.nvim",
		opts = {
			indent = { enabled = false },
		},
	},

	{
		"stevearc/conform.nvim",
		opts = function(_, opts)
			opts.formatters_by_ft = opts.formatters_by_ft or {}
			opts.formatters_by_ft.rust = { "rustfmt" }
			opts.formatters_by_ft.python = { "ruff_fix", "ruff_organize_imports", "ruff_format" }
			opts.formatters_by_ft.lua = { "stylua" }
			opts.formatters_by_ft.sh = { "shfmt" }
			return opts
		end,
	},
}
