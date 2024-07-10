return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = { theme = 'auto' },
      sections = {
        lualine_x = {
          function()
            return vim.fn['codeium#GetStatusString']()
          end,
        },
        lualine_y = {
          -- 'encoding',
          -- 'fileformat',
          'filetype',
        },
        lualine_z = {
          'progress',
          'location',
        },
      },
    }
  end,
}
