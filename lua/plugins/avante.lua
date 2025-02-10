return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  lazy = true,
  version = false,
  opts = {
    provider = 'copilot',
    mappings = {
      ask = '<C-A-a>a',
      edit = '<C-A-a>e',
      refresh = '<C-A-a>r',
      focus = '<C-A-a>f',
      sidebar = {
        apply_all = '<C-A-a>A',
        apply_cursor = '<C-A-a>c',
      },
    },
  },
  build = 'make',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
    'MeanderingProgrammer/render-markdown.nvim',
    {
      'zbirenbaum/copilot.lua',
      cmd = 'Copilot',
      config = function()
        require('copilot').setup({
          panel = { enabled = false },
          suggestion = { enabled = false },
        })
      end,
    },
  },
}
