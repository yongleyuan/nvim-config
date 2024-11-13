return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  lazy = false,
  version = false,
  opts = {
    provider = 'copilot',
    auto_suggestions_provider = 'copilot',
    behaviour = {
      auto_suggestions = false,
    },
    mappings = {
      ask = '<A-a>a',
      edit = '<A-a>e',
      refresh = '<A-a>r',
      focus = '<A-a>f',
      suggestion = {
        accept = '<A-CR>',
        dismiss = '<A-x>',
      },
      sidebar = {
        apply_all = '<A-a>A',
        apply_cursor = '<A-a>c',
      },
    },
  },
  build = 'make',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    -- 'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
    {
      'zbirenbaum/copilot.lua',
      cmd = 'Copilot',
      config = function()
        require('copilot').setup()
      end,
    },
    -- {
    --   -- support for image pasting
    --   'HakonHarnes/img-clip.nvim',
    --   event = 'VeryLazy',
    --   opts = {
    --     -- recommended settings
    --     default = {
    --       embed_image_as_base64 = false,
    --       prompt_for_file_name = false,
    --       drag_and_drop = {
    --         insert_mode = true,
    --       },
    --       use_absolute_path = true,
    --     },
    --   },
    -- },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}
