local full_colorizer = {
  --names    = true,    -- "Name" codes, like Blue
  --RGB      = true,    -- #RGB hex codes, like #00F
  --RRGGBB   = true,    -- #RRGGBB hex codes, #0000FF
  RRGGBBAA = true,     -- #RRGGBBAA hex codes, #0000FFFF
  --rgb_fn   = false,   -- CSS rgb() and rgba() functions
  --hsl_fn   = false,   -- CSS hsl() and hsla() functions
  css      = true,     -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
  --css_fn   = false,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
  -- Available modes: foreground, background
  --mode     = 'background', -- Set the display mode.
}

return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup {
      '*',
      css = full_colorizer,
    }
  end,
}
