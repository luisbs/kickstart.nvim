-- Mark and access files faster.
-- see https://github.com/ThePrimeagen/harpoon
-- see `:help harpoon`

local function toggle_telescope_menu(tpicker, tfinder, tconfig, harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	tpicker({}, {
		prompt_title = "Harpoon",
		finder = tfinder({ results = file_paths }),
		previewer = tconfig.file_previewer({}),
		sorter = tconfig.generic_sorter({}),
	}):find()
end

return {
	'ThePrimeagen/harpoon',
	branch = 'harpoon2',
	dependencies = {
		'nvim-lua/plenary.nvim',   -- utility library
		'nvim-telescope/telescope.nvim', -- UI library
	},
	config = function()
		local harpoon = require('harpoon')
		harpoon.setup({}) -- REQUIRED

		-- UI dependency
		local tconf = require('telescope.config').values
		local tpicker = require('telescope.pickers').new
		local tfinder = require('telescope.finders').new_table

		-- keymappings
		local nmap = require('custom.nvim').group_nmap('Harpoon: ', { noremap = true, silent = true })
		nmap('<A-m>', '[m]ark the current file', function() harpoon:list():add() end)
		-- nmap('<A-n>', 'u[n]mark the current file', function() harpoon:list():remove() end) -- [0378a6c] unexpected: clears list on some cases
		nmap('<A-c>', '[c]lear all marked files', function() harpoon:list():clear() end)
		-- nmap('<A-l>', '[l]ist marked files', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
		nmap('<A-l>', '[l]ist marked files',
			function() toggle_telescope_menu(tpicker, tfinder, tconf, harpoon:list()) end)

		-- Toggle previous & next buffers stored within Harpoon list
		-- nmap('<A-Left>', 'Navigates to prev file', function() harpoon:list():prev() end)
		-- nmap('<A-Right>', 'Navigates to next file', function() harpoon:list():next() end)

		-- Individual references for Harpoon files
		for i = 1, 9 do
			nmap('<A-' .. i .. '>', 'Navigates to file [' .. i .. ']', function() harpoon:list():select(i) end)
		end
	end
}
