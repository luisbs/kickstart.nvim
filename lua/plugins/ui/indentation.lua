-- Highlights indentation and shows non-printable characters
-- see https://github.com/lukas-reineke/indent-blankline.nvim
-- see https://gitlab.com/HiPhish/rainbow-delimiters.nvim
-- see https://unicode-explorer.com/search/
--

local tables = require('custom.tables')
local colors = require('custom.colors')

local setSpecialCharacters = function()
	vim.opt.list = true
	--vim.opt.listchars = --'tab:> ,trail:-,nbsp:+'
	tables.appendOpts(vim.opt.listchars, { 'eol:↴', 'tab:·•', 'space:·' }) -- 'multispace:'
	tables.appendOpts(vim.opt.listchars, { 'trail:•', 'nbsp:•', }) -- 'lead:┄'
	tables.appendOpts(vim.opt.listchars, { 'extends:≻', 'precedes:≺' })
	--
	-- u21b4:↴ u00b7:· u2022:•
	-- u2015:― u2594:▔
	-- u2500:─ u254c:╌ u2504:┄ u2508:┈ u2574:╴ u2578:╸
	-- u2501:━ u254d:╍ u2505:┅ u2509:┉ u2576:╶ u257a:╺
	-- u2502:│ u254e:╎ u2506:┆ u250a:┊ u2575:╵ u2579:╹
	-- u2503:┃ u254f:╏ u2507:┇ u250b:┋ u2577:╷ u257b:╻
	--		   u2550:═ u2551:║
	-- u251c:├ u2523:┣ u255e:╞ u255f:╟ u2560:╠
	-- u2524:┤ u252b:┫ u2561:╡ u2562:╢ u2563:╣
	-- u253c:┼ u254b:╋ u256a:╪ u256b:╫ u256c:╬
	--
	-- u2588:█ u2589:▉ u258a:▊ u258b:▋ u258c:▌ u258d:▍ u258e:▎ u258f:▏
	-- u2591:░ u2592:▒ u2593:▓         u2590:▐		   u2595:▕
end

return {
	'lukas-reineke/indent-blankline.nvim',
	main = 'ibl',
	dependencies = {
		'https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git', -- complementary behavior
	},
	config = function()
		local hl_grayscale = { 'CursorColumn', 'Whitespace' }
		local hl_rainbow = tables.keys('hl', colors.rainbow)
		local fg_rainbow = tables.keys('fg', colors.rainbow)
		local bg_rainbow = tables.keys('bg', colors.rainbow)

		--- reset colors every time the colorscheme changes
		local hooks = require('ibl.hooks')
		-- hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			colors.setColorsTogether('hl', colors.rainbow)
			colors.setColorsForeground('fg', colors.rainbow)
			colors.setColorsBackground('bg', colors.rainbow)
		end)

		setSpecialCharacters()
		-- require('rainbow-delimiters.setup').setup { highlight = bg_rainbow }
		require('ibl').setup {
			--- RainbowBlocks
			-- whitespace = { remove_blankline_trail = false, highlight = hl_rainbow }, -- SolidBlocks
			-- whitespace = { remove_blankline_trail = false, highlight = bg_rainbow }, -- HollowBlocks
			-- indent = { char = '▏', tab_char = '▏', highlight = nil },
			-- scope = { enabled = false },

			--- RainbowLines
			-- whitespace = { remove_blankline_trail = false, highlight = hl_grayscale }, -- GrayscaleBlocks
			whitespace = { remove_blankline_trail = false, highlight = fg_rainbow }, -- RainbowBlocks
			indent = { char = '▏', tab_char = '▏', highlight = fg_rainbow },
			scope = { enabled = true, char = '▌', highlight = fg_rainbow }, -- IblScope

			exclude = {
				filetypes = {
					'man',
					'help',
					'vimwiki',
					'checkhealth',

					'packer',
					'lspinfo',
					'diagnosticpopup',

					'gitcommit',
					'gitmessengerpopup',
					'TelescopePrompt',
					'TelescopeResults',
					'',
				},
			},
		}
	end,
}
