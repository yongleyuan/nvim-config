return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
  opts = {
    skip_confirm_for_simple_edits = true,
    columns = {
      'permissions',
      'size',
      'mtime',
      'icon',
    },
    keymaps = {
      ['<leader>?'] = 'actions.show_help',
      ['<CR>'] = 'actions.select',
      ['<leader>V'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a vertical split' },
      ['<leader>S'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a horizontal split' },
      ['<leader>P'] = 'actions.preview',
      ['q'] = 'actions.close',
      ['<leader><ESC>'] = 'actions.close',
      ['<leader>C'] = 'actions.close',
      ['<leader>R'] = 'actions.refresh',
      ['-'] = 'actions.parent',
      ['_'] = 'actions.open_cwd',
      ['='] = 'actions.cd',
      ['+'] = { 'actions.cd', opts = { scope = 'tab' }, desc = ':tcd to the current oil directory', mode = 'n' },
      ['gs'] = 'actions.change_sort',
      ['gx'] = 'actions.open_external',
      ['<leader>H'] = 'actions.toggle_hidden',
      ['g\\'] = 'actions.toggle_trash',
    },
    use_default_keymaps = false,
  },
}
