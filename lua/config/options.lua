-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Force LazyVim to always use the current working directory (cwd) as workspace root
-- Fixes root detection jumping to parent .git folders (e.g. ~/rusty instead of ~/rusty/export_sheet)
vim.g.root_spec = { "cwd" }

-- Fast, smooth cursor motion settings (Zed style responsiveness)
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300

-- Disable spell checking completely
vim.opt.spell = false

-- System clipboard integration
vim.opt.clipboard = "unnamedplus"

