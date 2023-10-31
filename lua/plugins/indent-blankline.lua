--
-- Enables code indentation highlights
--

local colors = require('custom.colors')

local indent_with = function(opts)
  -- base configuration
  local settings = {
    show_trailing_blankline_indent = false, -- avoid <indentation-mark> on code-level

    use_treesitter_scope = true,
    --indent_level = 10, -- maximum indent level

    filetype_exclude = {
      "man",
      "vimwiki",
      "gitmessengerpopup",
      "diagnosticpopup",
      "lspinfo",
      "packer",
      "checkhealth",
      "TelescopePrompt",
      "TelescopeResults",
      "",
    },
  }

  local fg_colors = colors.add_fg('IndentForeground', opts.colors)
  local bg_colors = colors.add_bg('IndentBackground', opts.colors)

  -- For the next options an special <name>_list can be used
  -- to set diferent values for each indentation level, example:
  --char = '│',
  --char_list = {'|', '¦', '┆', '┊'},

  if (opts.mode == 'lines') then
    settings.char = '│' -- character for <indentation-mark> on lines
    settings.char_highlight_list = fg_colors

    settings.char_blankline = '¦' -- character for <indentation-mark> on empty lines
    settings.space_char_blankline = ' ' -- character for <space> on empty lines
  else
    settings.char = ''
    settings.space_char_highlight_list = bg_colors
  end

  --
  -- Special behaviors
  --

  if opts.show_eol then
    settings.show_end_of_line = true
    if opts.mode ~= 'lines' then
      settings.char_highlight_list = bg_colors
    end
  end

  if opts.show_context then
    settings.show_current_context = true
    --settings.show_current_context_start = true

    if opts.mode == 'lines' then
      settings.context_char = '█'
      settings.context_char_blankline = '█'
      settings.context_highlight_list = fg_colors
    else
      settings.context_char = '│'
      settings.context_char_blankline = '│'
      settings.context_highlight_list = fg_colors
    end
  end

  return settings
end

return {
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    colors.setup()

    vim.opt.list = true
    vim.opt.listchars:append 'space:⋅'
    vim.opt.listchars:append 'eol:↴'

    require('indent_blankline').setup(indent_with {
      mode = 'lines',
      colors = colors.rainbow,
      show_eol = true,
      show_context = true,
    })
  end,
}
