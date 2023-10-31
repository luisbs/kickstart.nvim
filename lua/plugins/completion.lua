-- This file enables Code Completion (lsp, snippets)
--

return {
  'hrsh7th/nvim-cmp',

  dependencies = {
    -- Visual customization of completion window.
    'onsails/lspkind.nvim',

    -- Snippets engine
    'L3MON4D3/LuaSnip',

    'hrsh7th/cmp-nvim-lsp', -- enables completion from lsp's
    'saadparwaiz1/cmp_luasnip' -- enables completion from snippets
  },

  config = function()
    local cmp = require 'cmp'         -- hrsh7th/nvim-cmp
    local luasnip = require 'luasnip' -- L3MON4D3/LuaSnip
    local lspkind = require 'lspkind' -- onsails/lspkind

    luasnip.config.setup {}

    -- see: https://github.com/hrsh7th/nvim-cmp#setup
    cmp.setup {
      sources = {
        { name = 'nvim_lsp' }, -- hrsh7th/cmp-nvim-lsp
        { name = 'luasnip' }, -- saadparwaiz1/cmp_luasnip
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      formatting = {
        format = lspkind.cmp_format {
          mode = 'symbol_text',
          maxwidth = 50,
          ellipsis_char = '...',
        },
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<C-q>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
    }
  end
}
