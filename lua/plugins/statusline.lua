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
            -- icons_enabled = true,
            -- icon = '',
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
    }
  end,
}
