return {
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter',
    config = function()
      vim.g.codeium_disable_bindings = 1
      vim.keymap.set('i', '<S-Space>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true, silent = true, desc = 'Codeium accept' })

      vim.keymap.set('i', '<C-\\>', function()
        return vim.fn['codeium#Complete']()
      end, { expr = true, silent = true, desc = 'Codeium complete' })

      vim.keymap.set('i', '<C-p>', function()
        return vim.fn['codeium#CycleCompletions'](-1)
      end, { expr = true, silent = true, desc = 'Codeium cycle previous' })

      vim.keymap.set('i', '<C-n>', function()
        return vim.fn['codeium#CycleCompletions'](1)
      end, { expr = true, silent = true, desc = 'Codeium cycle next' })

      vim.keymap.set('i', '<C-x>', function()
        return vim.fn['codeium#Clear']()
      end, { expr = true, silent = true, desc = 'Codeium clear' })
    end,
  },
  -- {
  --   'github/copilot.vim',
  -- },
  {
    'jackMort/ChatGPT.nvim',
    event = 'VeryLazy',
    config = function()
      require('chatgpt').setup {
        -- this config assumes you have OPENAI_API_KEY environment variable set
        openai_params = {
          model = 'gpt-4o',
        },
        openai_edit_params = {
          model = 'gpt-4o',
        },
      }
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
}
