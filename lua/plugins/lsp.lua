return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'folke/neodev.nvim', opts = {} },
    {
      'smjonas/inc-rename.nvim',
      config = function()
        require('inc_rename').setup()
      end,
    },
    {
      'barreiroleo/ltex_extra.nvim',
      ft = { 'markdown', 'tex' },
      dependencies = { 'neovim/nvim-lspconfig' },
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
          },
        },
      },
      ltex = {
        on_attach = function(client, bufnr)
          require('ltex_extra').setup {
            load_langs = { 'en-US' }, -- table <string> : languages for witch dictionaries will be loaded
            init_check = true, -- boolean : whether to load dictionaries on startup
            path = '$HOME/.local/share/nvim/.ltex', -- string : path to store dictionaries. Relative path uses current working directory
            log_level = 'error', -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
            vim.notify("DEBUG")
          }
        end,
        settings = {
          ltex = {
            checkFrequency = 'save',
          },
        },
      },
    }

    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'lua_ls',
      'ruff',
      'prettier',
    })

    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
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

  end,
}
