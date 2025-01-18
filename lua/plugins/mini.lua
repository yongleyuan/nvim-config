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
    require('mini.bufremove').setup()
    require('mini.comment').setup()
    require('mini.cursorword').setup()
    require('mini.files').setup {
      mappings = {
        close = '<ESC>',
        go_in = 'L',
        go_in_plus = '',
        go_out = 'H',
        go_out_plus = '',
      },
    }
    require('mini.surround').setup()
  end,
}
