return {
  'MagicDuck/grug-far.nvim',
  config = function()
    require('grug-far').setup {
      -- Configurations here
      keymaps = {
        -- replace = { n = '<C-f>' }
      }
    }
  end,
}
