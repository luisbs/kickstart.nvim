--
-- Custom colors used on the configuration files
--

return {
  rainbow = { '#E06C75', '#E5C07B', '#98C379', '#56B6C2', '#61AFEF', '#C678DD' },
  setup = function()
    vim.opt.termguicolors = true
    --vim.cmd [[highlight IndentDark  guifg=#1F1F1F gui=nocombine]]
    --vim.cmd [[highlight IndentLight guifg=#1A1A1A gui=nocombine]]
  end,

  -- utility functions
  add_fg = function(prefix, colors)
    local names = {}
    for index, color in pairs(colors) do
      names[index] = prefix .. index
      vim.cmd(string.format('highlight %s guifg=%s gui=nocombine', names[index], color))
    end
    return names
  end,
  add_bg = function(prefix, colors)
    local names = {}
    for index, color in pairs(colors) do
      names[index] = prefix .. index
      vim.cmd(string.format('highlight %s guibg=%s gui=nocombine', names[index], color))
    end
    return names
  end,
}
