return {
  { 'GCBallesteros/jupytext.nvim', config = true },
  {
    'Vigemus/iron.nvim',
    config = function()
      local view = require 'iron.view'
      require('iron.core').setup {
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            sh = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = { 'zsh' },
            },
            python = {
              command = { 'python3' }, -- or { "ipython", "--no-autoindent" }
              format = require('iron.fts.common').bracketed_paste_python,
            },
          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = 'vsplit',
        },
        -- Iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        keymaps = {
          send_motion = '<C-S-j>',
          visual_send = '<C-S-j>',
          -- send_file = "<space>sf",
          -- send_line = "<space>sl",
          -- send_paragraph = "<space>sp",
          -- send_until_cursor = "<space>su",
          -- send_mark = "<space>sm",
          -- mark_motion = "<space>mc",
          -- mark_visual = "<space>mc",
          -- remove_mark = "<space>md",
          -- cr = "<space>s<cr>",
          -- interrupt = "<space>s<space>",
          -- exit = "<space>sq",
          -- clear = "<space>cl",
        },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
          italic = true,
        },
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      }

      -- Create my own commands
      vim.api.nvim_create_user_command('JupyterStart', function()
        require('iron.core').repl_for('python')
      end, {})
      vim.api.nvim_create_user_command('JupyterEnd', function()
        require('iron.core').close_repl('python')
      end, {})
    end,
  },
}
