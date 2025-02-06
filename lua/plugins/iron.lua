return {
  { 'GCBallesteros/jupytext.nvim', config = true },
  {
    'Vigemus/iron.nvim',
    config = function()
      require('iron.core').setup({
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
        highlight = { italic = false },
        ignore_blank_lines = true,
      })
    end,
  },
}
