return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP.
    -- { 'j-hui/fidget.nvim', opts = {} },

    -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    { 'folke/neodev.nvim', opts = {} },

    -- LSP renaming
    {
      'smjonas/inc-rename.nvim',
      config = function()
        require('inc_rename').setup()
      end,
    },
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local servers = {
      pyright = {
        -- settings = {
        --   python = {
        --     analysis = {
        --       diagnosticSeverityOverrides = {
        --         reportUnusedClass = 'warning',
        --         reportUnusedFunction = 'warning', -- TODO: This does not work!
        --         reportUnusedImport = 'warning',
        --         reportUnusedVariable = 'warning',
        --       },
        --     },
        --   },
        -- },
      },
      -- ruff = {},
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
    }

    -- Ensure the servers and tools above are installed
    --  To check the current status of installed tools and/or manually install
    --  other tools, you can run
    --    :Mason
    --
    --  You can press `g?` for help in this menu.
    require('mason').setup()

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'lua_ls',
      'markdownlint',
      'prettier',
    })

    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }

    -- Disable unused default LSP keymaps
    if vim.fn.mapcheck('gra', 'n') ~= '' then
      vim.keymap.del('n', 'gra')
    end
    if vim.fn.mapcheck('gra', 'x') ~= '' then
      vim.keymap.del('x', 'gra')
    end
    if vim.fn.mapcheck('grn', 'n') ~= '' then
      vim.keymap.del('n', 'grn')
    end
    if vim.fn.mapcheck('grr', 'n') ~= '' then
      vim.keymap.del('n', 'grr')
    end
    if vim.fn.mapcheck('K', 'n') ~= '' then
      vim.keymap.del('n', 'K')
    end
    if vim.fn.mapcheck('<C-S>', 'i') ~= '' then
      vim.keymap.del('i', '<C-S>')
    end
  end,
}
