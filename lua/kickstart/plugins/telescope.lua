-- This file enables Fuzzy Finder (files, lsp, etc)
--

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    -- Utility functions
    'nvim-lua/plenary.nvim',

    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    }

    local nmap = function(keys, desc, func)
      vim.keymap.set('n', keys, func, { desc = desc })
    end

    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')
    -- Enable harpoon integration, if installed
    pcall(require('telescope').load_extension, 'harpoon')

    -- See `:help telescope.builtin`
    nmap('<leader><space>', '[ ] Find existing buffers', require('telescope.builtin').buffers)
    nmap('<leader>?', '[?] Find recently opened files', require('telescope.builtin').oldfiles)
    nmap('<leader>/', '[/] Fuzzily search in current buffer', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end)

    nmap('<leader>sf', '[s]earch [f]iles', require('telescope.builtin').find_files)
    nmap('<leader>sh', '[s]earch [h]elp', require('telescope.builtin').help_tags)
    nmap('<leader>sw', '[s]earch current [w]ord', require('telescope.builtin').grep_string)
    nmap('<leader>sg', '[s]earch by [g]rep', require('telescope.builtin').live_grep)
    nmap('<leader>sd', '[s]earch [d]iagnostics', require('telescope.builtin').diagnostics)
  end,
}
