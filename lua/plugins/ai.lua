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
        copilot = function()
          return require('codecompanion.adapters').extend('copilot', {
            schema = { model = { default = 'gemini-2.5-pro' } },
          })
        end,
      },
      strategies = {
        chat = {
          keymaps = {
            debug = { modes = { n = '<leader>cd' }, description = 'Debug' },
            pin = { modes = { n = '<leader>cp' }, description = 'Pin Reference' },
            clear = { modes = { n = '<leader>cx' }, description = 'Clear Chat' },
            auto_tool_mode = { modes = { n = '<leader>ct' }, description = 'Toggle Auto Tool' },
            codeblock = { modes = { n = '<leader>ci' }, description = 'Insert Codeblock' },
            stop = { modes = { n = '<leader>cS' }, description = 'Stop Request' },
            change_adapter = { modes = { n = '<leader>cC' }, description = 'Change Adapter' },
            regenerate = { modes = { n = '<leader>cr' }, description = 'Regenerate' },
            watch = { modes = { n = '<leader>cw' }, description = 'Watch Buffer' },
            fold_code = { modes = { n = '<leader>cf' }, description = 'Fold Code' },
            yank_code = { modes = { n = '<leader>cy' }, description = 'Yank Code' },
            system_prompt = { modes = { n = '<leader>cs' }, description = 'Toggle System Prompt' },
          },
        },
        inline = {
          keymaps = {
            accept_change = { modes = { n = '<leader>cA' }, description = 'Accept the suggested change' },
            reject_change = { modes = { n = '<leader>cR' }, description = 'Reject the suggested change' },
          },
        },
      },
      -- have to set to default to use snacks.picker instead of mini.pick
      display = { action_palette = { provider = 'default' } },
    },
  },
}
