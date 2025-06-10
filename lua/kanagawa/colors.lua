---@class PaletteColors
local palette = {

	-- Bg Shades
	sumiInk0 = "#141315",
	sumiInk1 = "#19181b",
	sumiInk2 = "#211f23",
	sumiInk3 = "#2b292e",
	sumiInk4 = "#353338",
	sumiInk5 = "#403d43",
	sumiInk6 = "#4f4b53", --fg

	-- Popup and Floats
	waveBlue1 = "#212f40",
	waveBlue2 = "#2f4b6b",

	-- Diff and Git
	winterGreen = "#364438",
	winterYellow = "#a28f76",
	winterRed = "#5b2536",
	winterBlue = "#394b60",
	autumnGreen = "#8bb78d",
	autumnRed = "#ff404e",
	autumnYellow = "#b6951f",

	-- Diag
	samuraiRed = "#ce1435",
	roninYellow = "#f9c118",
	waveAqua1 = "#30786d",
	dragonBlue = "#81c5d0",

	-- Fg and Comments
	oldWhite = "#d1d6bf",
	fujiWhite = "#fcf5e9",
	fujiGray = "#4b4b4e",

	oniViolet = "#b6b7df",
	oniViolet2 = "#7573e1",
	crystalBlue = "#53c5e7",
	springViolet1 = "#d8c3ef",
	springViolet2 = "#cba1f7",
	springBlue = "#81c5d0",
	lightBlue = "#94dde4",
	waveAqua2 = "#599cbf",

	-- waveAqua2  = "#68AD99",
	-- waveAqua4  = "#7AA880",
	-- waveAqua5  = "#6CAF95",
	-- waveAqua3  = "#68AD99",

	springGreen = "#addfb7",
	boatYellow1 = "#685e40",
	boatYellow2 = "#b9a15f",
	carpYellow = "#dcd2ac",

	sakuraPink = "#efb3c2",
	waveRed = "#ff68bd",
	peachRed = "#ec4665",
	surimiOrange = "#d16622",
	katanaGray = "#485d6e",

	restoredBlack0 = "#0f0a0d",
	restoredBlack1 = "#110e15",
	restoredBlack2 = "#16121c",
	restoredBlack3 = "#1e1825",
	restoredBlack4 = "#2b2234",
	restoredBlack5 = "#352a41",
	restoredBlack6 = "#3c304a",

	restoredWhite = "#ddeae2",
	restoredGreen = "#8ab68a",
	restoredGreen2 = "#84ae83",
	restoredPink = "#d2b4da",
	restoredOrange = "#ca8c78",
	restoredOrange2 = "#ca5e37",
	restoredGray = "#868c98",
	restoredGray2 = "#6b7e8e",
	restoredGray3 = "#5b5d71",
	restoredBlue2 = "#4671f1",
	restoredViolet = "#b5b6e0",
	restoredRed = "#e3455f",
	restoredAqua = "#80c5d0",
	restoredAsh = "#545b39",
	restoredTeal = "#35716c",
	restoredYellow = "#fde98d", --"#a99c8b",
	-- "#8a9aa3",

	lotusInk1 = "#545464",
	lotusInk2 = "#43436c",
	lotusGray = "#dcd7ba",
	lotusGray2 = "#716e61",
	lotusGray3 = "#8a8980",
	lotusWhite0 = "#d5cea3",
	lotusWhite1 = "#dcd5ac",
	lotusWhite2 = "#e5ddb0",
	lotusWhite3 = "#f2ecbc",
	lotusWhite4 = "#e7dba0",
	lotusWhite5 = "#e4d794",
	lotusViolet1 = "#a09cac",
	lotusViolet2 = "#766b90",
	lotusViolet3 = "#c9cbd1",
	lotusViolet4 = "#624c83",
	lotusBlue1 = "#c7d7e0",
	lotusBlue2 = "#b5cbd2",
	lotusBlue3 = "#9fb5c9",
	lotusBlue4 = "#4d699b",
	lotusBlue5 = "#5d57a3",
	lotusGreen = "#6f894e",
	lotusGreen2 = "#6e915f",
	lotusGreen3 = "#b7d0ae",
	lotusPink = "#b35b79",
	lotusOrange = "#cc6d00",
	lotusOrange2 = "#e98a00",
	lotusYellow = "#77713f",
	lotusYellow2 = "#836f4a",
	lotusYellow3 = "#de9800",
	lotusYellow4 = "#f9d791",
	lotusRed = "#c84053",
	lotusRed2 = "#d7474b",
	lotusRed3 = "#e82424",
	lotusRed4 = "#d9a594",
	lotusAqua = "#597b75",
	lotusAqua2 = "#5e857a",
	lotusTeal1 = "#4e8ca2",
	lotusTeal2 = "#6693bf",
	lotusTeal3 = "#5a7785",
	lotusCyan = "#d7e3d8",
}

local M = {}
--- Generate colors table:
--- * opts:
---   - colors: Table of personalized colors and/or overrides of existing ones.
---     Defaults to KanagawaConfig.colors.
---   - theme: Use selected theme. Defaults to KanagawaConfig.theme
---     according to the value of 'background' option.
---@param opts? { colors?: table, theme?: string }
---@return { theme: ThemeColors, palette: PaletteColors}
function M.setup(opts)
	opts = opts or {}
	local override_colors = opts.colors or require("kanagawa").config.colors
	local theme = opts.theme or require("kanagawa")._CURRENT_THEME -- WARN: this fails if called before kanagawa.load()

	if not theme then
		error(
			"kanagawa.colors.setup(): Unable to infer `theme`. Either specify a theme or call this function after ':colorscheme kanagawa'"
		)
	end

	-- Add to and/or override palette_colors
	local updated_palette_colors = vim.tbl_extend("force", palette, override_colors.palette or {})

	-- Generate the theme according to the updated palette colors
	local theme_colors = require("kanagawa.themes")[theme](updated_palette_colors)

	-- Add to and/or override theme_colors
	local theme_overrides =
		vim.tbl_deep_extend("force", override_colors.theme["all"] or {}, override_colors.theme[theme] or {})
	local updated_theme_colors = vim.tbl_deep_extend("force", theme_colors, theme_overrides)
	-- return palette_colors AND theme_colors

	return {
		theme = updated_theme_colors,
		palette = updated_palette_colors,
	}
end

return M
