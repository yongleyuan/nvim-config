return {
  'gbprod/yanky.nvim',
  dependencies = {
    { 'kkharji/sqlite.lua' },
  },
  config = function()
    require('yanky').setup({
      ring = {
        storage = 'sqlite',
        history_length = 100,
      },
      highlight = {
        on_put = false,
        on_yank = false,
        timer = 5000,
      },
    })
  end,
}
