return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup {
      n_lines = 50,
      search_method = 'cover_or_nearest',
      mappings = {
        goto_left = '(',
        goto_right = ')',
      },
    }
    require('mini.surround').setup()
    require('mini.bufremove').setup()
  end,
}
