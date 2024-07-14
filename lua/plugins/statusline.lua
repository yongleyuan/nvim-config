return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = { theme = 'auto' },
      sections = {
        lualine_x = {
          {
            function()
              return vim.fn['codeium#GetStatusString']()
            end,
            separator = '',
          },
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
          'filetype',
        },
        lualine_z = {
          {
            'progress',
            separator = '',
          },
          'location',
        },
      },
    }
  end,
}
