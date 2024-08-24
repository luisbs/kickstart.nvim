-- Toggle code comments with mappings
-- see https://github.com/numToStr/Comment.nvim
--

return {
	'numToStr/Comment.nvim',
	config = function()
		require('Comment').setup {
			-- line like `//`, block like `/* */`
			toggler = { line = "<A-/>", block = "gbc" },
			-- advanced mappings like [y]ank and [d]elete commands
			-- `<A-/><A-/>10` to comment 10 lines
			-- `<A-/><A-/>$` to comment from cursor to end of line
			opleader = { line = "<A-/><A-/>", block = "gb" },
			mappings = { basic = true, extra = false }
		}
	end
}
