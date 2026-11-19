-- Vira Carbon: Neovim port of the Vira-Theme-Carbon VS Code theme.
local M = {}

-- Palette (taken straight from the VS Code theme) ---------------------------
local p = {
    bg       = "#0A0A0A",
    bg_alt   = "#161718", -- input / peek view background
    fg       = "#D9D9D9",
    comment  = "#45454A",
    gutter   = "#2F3237", -- line numbers, whitespace, cursorline base
    gutter_a = "#56575D", -- active line number, inactive UI text
    status   = "#494B50",
    guide    = "#383838", -- indent guides, rulers
    select   = "#474747",

    cyan     = "#6ebad7", -- keywords, punctuation
    blue     = "#6a90d0", -- functions
    purple   = "#a178c4", -- storage (def, class, ...)
    green    = "#a3c679", -- strings
    yellow   = "#d5b05f", -- types
    orange   = "#cd775c", -- numbers
    red      = "#c85e60", -- properties, tags
    pink     = "#d6808f", -- booleans
    steel    = "#90a9bc", -- readonly props, self
    brown    = "#7d5e49",
    teal     = "#80CBC4", -- accent (selection, links, borders)
    gold     = "#FFCC00", -- cursor
    black    = "#000000",
    white    = "#FFFFFF",
}

-- Neovim highlights have no alpha channel, so VS Code colors like #D9D9D91a
-- are pre-mixed against a background: out = a*fg + (1-a)*bg for each of R, G, B.
local function blend(fg, bg, a)
    local function rgb(h)
        h = h:gsub("#", "")
        return tonumber(h:sub(1, 2), 16), tonumber(h:sub(3, 4), 16), tonumber(h:sub(5, 6), 16)
    end
    local fr, fg_, fb = rgb(fg)
    local br, bg_, bb = rgb(bg)
    local function mix(f, b)
        return math.floor(a * f + (1 - a) * b + 0.5)
    end
    return string.format("#%02x%02x%02x", mix(fr, br), mix(fg_, bg_), mix(fb, bb))
end

