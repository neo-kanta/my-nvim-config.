vim.cmd.highlight("clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd.syntax("reset")
end

vim.g.colors_name = "vs-dark"
vim.o.background = "dark"

local colors = {
  bg = "#1E1E1E",
  bg_alt = "#252526",
  bg_float = "#252526",
  bg_visual = "#264F78",
  border = "#3F3F46",
  comment = "#6A9955",
  constant = "#4FC1FF",
  error = "#F44747",
  fg = "#D4D4D4",
  fg_dim = "#9D9D9D",
  function_name = "#DCDCAA",
  git_add = "#608B4E",
  git_change = "#D7BA7D",
  git_delete = "#F44747",
  keyword = "#569CD6",
  line = "#2A2D2E",
  line_number = "#858585",
  number = "#B5CEA8",
  parameter = "#9CDCFE",
  punctuation = "#D4D4D4",
  search = "#613214",
  string = "#CE9178",
  type = "#4EC9B0",
  warning = "#CCA700",
}

local function set(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local function link(group, target)
  set(group, { link = target })
end

-- Editor UI
set("Normal", { fg = colors.fg, bg = "NONE" })
set("NormalNC", { fg = colors.fg, bg = "NONE" })
set("NormalFloat", { fg = colors.fg, bg = colors.bg_float })
set("FloatBorder", { fg = colors.border, bg = colors.bg_float })
set("FloatTitle", { fg = colors.fg, bg = colors.bg_float, bold = true })
set("Cursor", { fg = colors.bg, bg = colors.fg })
set("CursorLine", { bg = colors.line })
set("CursorColumn", { bg = colors.line })
set("CursorLineNr", { fg = "#C6C6C6", bg = colors.line })
set("LineNr", { fg = colors.line_number, bg = "NONE" })
set("SignColumn", { fg = colors.line_number, bg = "NONE" })
set("ColorColumn", { bg = colors.bg_alt })
set("Visual", { bg = colors.bg_visual })
set("Search", { fg = colors.fg, bg = colors.search })
set("IncSearch", { fg = colors.bg, bg = "#F9C74F" })
set("CurSearch", { fg = colors.bg, bg = "#F9C74F" })
set("MatchParen", { fg = "#FFFFFF", bg = "#3A3D41", bold = true })
set("Pmenu", { fg = colors.fg, bg = colors.bg_float })
set("PmenuSel", { fg = "#FFFFFF", bg = "#094771" })
set("PmenuSbar", { bg = "#3E3E42" })
set("PmenuThumb", { bg = "#686868" })
set("StatusLine", { fg = colors.fg, bg = "#007ACC" })
set("StatusLineNC", { fg = colors.fg_dim, bg = colors.bg_alt })
set("TabLine", { fg = colors.fg_dim, bg = colors.bg_alt })
set("TabLineFill", { bg = colors.bg_alt })
set("TabLineSel", { fg = "#FFFFFF", bg = colors.bg })
set("WinSeparator", { fg = colors.border, bg = "NONE" })
set("Folded", { fg = colors.fg_dim, bg = colors.bg_alt })
set("FoldColumn", { fg = colors.line_number, bg = "NONE" })
set("NonText", { fg = "#3B3B3B" })
set("Whitespace", { fg = "#3B3B3B" })
set("SpecialKey", { fg = "#3B3B3B" })
set("Directory", { fg = colors.type })
set("Title", { fg = colors.function_name, bold = true })


-- Diagnostics and diffs
set("DiagnosticError", { fg = colors.error })
set("DiagnosticWarn", { fg = colors.warning })
set("DiagnosticInfo", { fg = "#75BEFF" })
set("DiagnosticHint", { fg = colors.type })
set("DiagnosticUnderlineError", { undercurl = true, sp = colors.error })
set("DiagnosticUnderlineWarn", { undercurl = true, sp = colors.warning })
set("DiagnosticUnderlineInfo", { undercurl = true, sp = "#75BEFF" })
set("DiagnosticUnderlineHint", { undercurl = true, sp = colors.type })
set("DiffAdd", { bg = "#1E3A29" })
set("DiffChange", { bg = "#3A3520" })
set("DiffDelete", { bg = "#3F2222" })
set("DiffText", { bg = "#534B25" })
set("GitSignsAdd", { fg = colors.git_add })
set("GitSignsChange", { fg = colors.git_change })
set("GitSignsDelete", { fg = colors.git_delete })

-- Classic syntax groups
set("Comment", { fg = colors.comment })
set("Constant", { fg = colors.constant })
set("String", { fg = colors.string })
set("Character", { fg = colors.string })
set("Number", { fg = colors.number })
set("Boolean", { fg = colors.keyword })
set("Float", { fg = colors.number })
set("Identifier", { fg = colors.parameter })
set("Function", { fg = colors.function_name })
set("Statement", { fg = colors.keyword })
set("Conditional", { fg = colors.keyword })
set("Repeat", { fg = colors.keyword })
set("Label", { fg = colors.keyword })
set("Operator", { fg = colors.punctuation })
set("Keyword", { fg = colors.keyword })
set("Exception", { fg = colors.keyword })
set("PreProc", { fg = colors.keyword })
set("Include", { fg = colors.keyword })
set("Define", { fg = colors.keyword })
set("Macro", { fg = colors.keyword })
set("PreCondit", { fg = colors.keyword })
set("Type", { fg = colors.type })
set("StorageClass", { fg = colors.keyword })
set("Structure", { fg = colors.type })
set("Typedef", { fg = colors.type })
set("Special", { fg = colors.fg })
set("Delimiter", { fg = colors.punctuation })
set("Underlined", { fg = "#4DAAFC", underline = true })
set("Error", { fg = colors.error })
set("Todo", { fg = colors.bg, bg = colors.warning, bold = true })

-- Treesitter: Visual Studio C# semantics
link("@comment", "Comment")
link("@comment.documentation", "Comment")
link("@string", "String")
link("@string.escape", "String")
link("@string.regexp", "String")
link("@character", "Character")
link("@number", "Number")
link("@number.float", "Float")
link("@boolean", "Boolean")
link("@constant", "Constant")
link("@constant.builtin", "Constant")
link("@variable", "Identifier")
link("@variable.builtin", "Identifier")
set("@variable.parameter", { fg = colors.parameter })
set("@variable.member", { fg = colors.parameter })
set("@property", { fg = colors.parameter })
set("@field", { fg = colors.parameter })
link("@function", "Function")
link("@function.call", "Function")
link("@function.method", "Function")
link("@function.method.call", "Function")
link("@method", "Function")
link("@method.call", "Function")
link("@constructor", "Type")
link("@type", "Type")
link("@type.builtin", "Type")
link("@type.definition", "Type")
link("@attribute", "Type")
link("@keyword", "Keyword")
link("@keyword.function", "Keyword")
link("@keyword.operator", "Keyword")
link("@keyword.return", "Keyword")
link("@keyword.type", "Keyword")
link("@keyword.modifier", "Keyword")
link("@operator", "Operator")
link("@punctuation.bracket", "Delimiter")
link("@punctuation.delimiter", "Delimiter")
link("@punctuation.special", "Delimiter")
link("@module", "Type")
link("@namespace", "Type")


-- LSP semantic tokens used by Roslyn/OmniSharp.
for _, kind in ipairs({ "class", "struct", "interface", "enum", "delegate", "type", "typeParameter", "namespace" }) do
  link("@lsp.type." .. kind, "Type")
end
for _, kind in ipairs({ "function", "method" }) do
  link("@lsp.type." .. kind, "Function")
end
for _, kind in ipairs({ "variable", "parameter", "property", "field", "event" }) do
  link("@lsp.type." .. kind, "Identifier")
end
link("@lsp.type.enumMember", "Constant")
link("@lsp.type.keyword", "Keyword")
link("@lsp.type.string", "String")
link("@lsp.type.number", "Number")

-- XAML/XML: blue element names, light-blue attributes, orange values.
set("@tag", { fg = colors.keyword })
set("@tag.builtin", { fg = colors.keyword })
set("@tag.attribute", { fg = colors.parameter })
set("@tag.delimiter", { fg = colors.fg_dim })
set("xmlTag", { fg = colors.fg_dim })
set("xmlEndTag", { fg = colors.fg_dim })
set("xmlTagName", { fg = colors.keyword })
set("xmlAttrib", { fg = colors.parameter })
set("xmlEqual", { fg = colors.fg })
set("xmlString", { fg = colors.string })
set("xmlNamespace", { fg = colors.type })
set("xmlProcessingDelim", { fg = colors.fg_dim })

-- Common plugin surfaces
link("SnacksPickerBorder", "FloatBorder")
link("SnacksPickerTitle", "FloatTitle")
set("SnacksPickerMatch", { fg = colors.function_name, bold = true })
link("SnacksPickerDirectory", "Directory")
set("WhichKey", { fg = colors.keyword })
set("WhichKeyGroup", { fg = colors.type })
set("BlinkCmpLabelMatch", { fg = colors.function_name, bold = true })
link("BlinkCmpMenuBorder", "FloatBorder")
