--[[
=====================================================================
===== --------------------- Editor Settings ------------------- =====
===== See `:help vim.o`                                         =====
=====================================================================
--]]

--
-- [[ Enviroment Options ]]
--

vim.o.encoding        = "utf-8" -- Just in case

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors   = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard       = 'unnamedplus'

-- Enable mouse mode
vim.o.mouse           = 'a'

-- Save undo history
vim.o.undofile        = true

-- Decrease update time
vim.o.updatetime      = 250
vim.o.timeoutlen      = 300
vim.o.timeout         = true

-- Set completeopt to have a better completion experience
--vim.o.completeopt     = 'menuone,noselect'
vim.o.completeopt     = 'menu,menuone,noselect,noinsert'

-- Enable break indent
vim.o.breakindent     = true

--
-- [[ Editor Options ]]
--

-- Make line numbers default
vim.wo.number         = true
vim.wo.relativenumber = true

-- Highlight on search
vim.o.hlsearch        = false
vim.o.showmatch       = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase      = true
vim.o.smartcase       = true

-- New panel splits should open on the right or below
vim.opt.splitright    = true
vim.opt.splitbelow    = true

vim.opt.tabstop       = 4     -- Tab size of 4 spaces
vim.opt.softtabstop   = 4     -- On insert use 4 spaces for tab
--vim.opt.shiftwidth    = 0     -- Number of spaces to use for each step of (auto)indent
--vim.opt.expandtab     = true  -- Use appropriate number of spaces (no so good for PHP but we can fix this in ft)

--vim.opt.wrap          = false -- Wrapping sucks (except on markdown)
--vim.opt.swapfile      = false -- Do not leave any backup files

--vim.opt.cursorline    = true -- Highlight the current cursor line (Can slow the UI)
vim.opt.signcolumn    = "yes" -- Always show the signcolumn, otherwise it would shift the text
--vim.opt.hidden        = true  -- Allow multple buffers

--vim.opt.shortmess:append("c") -- Don't pass messages to |ins-completion-menu|.

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
