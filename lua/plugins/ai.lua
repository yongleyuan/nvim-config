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
    'ravitemer/mcphub.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    cmd = 'MCPHub', -- lazy load
    build = 'npm install -g mcp-hub@latest',
    config = function()
      require('mcphub').setup()
    end,
  },
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'zbirenbaum/copilot.lua',
      'MeanderingProgrammer/render-markdown.nvim',
      'ravitemer/mcphub.nvim', -- see above for more mcphub config
    },
    opts = {
      http = {
        adapters = {
          gemini = function()
            return require('codecompanion.adapters').extend('gemini', {
              env = { api_key = 'GEMINI_API_KEY' },
              -- schema = {
              --   model = { default = 'gemini-2.5-flash-preview' },
              -- },
            })
          end,
        },
      },
      strategies = {
        chat = {
          adapter = 'copilot',
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
          adapter = 'copilot',
          keymaps = {
            accept_change = { modes = { n = '<leader>cA' }, description = 'Accept the suggested change' },
            reject_change = { modes = { n = '<leader>cR' }, description = 'Reject the suggested change' },
          },
        },
        cmd = { adapter = 'copilot' },
      },
      display = { action_palette = { provider = 'default' } }, -- have to set to default to use snacks.picker instead of mini.pick
      extensions = {
        mcphub = {
          callback = 'mcphub.extensions.codecompanion',
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
      },
    },
  },
  {
    'folke/sidekick.nvim',
    opts = {
      cli = { mux = { enabled = true, backend = 'tmux', split = { vertical = false } } },
    },
  },
}
