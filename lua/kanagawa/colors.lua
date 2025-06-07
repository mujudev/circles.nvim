---@class PaletteColors
local palette = {

	-- Bg Shades
	sumiInk0 = "#1d1619",
	sumiInk1 = "#231a1e",
	sumiInk2 = "#291e23",
	sumiInk3 = "#32252b",
	sumiInk4 = "#382930",
	sumiInk5 = "#413038",
	sumiInk6 = "#513e47", --fg

	-- Popup and Floats
	waveBlue1 = "#212f40",
	waveBlue2 = "#2f4b6b",

	-- Diff and Git
	winterGreen = "#36413b",
	winterYellow = "#7d633f",
	winterRed = "#bc5c7b",
	winterBlue = "#263240",
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
	fujiGray = "#414143",

	oniViolet = "#b6b7df",
	oniViolet2 = "#7573e1",
	crystalBlue = "#53c5e7",
	springViolet1 = "#d8c3ef",
	springViolet2 = "#cba1f7",
	springBlue = "#81c5d0",
	lightBlue = "#94dde4", -- unused yet
	waveAqua2 = "#599cbf", -- improve lightness: desaturated greenish Aqua

	-- waveAqua2  = "#68AD99",
	-- waveAqua4  = "#7AA880",
	-- waveAqua5  = "#6CAF95",
	-- waveAqua3  = "#68AD99",

	springGreen = "#addfb7",
	boatYellow1 = "#826927",
	boatYellow2 = "#d0ac49",
	carpYellow = "#fde78d",

	sakuraPink = "#efb3c2",
	waveRed = "#ff68bd",
	peachRed = "#ec4665",
	surimiOrange = "#d15222",
	katanaGray = "#485d6e",

	dragonBlack0 = "#0d0c0c",
	dragonBlack1 = "#12120f",
	dragonBlack2 = "#1D1C19",
	dragonBlack3 = "#181616",
	dragonBlack4 = "#282727",
	dragonBlack5 = "#393836",
	dragonBlack6 = "#625e5a",

	dragonWhite = "#c5c9c5",
	dragonGreen = "#87a987",
	dragonGreen2 = "#8a9a7b",
	dragonPink = "#a292a3",
	dragonOrange = "#b6927b",
	dragonOrange2 = "#b98d7b",
	dragonGray = "#a6a69c",
	dragonGray2 = "#9e9b93",
	dragonGray3 = "#7a8382",
	dragonBlue2 = "#8ba4b0",
	dragonViolet = "#8992a7",
	dragonRed = "#c4746e",
	dragonAqua = "#8ea4a2",
	dragonAsh = "#737c73",
	dragonTeal = "#949fb5",
	dragonYellow = "#c4b28a", --"#a99c8b",
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