function M.load()
    local bg, fg       = p.bg, p.fg

    -- Derived (alpha-blended) colors. The alpha is the hex byte / 255.
    local float_border = blend(p.white, bg, 0.06) -- #FFFFFF0f
    local win_sep      = blend(fg, bg, 0.06)     -- #D9D9D90f
    local cursorline   = blend(p.gutter, bg, 0.40) -- #2F323766
    local visual       = blend(p.select, bg, 0.50) -- #47474780
    local hover_sel    = blend(fg, bg, 0.10)     -- #D9D9D91a
    local search_bg    = blend(fg, bg, 0.15)     -- #D9D9D926
    local word_hl      = blend(p.pink, bg, 0.30) -- #d6808f4d
    local word_hl_w    = blend(p.green, bg, 0.30) -- #a3c6794d
    local guide_dim    = blend(p.guide, bg, 0.70) -- #383838b3
    local sign         = 0.6                     -- #......99
    local diag         = 0.7                     -- #......b3

    local err          = blend(p.red, bg, diag)
    local warn         = blend(p.yellow, bg, diag)
    local info         = blend(p.blue, bg, diag)
    local hint         = p.cyan

    local hl           = {
        -- Editor UI ------------------------------------------------------------
        Normal                                   = { fg = fg, bg = bg },
        NormalNC                                 = { fg = fg, bg = bg },
        NormalFloat                              = { fg = fg, bg = bg },
        FloatBorder                              = { fg = float_border, bg = bg },
        FloatTitle                               = { fg = p.teal, bg = bg },
        Cursor                                   = { fg = bg, bg = p.gold },
        lCursor                                  = { link = "Cursor" },
        TermCursor                               = { link = "Cursor" },
        CursorLine                               = { bg = cursorline },
        CursorColumn                             = { bg = cursorline },
        ColorColumn                              = { bg = p.guide },
        Visual                                   = { bg = visual },
        VisualNOS                                = { bg = visual },
        LineNr                                   = { fg = p.gutter },
        CursorLineNr                             = { fg = p.gutter_a },
        SignColumn                               = { fg = p.gutter, bg = bg },
        FoldColumn                               = { fg = p.gutter, bg = bg },
        Folded                                   = { fg = p.comment, bg = cursorline },
        EndOfBuffer                              = { fg = bg },
        NonText                                  = { fg = p.gutter },
        Whitespace                               = { fg = p.gutter },
        SpecialKey                               = { fg = p.gutter },
        Conceal                                  = { fg = p.comment },
        WinSeparator                             = { fg = win_sep, bg = bg },
        VertSplit                                = { link = "WinSeparator" },
        MatchParen                               = { fg = p.gold, bold = true },
        Search                                   = { bg = search_bg },
        CurSearch                                = { fg = p.black, bg = p.teal },
        IncSearch                                = { fg = p.black, bg = p.teal },
        Substitute                               = { fg = p.black, bg = p.pink },
        QuickFixLine                             = { bg = hover_sel },
        Directory                                = { fg = p.blue },
        Title                                    = { fg = p.cyan, bold = true },
        ErrorMsg                                 = { fg = p.red },
        WarningMsg                               = { fg = p.yellow },
        MoreMsg                                  = { fg = p.green },
        ModeMsg                                  = { fg = p.fg },
        Question                                 = { fg = p.teal },
        WildMenu                                 = { bg = cursorline },
        Pmenu                                    = { fg = fg, bg = bg },
        PmenuSel                                 = { fg = fg, bg = cursorline },
        PmenuSbar                                = { bg = cursorline },
        PmenuThumb                               = { bg = p.guide },
        PmenuMatch                               = { fg = p.teal },
        PmenuMatchSel                            = { fg = p.teal, bg = cursorline },
        StatusLine                               = { fg = p.status, bg = bg },
        StatusLineNC                             = { fg = p.gutter_a, bg = bg },
        TabLine                                  = { fg = p.gutter_a, bg = bg },
        TabLineFill                              = { bg = bg },
        TabLineSel                               = { fg = p.white, bg = bg },
        WinBar                                   = { fg = p.gutter_a, bg = bg },
        WinBarNC                                 = { fg = p.gutter_a, bg = bg },
        SpellBad                                 = { sp = p.red, undercurl = true },
        SpellCap                                 = { sp = p.yellow, undercurl = true },
        SpellLocal                               = { sp = p.cyan, undercurl = true },
        SpellRare                                = { sp = p.purple, undercurl = true },

        -- Diff / git ---------------------------------------------------------
        DiffAdd                                  = { bg = blend(p.green, bg, 0.06) },
        DiffDelete                               = { bg = blend(p.red, bg, 0.08) },
        DiffChange                               = { bg = blend(p.blue, bg, 0.08) },
        DiffText                                 = { bg = blend(p.blue, bg, 0.22) },
        Added                                    = { fg = p.green },
        Removed                                  = { fg = p.red },
        Changed                                  = { fg = p.blue },
        GitSignsAdd                              = { fg = blend(p.green, bg, sign) },
        GitSignsChange                           = { fg = blend(p.blue, bg, sign) },
        GitSignsDelete                           = { fg = blend(p.red, bg, sign) },

        -- Diagnostics ----------------------------------------------------------
        DiagnosticError                          = { fg = err },
        DiagnosticWarn                           = { fg = warn },
        DiagnosticInfo                           = { fg = info },
        DiagnosticHint                           = { fg = hint },
        DiagnosticOk                             = { fg = p.green },
        DiagnosticUnderlineError                 = { sp = p.red, undercurl = true },
        DiagnosticUnderlineWarn                  = { sp = p.yellow, undercurl = true },
        DiagnosticUnderlineInfo                  = { sp = p.blue, undercurl = true },
        DiagnosticUnderlineHint                  = { sp = p.cyan, undercurl = true },
        DiagnosticVirtualTextError               = { fg = err, bg = blend(p.red, bg, 0.08) },
        DiagnosticVirtualTextWarn                = { fg = warn, bg = blend(p.yellow, bg, 0.08) },
        DiagnosticVirtualTextInfo                = { fg = info, bg = blend(p.blue, bg, 0.08) },
        DiagnosticVirtualTextHint                = { fg = hint, bg = blend(p.cyan, bg, 0.08) },
        LspReferenceText                         = { bg = word_hl },
        LspReferenceRead                         = { bg = word_hl },
        LspReferenceWrite                        = { bg = word_hl_w },
        LspCodeLens                              = { fg = p.comment },
        LspInlayHint                             = { fg = p.comment, bg = blend(p.gutter, bg, 0.3) },

        -- Legacy syntax groups -------------------------------------------------
        Comment                                  = { fg = p.comment, italic = true },
        Constant                                 = { fg = fg },
        String                                   = { fg = p.green },
        Character                                = { fg = p.green },
        Number                                   = { fg = p.orange },
        Float                                    = { fg = p.orange },
        Boolean                                  = { fg = p.pink },
        Identifier                               = { fg = fg },
        Function                                 = { fg = p.blue },
        Statement                                = { fg = p.cyan, italic = true },
        Conditional                              = { fg = p.cyan, italic = true },
        Repeat                                   = { fg = p.cyan, italic = true },
        Label                                    = { fg = p.cyan },
        Operator                                 = { fg = p.cyan },
        Keyword                                  = { fg = p.cyan },
        Exception                                = { fg = p.cyan, italic = true },
        PreProc                                  = { fg = p.cyan },
        Include                                  = { fg = p.cyan, italic = true },
        Define                                   = { fg = p.purple },
        Macro                                    = { fg = p.purple },
        PreCondit                                = { fg = p.cyan },
        Type                                     = { fg = p.yellow },
        StorageClass                             = { fg = p.purple },
        Structure                                = { fg = p.purple },
        Typedef                                  = { fg = p.purple },
        Special                                  = { fg = p.cyan },
        SpecialChar                              = { fg = fg },
        Tag                                      = { fg = p.red },
        Delimiter                                = { fg = p.cyan },
        SpecialComment                           = { fg = p.comment, italic = true },
        Debug                                    = { fg = p.orange },
        Underlined                               = { underline = true },
        Error                                    = { fg = p.red },
        Todo                                     = { fg = p.yellow, bold = true },

        -- Treesitter -----------------------------------------------------------
        ["@variable"]                            = { fg = fg },
        ["@variable.builtin"]                    = { fg = p.cyan, italic = true },
        ["@variable.parameter"]                  = { fg = fg, italic = true },
        ["@variable.member"]                     = { fg = p.red },
        ["@property"]                            = { fg = p.red },
        ["@field"]                               = { fg = p.red },
        ["@constant"]                            = { fg = fg },
        ["@constant.builtin"]                    = { fg = p.cyan, italic = true },
        ["@constant.macro"]                      = { fg = p.purple },
        ["@module"]                              = { fg = p.yellow },
        ["@module.builtin"]                      = { fg = p.red, italic = true },
        ["@label"]                               = { fg = p.cyan },

        ["@string"]                              = { fg = p.green },
        ["@string.escape"]                       = { fg = fg },
        ["@string.special"]                      = { fg = p.cyan },
        ["@string.regexp"]                       = { fg = p.orange },
        ["@character"]                           = { fg = p.green },
        ["@number"]                              = { fg = p.orange },
        ["@number.float"]                        = { fg = p.orange },
        ["@boolean"]                             = { fg = p.pink },

        ["@type"]                                = { fg = p.yellow },
        ["@type.builtin"]                        = { fg = p.yellow },
        ["@type.definition"]                     = { fg = p.yellow },
        ["@attribute"]                           = { fg = p.purple },
        ["@constructor"]                         = { fg = p.yellow },

        ["@function"]                            = { fg = p.blue },
        ["@function.builtin"]                    = { fg = p.blue },
        ["@function.call"]                       = { fg = p.blue },
        ["@function.macro"]                      = { fg = p.purple },
        ["@function.method"]                     = { fg = p.blue },
        ["@function.method.call"]                = { fg = p.blue },

        ["@keyword"]                             = { fg = p.cyan },
        ["@keyword.function"]                    = { fg = p.purple },
        ["@keyword.type"]                        = { fg = p.purple },
        ["@keyword.modifier"]                    = { fg = p.purple },
        ["@keyword.operator"]                    = { fg = p.cyan },
        ["@keyword.conditional"]                 = { fg = p.cyan, italic = true },
        ["@keyword.repeat"]                      = { fg = p.cyan, italic = true },
        ["@keyword.return"]                      = { fg = p.cyan, italic = true },
        ["@keyword.exception"]                   = { fg = p.cyan, italic = true },
        ["@keyword.import"]                      = { fg = p.cyan, italic = true },
        ["@keyword.directive"]                   = { fg = p.cyan },
        ["@operator"]                            = { fg = p.cyan },

        ["@punctuation"]                         = { fg = p.cyan },
        ["@punctuation.delimiter"]               = { fg = p.cyan },
        ["@punctuation.bracket"]                 = { fg = p.cyan },
        ["@punctuation.special"]                 = { fg = p.cyan },

        ["@comment"]                             = { fg = p.comment, italic = true },
        ["@comment.documentation"]               = { fg = p.comment, italic = true },
        ["@comment.error"]                       = { fg = p.red, bold = true },
        ["@comment.warning"]                     = { fg = p.yellow, bold = true },
        ["@comment.todo"]                        = { fg = p.yellow, bold = true },
        ["@comment.note"]                        = { fg = p.blue, bold = true },

        ["@tag"]                                 = { fg = p.red },
        ["@tag.attribute"]                       = { fg = p.purple },
        ["@tag.delimiter"]                       = { fg = p.cyan },
        ["@tag.builtin"]                         = { fg = p.red },

        -- Markup
        ["@markup.heading"]                      = { fg = p.cyan, bold = true },
        ["@markup.italic"]                       = { fg = p.red, italic = true },
        ["@markup.strong"]                       = { fg = p.red, bold = true },
        ["@markup.strikethrough"]                = { strikethrough = true },
        ["@markup.underline"]                    = { underline = true },
        ["@markup.quote"]                        = { fg = p.cyan, italic = true },
        ["@markup.link"]                         = { fg = p.red },
        ["@markup.link.label"]                   = { fg = p.red },
        ["@markup.link.url"]                     = { fg = p.teal, underline = true },
        ["@markup.raw"]                          = { fg = p.green },
        ["@markup.list"]                         = { fg = p.cyan },
        ["@diff.plus"]                           = { fg = p.green },
        ["@diff.minus"]                          = { fg = p.red },
        ["@diff.delta"]                          = { fg = p.blue },

        -- LSP semantic tokens (mirrors semanticTokenColors) --------------------
        ["@lsp.type.variable"]                   = { fg = fg },
        ["@lsp.type.parameter"]                  = { fg = fg, italic = true },
        ["@lsp.type.property"]                   = { fg = fg },
        ["@lsp.type.enumMember"]                 = { fg = fg },
        ["@lsp.type.type"]                       = { fg = p.yellow },
        ["@lsp.type.typeParameter"]              = { fg = p.orange },
        ["@lsp.type.class"]                      = { fg = p.blue },
        ["@lsp.type.function"]                   = { fg = p.blue },
        ["@lsp.type.method"]                     = { fg = p.blue },
        ["@lsp.type.namespace"]                  = { fg = p.yellow },
        ["@lsp.type.module"]                     = { fg = p.yellow },
        ["@lsp.type.number"]                     = { fg = p.orange },
        ["@lsp.type.string"]                     = { fg = p.green },
        ["@lsp.type.comment"]                    = { fg = p.comment, italic = true },
        ["@lsp.type.selfParameter"]              = { fg = p.steel, italic = true },
        ["@lsp.typemod.property.readonly"]       = { fg = p.steel },
        ["@lsp.typemod.variable.readonly"]       = { fg = fg },
        ["@lsp.typemod.variable.defaultLibrary"] = { fg = fg },

        -- Completion (blink.cmp / nvim-cmp) -------------------------------------
        BlinkCmpMenu                             = { link = "Pmenu" },
        BlinkCmpMenuBorder                       = { link = "FloatBorder" },
        BlinkCmpMenuSelection                    = { link = "PmenuSel" },
        BlinkCmpDoc                              = { link = "NormalFloat" },
        BlinkCmpDocBorder                        = { link = "FloatBorder" },
        BlinkCmpLabelMatch                       = { fg = p.teal },
        BlinkCmpLabelDeprecated                  = { fg = p.comment, strikethrough = true },
        CmpItemAbbrMatch                         = { fg = p.teal },
        CmpItemAbbrMatchFuzzy                    = { fg = p.teal },
        CmpItemAbbrDeprecated                    = { fg = p.comment, strikethrough = true },

        -- Snacks (LazyVim default) --------------------------------------------
        SnacksIndent                             = { fg = guide_dim },
        SnacksIndentScope                        = { fg = p.teal },
        SnacksPickerMatch                        = { fg = p.teal },
        SnacksPickerDir                          = { fg = p.comment },
        SnacksPickerBorder                       = { link = "FloatBorder" },
        SnacksDashboardHeader                    = { fg = p.teal },
        SnacksDashboardKey                       = { fg = p.yellow },
        SnacksDashboardIcon                      = { fg = p.cyan },
        SnacksDashboardDesc                      = { fg = fg },
        SnacksDashboardFooter                    = { fg = p.comment },

        -- Misc plugins --------------------------------------------------------
        WhichKey                                 = { fg = p.teal },
        WhichKeyDesc                             = { fg = fg },
        WhichKeyGroup                            = { fg = p.blue },
        WhichKeySeparator                        = { fg = p.comment },
        WhichKeyNormal                           = { link = "NormalFloat" },
        FlashLabel                               = { fg = p.black, bg = p.pink, bold = true },
        FlashMatch                               = { fg = fg, bg = search_bg },
        FlashCurrent                             = { fg = p.black, bg = p.teal },
        TelescopeMatching                        = { fg = p.teal },
        TelescopeSelection                       = { bg = cursorline },
        TelescopeBorder                          = { link = "FloatBorder" },
        NeoTreeNormal                            = { fg = p.gutter_a, bg = bg },
        NeoTreeNormalNC                          = { fg = p.gutter_a, bg = bg },
        NeoTreeDirectoryName                     = { fg = fg },
        NeoTreeDirectoryIcon                     = { fg = p.blue },
        NeoTreeIndentMarker                      = { fg = p.guide },
        NeoTreeGitModified                       = { fg = p.blue },
        NeoTreeGitAdded                          = { fg = p.green },
        NeoTreeGitUntracked                      = { fg = p.green },
        NeoTreeGitDeleted                        = { fg = p.red },
        NeoTreeGitConflict                       = { fg = p.yellow },
        NoicePopupmenuSelected                   = { link = "PmenuSel" },
        NotifyBackground                         = { bg = bg },
        BufferLineFill                           = { bg = bg },

        -- mini.icons (LazyVim's icon provider) ---------------------------------
        MiniIconsAzure                           = { fg = p.cyan },
        MiniIconsBlue                            = { fg = p.blue },
        MiniIconsCyan                            = { fg = p.teal },
        MiniIconsGreen                           = { fg = p.green },
        MiniIconsGrey                            = { fg = p.steel },
        MiniIconsOrange                          = { fg = p.orange },
        MiniIconsPurple                          = { fg = p.purple },
        MiniIconsRed                             = { fg = p.red },
        MiniIconsYellow                          = { fg = p.yellow },
    }

    for group, opts in pairs(hl) do
        vim.api.nvim_set_hl(0, group, opts)
    end

    -- Terminal (:terminal) colors, from the theme's terminal.ansi* entries.
    local term = {
        p.black, p.red, p.green, p.yellow, p.blue, p.purple, p.cyan, p.white,
        p.comment, p.red, p.green, p.yellow, p.blue, p.purple, p.cyan, p.white,
    }
    for i, color in ipairs(term) do
        vim.g["terminal_color_" .. (i - 1)] = color
    end
end

M.palette = p

return M
