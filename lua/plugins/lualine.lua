local custom_extensions = {
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  winbar = { lualine_b = { 'filetype' } },
  inactive_winbar = { lualine_b = { 'filetype' } },
  filetypes = { 'snacks_dashboard' },
}

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = { theme = 'auto' },
      sections = {
        lualine_c = {
          {
            function()
              return require('codeium.virtual_text').status_string()
            end,
            icon = '',
          },
        },
        lualine_x = {
          {
            require('noice').api.status.mode.get,
            cond = require('noice').api.status.mode.has,
            color = nil,
            icons_enabled = true,
          },
          {
            require('noice').api.status.command.get,
            color = nil,
            icons_enabled = true,
            icon = {
              '󰅮',
              align = 'right',
            },
          },
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = { lualine_c = {} },
      winbar = {
        lualine_b = { { 'filetype' } },
        lualine_c = { { 'filename', path = 3 } },
        lualine_x = { { 'aerial' } },
      },
      inactive_winbar = {
        lualine_c = {
          {
            'filename',
            path = 0,
            shorting_target = 80,
          },
        },
      },

      -- Extensions
      extensions = {
        custom_extensions,
        'aerial',
        'nvim-dap-ui',
        'fugitive',
        'oil',
        'lazy',
        'mason',
        'quickfix',
        'man',
      },
    })
  end,
}
