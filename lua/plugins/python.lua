return {
	-- Make sure debugpy is available even if you don't use uv's --with route
	{
		"mason-org/mason.nvim", -- use "williamboman/mason.nvim" on older LazyVim
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "debugpy" })
		end,
	},

	-- Debug through uv so the project's venv is used automatically
	{
		"mfussenegger/nvim-dap-python",
		config = function()
			require("dap-python").setup("uv")
		end,
	},

	-- Run tests with pytest; neotest-python finds the project .venv itself
	{
		"nvim-neotest/neotest",
		opts = {
			adapters = {
				["neotest-python"] = { runner = "pytest" },
			},
		},
	},
}
