return {
  'folke/trouble.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    focus = true,
    modes = {
      symbols = {
        focus = true,
      },
    },
  },

  config = function(_, opts)
    local trouble = require 'trouble'
    trouble.setup(opts)

    local symbols = trouble.statusline {
      mode = 'lsp_document_symbols',
      groups = {},
      title = false,
      filter = { range = true },
      format = '{kind_icon}{symbol.name:Normal}',
      hl_group = 'lualine_x_normal',
    }
    require('lualine').setup {
      winbar = {
        lualine_x = {
          {
            symbols.get,
            cond = symbols.has,
          },
        },
      },
    }

    vim.api.nvim_create_autocmd('QuickFixCmdPost', {
      callback = function()
        vim.cmd [[ Trouble qflist open ]]
      end,
    })
  end,
}
