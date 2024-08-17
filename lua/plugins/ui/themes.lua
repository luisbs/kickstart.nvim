-- This file sets the current theme an other visual styling settings
--

---@param variant 'dark'|'darker'|'cool'|'deep'|'warm'|'warmer'|'light'
---@return string
local odk = function(variant)
	return string.format([[
		require('onedark').setup { style = '%s' }
		require('onedark').load()
	]], variant)
end

return {
	'zaldih/themery.nvim',
	dependencies = {
		{ 'navarasu/onedark.nvim', },
		{ 'rose-pine/neovim',      name = 'rose-pine' },
		{ 'catppuccin/nvim',       name = 'catppuccin' },
		{ 'folke/tokyonight.nvim', },
		{ 'rebelot/kanagawa.nvim', },
		{ 'AlexvZyl/nordic.nvim', },
		-- { 'baliestri/aura-theme', },
	},
	config = function()
		-- onedark variations
		-- { colorscheme 'onedark'
		--setup_onedark('dark')

		require('custom.nvim').nmap('<A-t>', 'Themery: Change Theme', ':Themery<CR>')
		-- Minimal config
		require('themery').setup {
			livePreview = true, -- Apply theme while picking. Default to true.
			themes = {
				-- [[ List of installed colorschemes ]]
				-- { name = '「Dark」', colorscheme = '' },
				{ name = '「Dark」  🌒 Nordic',            colorscheme = 'nordic' },

				-- [[ rose-pine ]]
				{ name = '「Dark」  Rosé Pine Main',        colorscheme = 'rose-pine-main' },
				{ name = '「Dark」  Rosé Pine Moon',        colorscheme = 'rose-pine-moon' },
				{ name = '「Light」 Rosé Pine Dawn',        colorscheme = 'rose-pine-dawn' },

				-- [[ catppuccin ]]
				{ name = '「Dark」  Catppucin',              colorscheme = 'catppuccin' },
				{ name = '「Dark」  Catppucin Frappe',       colorscheme = 'catppuccin-frappe' },
				{ name = '「Dark」  Catppucin Macchiato',    colorscheme = 'catppuccin-macchiato' },
				{ name = '「Dark」  Catppucin Mocha',        colorscheme = 'catppuccin-mocha' },
				{ name = '「Light」 Catppucin Latte',        colorscheme = 'catppuccin-latte' },

				-- [[ tokyonight ]]
				{ name = '「Dark」  🏙 Tokyo Night',       colorscheme = 'tokyonight' },
				{ name = '「Dark」  🏙 Tokyo Night Moon',  colorscheme = 'tokyonight-moon' },
				{ name = '「Dark」  🏙 Tokyo Night Night', colorscheme = 'tokyonight-night' },
				{ name = '「Dark」  🏙 Tokyo Night Storm', colorscheme = 'tokyonight-storm' },
				{ name = '「Light」 🏙 Tokyo Night Day',   colorscheme = 'tokyonight-day' },

				-- [[ aura ]] -- fails with Themery selector
				-- { name = '「Dark」  Aura Dark',                colorscheme = 'aura-dark' },
				-- { name = '「Dark」  Aura Dark Soft Text',      colorscheme = 'aura-dark-soft-text' },
				-- { name = '「Dark」  Aura Soft Dark',           colorscheme = 'aura-soft-dark' },
				-- { name = '「Dark」  Aura Soft Dark Soft Text', colorscheme = 'aura-soft-dark-soft-text' },

				-- [[ onedark ]]
				{ name = '「Dark」  Onedark Dark',           colorscheme = 'onedark',             after = odk('dark') },
				{ name = '「Dark」  Onedark Cool',           colorscheme = 'onedark',             after = odk('cool') },
				{ name = '「Dark」  Onedark Deep',           colorscheme = 'onedark',             after = odk('deep') },
				{ name = '「Dark」  Onedark Warm',           colorscheme = 'onedark',             after = odk('warm') },
				{ name = '「Dark」  Onedark Warmer',         colorscheme = 'onedark',             after = odk('warmer') },
				{ name = '「Light」 Onedark Light',          colorscheme = 'onedark',             after = odk('light') },
			},
		}
	end,
}
