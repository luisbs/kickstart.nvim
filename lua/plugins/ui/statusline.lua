-- Customization of the status line
-- see https://github.com/nvim-lualine/lualine.nvim
-- see `:help lualine`
--

local function bufnr()
	return 'bufnr:' .. vim.api.nvim_get_current_buf()
end

return {
	'nvim-lualine/lualine.nvim',
	config = function()
		require('lualine').setup {
			options = {
				theme = 'auto',
				icons_enabled = true,
				component_separators = { left = '', right = '' },
				section_separators = { left = '', right = '' },
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = { 'branch', 'diff', 'diagnostics' },
				lualine_c = { bufnr, 'filename' },
				lualine_x = { 'encoding', 'fileformat', 'filetype' },
				lualine_y = { 'progress' },
				lualine_z = { 'location' },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { bufnr, 'filename' },
				lualine_x = { 'encoding', 'fileformat', 'filetype' },
				lualine_y = {},
				lualine_z = {},
			},
		}
	end,
}
