vim.cmd.highlight("clear")
if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "vira-carbon"

-- Drop the cached module so `:colorscheme vira-carbon` always picks up edits.
package.loaded["vira-carbon"] = nil
require("vira-carbon").load()
