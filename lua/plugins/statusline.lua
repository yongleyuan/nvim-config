return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      -- options = { theme = 'nord' },
      sections = {
        lualine_x = {
          -- 'encoding',
          -- 'fileformat',
          'filetype',
        },
      },
    }
  end,
}
