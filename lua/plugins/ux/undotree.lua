-- Show a sidepanel with the buffer undo history
-- see https://github.com/mbbill/undotree
--

-- when undotree is opened set windows with
vim.api.nvim_create_autocmd({ 'BufAdd' }, {
	pattern = '*',
	callback = function()
		if vim.opt.filetype:get() == 'undotree' then
			vim.api.nvim_win_set_width(0, 40)
		end
	end
})

return {
	'mbbill/undotree',
	keys = {
		{ '<leader><F5>', function() vim.cmd.UndotreeToggle() end, mode = 'n' },
	},
}
