
return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap-python",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            -- Find the project Python interpreter
            local root = vim.fs.root(0, {
                "pyproject.toml",
                ".git",
            }) or vim.fn.getcwd()

            local python = root .. "/.venv/Scripts/python.exe"

            if vim.fn.executable(python) ~= 1 then
                python = vim.fn.exepath("python")
            end

            -- Configure Python debugging
            require("dap-python").setup(python)

            -- Configure debugging UI
            dapui.setup()

            dap.listeners.after.event_initialized["dapui"] = function()
                dapui.open()
            end

            dap.listeners.before.event_terminated["dapui"] = function()
                dapui.close()
            end

            dap.listeners.before.event_exited["dapui"] = function()
                dapui.close()
            end

            -- Keybindings
            vim.keymap.set("n", "<F5>", dap.continue)
            vim.keymap.set("n", "<F10>", dap.step_over)
            vim.keymap.set("n", "<F11>", dap.step_into)
            vim.keymap.set("n", "<F12>", dap.step_out)

            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
            vim.keymap.set("n", "<leader>dB", function()
                dap.set_breakpoint(
                    vim.fn.input("Breakpoint condition: ")
                )
            end)

            vim.keymap.set("n", "<leader>du", dapui.toggle)
            vim.keymap.set("n", "<leader>dr", dap.repl.open)
        end,
    },
}
