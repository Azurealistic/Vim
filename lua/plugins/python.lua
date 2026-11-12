return {
  -- not needed: debugpy is launched via uv by nvim-dap-python
  { "jay-babu/mason-nvim-dap.nvim", enabled = false },

  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup("uv")
    end,
  },
}