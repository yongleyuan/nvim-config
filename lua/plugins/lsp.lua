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
        -- NOTE: CANNOT be in ~, otherwise will fail to load Pyright
        -- root_dir = nil, -- this is single file mode, but cmp will not work for some reason
        root_dir = function(fname)
          local util = require 'lspconfig.util'
          return util.find_git_ancestor(fname) or util.path.dirname(fname) -- NOTE: This sets git root dir or file's dir as root dir.
        end,
        settings = {
          pyright = {
            disableOrganizeImports = true,
          },
          python = {
            venvPath = '/Users/jack/miniconda3/envs/',
            analysis = {
              ignore = { '*' },
            },
          },
        },
        single_file_support = true,
      },
      ruff = {},
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
      harper_ls = {
        settings = {
          ['harper-ls'] = {
            linters = {
              sentence_capitalization = false,
            },
            codeActions = {
              -- forceStable = true,
            },
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
      'harper_ls',
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

    -- Markdown-oxide integration
    local markdown_oxide_capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    markdown_oxide_capabilities.workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    }
    require('lspconfig').markdown_oxide.setup {
      capabilities = markdown_oxide_capabilities,
      on_attach = function(_, bufnr)
        local function check_codelens_support()
          local clients = vim.lsp.get_active_clients { bufnr = 0 }
          for _, c in ipairs(clients) do
            if c.server_capabilities.codeLensProvider then
              return true
            end
          end
          return false
        end
        vim.api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave', 'CursorHold', 'LspAttach', 'BufEnter' }, {
          buffer = bufnr,
          callback = function()
            if check_codelens_support() then
              vim.lsp.codelens.refresh { bufnr = 0 }
            end
          end,
        })
        -- Trigger codelens refresh
        vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
      end,
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
