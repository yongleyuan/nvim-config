return {
  { 'GCBallesteros/jupytext.nvim', config = true },
  {
    'Vigemus/iron.nvim',
    config = function()
      require('iron.core').setup {
        config = {
          scratch_repl = true,
          repl_definition = {
            sh = {
              command = { 'zsh' },
            },
            python = {
              command = { 'python' },
              format = require('iron.fts.common').bracketed_paste_python,
            },
          },
          repl_open_cmd = 'split',
        },
        keymaps = {
          -- See which-key
        },
        highlight = { italic = false },
        ignore_blank_lines = true,
      }

      -- Create my own commands
      vim.api.nvim_create_user_command('JupyterStart', function()
        require('iron.core').repl_for 'python'
      end, {})
      vim.api.nvim_create_user_command('JupyterEnd', function()
        require('iron.core').close_repl 'python'
      end, {})
    end,
  },
}
