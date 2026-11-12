local theme_file = vim.fn.stdpath("state") .. "/last_theme.txt"

local function get_saved_theme()
	local f = io.open(theme_file, "r")
	if f then
		local t = f:read("*l")
		f:close()
		if t and #t > 0 then
			return t
		end
	end
	return "solarized-osaka"
end

-- Automatically persist theme selection on :colorscheme or <leader>uC theme picker
vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("PersistThemeSelection", { clear = true }),
	callback = function(args)
		if args.match and args.match ~= "" then
			local f = io.open(theme_file, "w")
			if f then
				f:write(args.match)
				f:close()
			end
		end
	end,
})

return {
	-- Transparent Background Plugin
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
		opts = {
			extra_groups = {
				"NormalFloat",
				"FloatBorder",
				"FloatTitle",
				"NvimTreeNormal",
				"NeoTreeNormal",
				"NeoTreeNormalNC",
				"SnacksNormal",
				"SnacksNormalNC",
				"SnacksBackdrop",
				"LineNr",
				"CursorLineNr",
				"SignColumn",
				"StatusLine",
				"StatusLineNC",
			},
		},
	},

	{
		"Shatur/neovim-ayu",
		name = "ayu",
		priority = 1000,
		opts = {
			mirage = false,
			terminal = true,
		},
	},

	{
		"nyoom-engineering/oxocarbon.nvim",
		name = "oxocarbon",
		build = false,
		priority = 1000
	},

	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		priority = 1000
	},

	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		lazy = false,
		priority = 1000
	},



	-- Dynamically load last selected theme across Neovim restarts
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = get_saved_theme(),
		},
	},
}
