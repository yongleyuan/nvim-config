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
      strategies = {
        inline = {
          keymaps = {
            accept_change = { modes = { n = '<leader>ca' }, description = 'Accept the suggested change' },
            reject_change = { modes = { n = '<leader>cr' }, description = 'Reject the suggested change' },
          },
        },
      },
    },
  },
}
