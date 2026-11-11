return {
  -- Configure Pyright LSP for syntax checking, type checking & parent venvs
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          before_init = function(_, config)
            local root = config.root_dir or vim.fn.getcwd()
            local search_dirs = {
              root,
              vim.fn.fnamemodify(root, ":h"),
              vim.fn.fnamemodify(root, ":h:h"),
              vim.fn.fnamemodify(root, ":h:h:h"),
            }

            for _, dir in ipairs(search_dirs) do
              for _, venv_name in ipairs({ "venv", ".venv", "env" }) do
                local venv_dir = dir .. "/" .. venv_name
                local python_bin = venv_dir .. "/bin/python"
                if vim.uv.fs_stat(python_bin) then
                  config.cmd_env = config.cmd_env or {}
                  config.cmd_env.VIRTUAL_ENV = venv_dir
                  config.cmd_env.PATH = venv_dir .. "/bin:" .. (vim.env.PATH or "")

                  config.settings = config.settings or {}
                  config.settings.python = config.settings.python or {}
                  config.settings.python.pythonPath = python_bin

                  local site_packages = vim.fn.glob(venv_dir .. "/lib/python*/site-packages", true, true)
                  if #site_packages > 0 then
                    config.settings.python.analysis = config.settings.python.analysis or {}
                    config.settings.python.analysis.extraPaths = site_packages
                  end
                  return
                end
              end
            end
          end,
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly", -- Optimized for speed and low RAM on large Python projects
                typeCheckingMode = "standard",
                diagnosticSeverityOverrides = {
                  reportMissingImports = "error",
                  reportUndefinedVariable = "error",
                  reportAttributeAccessIssue = "none",
                  reportMissingTypeStubs = "none",
                },
              },
            },
          },
        },
      },
    },
  },

  -- Enable parent directory virtualenv search in venv-selector
  {
    "linux-cultist/venv-selector.nvim",
    opts = function(_, opts)
      opts.search = opts.search or {}
      opts.search.parent_venvs = {
        command = "fd -H -I -t d '^(\\.venv|venv|env)$' .. ../..",
      }
      return opts
    end,
  },
}
