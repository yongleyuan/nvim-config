return {
  {
    'Exafunction/windsurf.nvim',
    event = 'BufEnter',
    config = function()
      require('codeium').setup({
        enable_chat = true,
        enable_cmp_source = false,
        virtual_text = {
          enabled = true,
          manual = false,
          key_bindings = {
            accept = '<C-A-y>',
            next = '<C-A-]>',
            prev = '<C-A-[>',
            clear = '<C-A-x>',
          },
        },
      })
    end,
  },
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'zbirenbaum/copilot.lua',
      'MeanderingProgrammer/render-markdown.nvim',
    },
    opts = {
      adapters = {
        http = {
          deepseek = function()
            return require('codecompanion.adapters').extend('deepseek', {
              schema = {
                model = { default = 'deepseek-reasoner' },
              },
            })
          end,
        },
      },
      strategies = {
        chat = { adapter = 'deepseek' },
        inline = { adapter = 'deepseek' },
        cmd = { adapter = 'deepseek' },
      },
      display = { action_palette = { provider = 'default' } }, -- have to set to default to use snacks.picker instead of mini.pick
    },
  },
  {
    'folke/sidekick.nvim',
    opts = {
      cli = { mux = { enabled = true, backend = 'tmux', split = { vertical = false } } },
    },
  },
}
