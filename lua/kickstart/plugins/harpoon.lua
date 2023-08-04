-- This file enables the usage of harpoon.
--

return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim', -- utility functions
  },

  config = function()
    local ui = require 'harpoon.ui'
    local mark = require 'harpoon.mark'

    local nmap = function(keys, desc, func)
      vim.keymap.set('n', keys, func, { desc = 'Harpoon: ' .. desc })
    end

    nmap('<leader>m', '[m]ark the current file', mark.add_file)
    nmap('<leader>c', '[c]lear all marked files', mark.clear_all)
    nmap('<leader>l', '[l]ist marked files', ui.toggle_quick_menu)

    nmap('<A-Left>', 'Navigates to next file', ui.nav_prev)
    nmap('<A-Right>', 'Navigates to next file', ui.nav_next)

    -- add individual references for harpoon files
    for i = 1, 9 do
      nmap('<A-' .. i .. '>', 'Navigates to file [' .. i .. ']', function()
        ui.nav_file(i)
      end)
    end
  end
}
