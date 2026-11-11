return {
  -- LSP Configuration & Diagnostic Popup Bounds
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
        underline = true,
        signs = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
          wrap = true,
          max_width = 80,
          max_height = 12,
        },
      },
    },
    init = function()
      -- Constrain native LSP hover documentation popup size (prevents full-screen docstring takeovers)
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        {
          border = "rounded",
          max_width = 80,
          max_height = 15,
        }
      )
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        {
          border = "rounded",
          max_width = 80,
          max_height = 10,
        }
      )
    end,
  },

  -- Suppress Pyright progress popup spam & constrain Noice hover window size
  {
    "folke/noice.nvim",
    opts = {
      views = {
        hover = {
          border = {
            style = "rounded",
          },
          size = {
            max_width = 80,
            max_height = 15,
          },
          win_options = {
            wrap = true,
          },
        },
      },
      routes = {
        -- Skip Pyright LSP progress notification popups
        {
          filter = {
            event = "lsp",
            kind = "progress",
            find = "pyright",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "lsp",
            kind = "progress",
            find = "Pyright",
          },
          opts = { skip = true },
        },
      },
    },
  },
}
