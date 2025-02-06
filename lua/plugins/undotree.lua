return {
  'jiaoshijie/undotree',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    require('undotree').setup({
      position = 'bottom',
      keymaps = {
        ['<ESC><ESC>'] = 'quit', -- 'q' quit as well
      },
    })
  end,
}
