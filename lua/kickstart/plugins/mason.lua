-- This file enables integration of Mason related plugins
-- including LSPs, DAPs, Linters, Formatters, etc.
--

-- Enable the following language servers
--  Add/remove any LSPs.
--  They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  vimls = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },

  stylelint_lsp = {},
  phpactor = {
    -- for details on the configuration of Phpactor
    -- see: https://phpactor.readthedocs.io/en/master/reference/configuration.html

    -- enables integrations with PHP-CS-fixer (formatter)
    ['language_server_php_cs_fixer.enabled'] = true,

    -- enable integration with Psalm (lsp/linter)
    --["language_server_psalm.enabled"] = true,

    -- enables integration with PHPStan (linter)
    ["language_server_phpstan.enabled"] = true,
    --["language_server_phpstan.level"],

    -- enables integration with PHPUnit (testing)
    --["phpunit.enabled"] = true,
  },
  --psalm = {},

  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
}

-- Configuration used on mason-plugins installation
-- see: https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim#configuration
local mason_config = {
  -- Check for updates, and update the tools if available.
  auto_update = false, -- Default: false

  -- Automatically install / update on startup.
  run_on_start = true, -- Default: true

  -- If run_on_start then delay (in ms) before the installation starts.
  --start_delay = 3000, -- Default: 0

  -- If run_on_start then delay (in hours) the attempts to install/update.
  --debounce_hours = 5, -- Default: nil

  -- Enable the next Mason tools
  --  They will automatically be installed.
  --  They should be the names Mason uses for each tool (:help Mason).
  ensure_installed = {
    -- LSP
    'vim-language-server', -- vimls
    'lua-language-server', -- lua_ls
    'stylelint-lsp',       -- stylelint_lsp
    'phpactor',            --'psalm', -- PHP


    -- DAP
    --'php-debug-adapter',


    -- Linters
    --'misspell',   -- checks english words text (! requires go)
    'editorconfig-checker',
    'textlint',   -- Text, Markdown
    'shellcheck', -- Bash
    --'vint',     -- Vim (! requires python)
    --'luacheck', -- Lua (! requires go)
    'stylelint', -- CSS, SCSS, Sass, LESS
    'eslint_d',  -- JavaScript, TypeScript
    'phpstan',   -- PHP (integrates with phpactor)
    --'phpcs',   -- PHP (integrates with phpcbf)

    -- linter multiple languages
    --◍ semgrep
    --◍ sonarlint-language-server


    -- Formatters
    --'shfmt', -- Shell, Bash, Mksh (! requires go)
    'stylua', -- Lua
    --              Markdown
    --              HTML, JSON, YAML, GraphQL
    --              CSS, SCSS, Sass, LESS
    --              JavaScript, TypeScript, Flow, JSX, Vue, Angular
    'prettierd',    -- The ⬆️⬆️⬆️⬆️ upper languages
    'php-cs-fixer', -- PHP (integrates with phpactor)
    --'phpcbf',     -- PHP (integrates with phpcs)
    --'pint',       -- PHP (independent)


    -- Examples

    -- you can pin a tool to a particular version
    --{ 'golangci-lint',        version = 'v1.47.0' },

    -- you can turn off/on auto_update per tool
    --{ 'bash-language-server', auto_update = true },

    -- Go
    --'gopls', 'staticcheck', 'revive', 'gofumpt', 'golines', 'gomodifytags', 'gotests',
    --'impl', 'json-to-struct',
  },
}

return {
  -- LSP integration
  'neovim/nvim-lspconfig',

  dependencies = {
    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',

    -- enables code completion from lsp's
    'hrsh7th/cmp-nvim-lsp',

    -- Manage installation of LSPs, Linters, Formatters, etc.
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('neodev').setup({})`
    { 'j-hui/fidget.nvim', opts = {} },
  },

  config = function()
    -- Setup neovim lua configuration
    require('neodev').setup()

    -- Setup mason so it can manage external tooling
    require('mason').setup()

    -- Ensure the Mason tools are installed
    -- The `:MasonToolsUpdate` or `:MasonToolsInstall` commands can be use
    require('mason-tool-installer').setup(mason_config)

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Diagnostic keymaps
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

    -- LSP settings.
    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(_, bufnr)
      local nmap = function(keys, desc, func)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
      end

      nmap('<leader>rn', '[R]e[n]ame', vim.lsp.buf.rename)
      nmap('<leader>ca', '[C]ode [A]ction', vim.lsp.buf.code_action)

      -- See `:help K` for why this keymap
      nmap('<leader>k', '[h]over Documentation', vim.lsp.buf.hover)
      nmap('<leader>K', '[H]over Signature Documentation', vim.lsp.buf.signature_help)

      nmap('gD', '[g]oto [D]eclaration', vim.lsp.buf.declaration)
      nmap('gd', '[g]oto [d]efinition', vim.lsp.buf.definition)
      nmap('gr', '[g]oto [r]eferences', require('telescope.builtin').lsp_references)
      nmap('gi', '[g]oto [i]mplementation', vim.lsp.buf.implementation)
      nmap('gt', '[g]oto [t]ype Definition', vim.lsp.buf.type_definition)
      nmap('<leader>ds', '[d]ocument [s]ymbols', require('telescope.builtin').lsp_document_symbols)
      nmap('<leader>ws', '[w]orkspace [s]ymbols', require('telescope.builtin').lsp_dynamic_workspace_symbols)

      -- Lesser used LSP functionality
      nmap('<leader>wa', '[w]orkspace [a]dd Folder', vim.lsp.buf.add_workspace_folder)
      nmap('<leader>wr', '[w]orkspace [r]emove Folder', vim.lsp.buf.remove_workspace_folder)
      nmap('<leader>wl', '[w]orkspace [l]ist Folders', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end)

      -- Create a command `:Format` local to the LSP buffer
      nmap('<C-f>', '[f]ormat', vim.lsp.buf.format)
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
    end

    mason_lspconfig.setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
        }
      end,
    }
  end,
}
