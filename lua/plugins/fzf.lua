return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local fzf_lua = require 'fzf-lua'
    fzf_lua.register_ui_select()
    fzf_lua.setup {
      'default-title',
      keymap = {
        builtin = {
          ['<C-u>'] = 'preview-page-up',
          ['<C-d>'] = 'preview-page-down',
        },
      },
    }
  end,
}
