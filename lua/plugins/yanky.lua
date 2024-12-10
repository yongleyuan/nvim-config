return {
  'gbprod/yanky.nvim',
  dependencies = {
    { 'kkharji/sqlite.lua' },
  },
  config = function()
    local mapping = require 'yanky.telescope.mapping'
    require('yanky').setup {
      picker = {
        telescope = {
          mappings = {
            i = {
              ['<c-k>'] = mapping.put 'p',
              ['<c-g>'] = mapping.put 'P',
            },
          },
        },
      },
      ring = {
        storage = 'sqlite',
        history_length = 100,
      },
      highlight = {
        on_put = false,
        on_yank = false,
        timer = 5000,
      },
    }
  end,
}
