-- Keymappings for move lines/blocks of code UP and DOWN
-- see https://github.com/fedepujol/move.nvim
--

return {
	'fedepujol/move.nvim',
	config = function()
		require('move').setup {
			block = { enable = true, indent = true },
			line = { enable = true, indent = true },
			word = { enable = false },
			char = { enable = false },
		}


		local map = require('custom.nvim').group_map('Move: ', { noremap = true, silent = true })
		map('n', '<S-Up>', 'Line Up', ':MoveLine(-1)<CR>')
		map('n', '<S-Down>', 'Line Down', ':MoveLine(1)<CR>')
		map('v', '<S-Up>', 'Block Up', ':MoveBlock(-1)<CR>')
		map('v', '<S-Down>', 'Block Down', ':MoveBlock(1)<CR>')
	end,
}
