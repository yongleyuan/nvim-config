return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'folke/neodev.nvim',       opts = {} },
    {
      'smjonas/inc-rename.nvim',
      config = function()
        require('inc_rename').setup({})
      end,
    },
    {
      'barreiroleo/ltex_extra.nvim',
      ft = { 'markdown', 'tex' },
      dependencies = { 'neovim/nvim-lspconfig' },
    },
    'saghen/blink.cmp',
  },
  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    local servers = {
      pyright = {
        root_dir = function(fname)
          return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1]) or vim.fs.dirname(fname)
        end,
        settings = {
          pyright = {
            disableOrganizeImports = true,
          },
          python = {
            venvPath = '~/miniconda3/envs/',
            analysis = {
              ignore = { '*' },
            },
          },
        },
        single_file_support = true,
      },
      ruff = {},
      clangd = {},
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            -- hammerspoon annotation support
            workspace = {
              library = {
                '$HOME/.hammerspoon/Spoons/EmmyLua.spoon/annotations',
                '$HOME/.wezterm/wezterm-types'
              },
            },
          },
        },
      },
      ltex = {
        on_attach = function(client, bufnr)
          require('ltex_extra').setup({
            load_langs = { 'en-US' },
            init_check = true,
            path = '$HOME/.local/share/nvim/.ltex',
            log_level = 'error',
          })
        end,
        settings = {
          ltex = {
            checkFrequency = 'save',
          },
        },
      },
      markdown_oxide = {
        on_attach = function(_, bufnr)
          local function check_codelens_support()
            local clients = vim.lsp.get_active_clients({ bufnr = 0 })
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
                vim.lsp.codelens.refresh({ bufnr = 0 })
              end
            end,
          })
          -- Trigger codelens refresh
          vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
        end,
      },
    }

    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'lua_ls',
      'ruff',
      'prettier',
      'markdown_oxide',
    })

    require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

    require('mason-lspconfig').setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    })
  end,
}
