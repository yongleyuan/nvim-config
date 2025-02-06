return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup({
      n_lines = 50,
      search_method = 'cover_or_nearest',
      mappings = {
        goto_left = '(',
        goto_right = ')',
      },
    })
    require('mini.bufremove').setup()
    require('mini.comment').setup()
    require('mini.files').setup({
      mappings = {
        go_in = 'l',
        go_out = 'h',
        go_in_plus = '<CR>',
        go_out_plus = '-',
        show_help = '?',
      },
    })
    require('mini.pairs').setup()
    require('mini.pick').setup()
    require('mini.sessions').setup()
    require('mini.surround').setup()
  end,
}
