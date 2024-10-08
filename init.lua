--[[
=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
-- vim: ts=4 sts=4 sw=2 et
-- The line above this is called `modeline`. See `:help modeline`

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
	The goal is that you can read every line of code, top-to-bottom, and understand
	what your configuration is doing.

	Once you've done that, you should start exploring, configuring and tinkering to
	explore Neovim!

	If you don't know anything about Lua, I recommend taking some time to read through
	a guide. One possible example:
	- https://learnxinyminutes.com/docs/lua/

	And then you can explore or search through `:help lua-guide`

Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]
require('custom.base')
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<A>', '<Nop>', { silent = true })

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration
  'gioele/vim-autoswap',
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Keymaps/commands related plugins
  { 'folke/which-key.nvim',  opts = {} }, -- Show pending keybinds
  {
    'mrjones2014/legendary.nvim',        -- Handles all your keymaps/commands
    -- dependencies = { 'kkharji/sqlite.lua' } -- sqlite is needed only if frecency-sorting is desired
    priority = 10000,                    -- should be loded before other plugins
    enabled = false,
    lazy = false,
    --opts = { extensions = { lazy_nvim = true } },
    config = function()
      require('legendary').setup({ extensions = { lazy_nvim = true } })
    end
  },


  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- Highlight, edit, and navigate code
  require 'plugins.treesitter',
  -- LSP, Linters, Formatters, etc. Configuration
  require 'plugins.mason',
  -- Code Completion
  require 'plugins.completion',
  require 'plugins.colorizer',
  -- UI Plugins
  require 'plugins.telescope',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.luaplugins.indent-blankline`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
  { import = 'plugins.ui' },
  { import = 'plugins.ux' },
}, {})

--
-- [[ Basic Keymaps ]]
--

-- Helps
-- Regex search `:help \v` or see: https://vimdoc.sourceforge.net/htmldoc/pattern.html#/%5Cv
local map = require('lua.custom.nvim').group_map('LB: ', { noremap = true, silent = false })

-- Terminal interactions
map('n', '<M-Bslash>', 'Open a Terminal', '<CMD>90vsplit<CR><CMD>terminal<CR>')
vim.api.nvim_create_autocmd({ 'TermOpen', 'BufEnter' }, {
  pattern = '*',
  callback = function()
    if vim.opt.buftype:get() == 'terminal' then vim.cmd(':startinsert') end
  end
})

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<C-u>', ':undo<CR>', { noremap = true, silent = false })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

map('n', '<M-+>', 'Increment Panel Size Height', ':resize +2<CR>')
map('n', '<M-->', 'Decrement Panel Size Height', ':resize -2<CR>')
map('n', '<M-,>', 'Decrement Panel Size Width', ':vertical resize -2<CR>')
map('n', '<M-.>', 'Increment Panel Size Width', ':vertical resize +2<CR>')

map('n', '<M-Up>', 'LB: Move to Upper Panel', '<C-w>k')
map('n', '<M-Down>', 'LB: Move to Down Panel', '<C-w>j')
map('n', '<M-Left>', 'LB: Move to Left Panel', '<C-w>h')
map('n', '<M-Right>', 'LB: Move to Right Panel', '<C-w>l')

map('t', '<M-Up>', 'LB: Move to Upper Panel', '<C-\\><C-n><C-w>k')
map('t', '<M-Down>', 'LB: Move to Down Panel', '<C-\\><C-n><C-w>j')
map('t', '<M-Left>', 'LB: Move to Left Panel', '<C-\\><C-n><C-w>h')
map('t', '<M-Right>', 'LB: Move to Right Panel', '<C-\\><C-n><C-w>l')

map({ 'i', 'v' }, '<M-Up>', 'LB: Move to Upper Panel', '<ESC><C-w>k')
map({ 'i', 'v' }, '<M-Down>', 'LB: Move to Down Panel', '<ESC><C-w>j')
map({ 'i', 'v' }, '<M-Left>', 'LB: Move to Left Panel', '<ESC><C-w>h')
map({ 'i', 'v' }, '<M-Right>', 'LB: Move to Right Panel', '<ESC><C-w>l')
