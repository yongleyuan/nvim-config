local custom_extensions = {
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  winbar = {
    lualine_b = { 'filetype' },
  },
  inactive_winbar = {
    lualine_b = { 'filetype' },
  },
  filetypes = {
    'aerial',
    'neo-tree',
    'dapui_scopes',
    'dapui_breakpoints',
    'dapui_stacks',
    'dapui_watches',
    'dapui_repl',
    'dapui_console',
    'dashboard',
  },
}
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = { theme = 'auto' },
      sections = {
        lualine_c = {
          {
            function()
              return vim.fn['codeium#GetStatusString']()
            end,
            icon = '',
            -- separator = '',
          },
        },
        lualine_x = {
          -- { -- last search
          --   require('noice').api.status.search.get,
          --   cond = require('noice').api.status.search.has,
          --   color = { fg = '#84abf2' },
          --   icons_enabled = true,
          --   icon = '',
          --   separator = '󱋱',
          --   draw_empty = true,
          -- },
          { -- last entered command
            require('noice').api.status.command.get,
            -- cond = require('noice').api.status.command.has,
            -- color = { fg = '#ff9e64' },
            color = nil,
            icons_enabled = true,
            icon = {
              '󰅮',
              align = 'right',
              -- color = { fg = 'green' },
            },
          },
        },
        lualine_y = {
          -- 'encoding',
          -- 'fileformat',
          -- 'filetype',
          'progress',
        },
        lualine_z = {
          -- {
          --   'progress',
          --   separator = '',
          -- },
          'location',
        },
      },
      inactive_sections = {
        lualine_c = {},
      },
      winbar = {
        lualine_b = { 'filetype' },
        lualine_c = {
          {
            'filename',
            path = 3,
          },
        },
        lualine_x = { "aerial" },
      },
      inactive_winbar = {
        -- lualine_b = { 'filetype' },
        lualine_c = {
          {
            'filename',
            path = 0,
            shorting_target = 80,
          },
        },
      },
      -- tabline = {
      --   lualine_b = { 'filetype' },
      --   lualine_c = {
      --     {
      --       'filename',
      --       path = 3,
      --     },
      --   },
      --   lualine_x = { "aerial" },
      -- },

      -- Extensions
      extensions = {
        -- 'fugitive',
        custom_extensions,
        'nvim-dap-ui',
      },
    }
  end,
}
