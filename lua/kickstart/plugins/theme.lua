-- This file sets the current theme an other visual styling settings
--

---@param variant {'dark'|'darker'|'cool'|'deep'|'warm'|'warmer'|'light'}
local setup_onedark = function (variant)
  vim.cmd.colorscheme 'onedark'
  require('onedark').setup { style = variant }
end

return {
  'nvim-lualine/lualine.nvim',

  dependencies = {
    { 'navarasu/onedark.nvim',    priority = 1000 },
    { 'folke/tokyonight.nvim',    priority = 1001 },
    { 'catppuccin/nvim',          priority = 1002, name = 'catppuccin' },
    { 'daltonmenezes/aura-theme', priority = 1003 },
    { 'rebelot/kanagawa.nvim',    priority = 1004 },
    { 'rose-pine/neovim',         priority = 1005, name = 'rose-pine' },
    { 'AlexvZyl/nordic.nvim',     priority = 1007 },
  },

  config = function()
    -- onedark variations
    --vim.cmd.colorscheme 'onedark'
    --setup_onedark('dark')

    -- tokyonight variations
    --vim.cmd.colorscheme 'tokyonight'
    --vim.cmd.colorscheme 'tokyonight-storm' -- dark
    --vim.cmd.colorscheme 'tokyonight-night' -- dark
    --vim.cmd.colorscheme 'tokyonight-moon'  -- dark
    --vim.cmd.colorscheme 'tokyonight-day'   -- light

    -- catppuccin variations
    --vim.cmd.colorscheme 'catppuccin'
    --vim.cmd.colorscheme 'catppuccin-latte'     -- light
    --vim.cmd.colorscheme 'catppuccin-frappe'    -- dark
    --vim.cmd.colorscheme 'catppuccin-macchiato' -- dark
    --vim.cmd.colorscheme 'catppuccin-mocha'     -- dark

    -- aura
    --vim.cmd.colorscheme 'aura-dark'
    --vim.cmd.colorscheme 'aura-dark-soft-text'
    --vim.cmd.colorscheme 'aura-soft-dark'
    --vim.cmd.colorscheme 'aura-soft-dark-soft-text'

    -- kanagawa
    --vim.cmd.colorscheme 'kanagawa-wave'     -- dark-blue
    --vim.cmd.colorscheme 'kanagawa-dragon' -- dark
    --vim.cmd.colorscheme 'kanagawa-lotus'  -- solarized

    -- rose-pine
    --vim.cmd.colorscheme 'rose-pine'
    --vim.cmd.colorscheme 'rose-pine-moon'
    --vim.cmd.colorscheme 'rose-pine-dawn' -- light
    
    -- nordic
    vim.cmd.colorscheme 'nordic'

    -- See `:help lualine.txt`
    -- See: https://github.com/nvim-lualine/lualine.nvim#default-configuration
    require('lualine').setup {
      options = {
        theme = 'auto',
        icons_enabled = true,

        component_separators = '|',
        section_separators = '',

        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
      },
    }
  end,
}
