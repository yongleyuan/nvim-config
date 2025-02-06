return {
  'stevearc/conform.nvim',
  dependencies = {
    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  },
  event = { 'BufReadPre' },
  cmd = { 'ConformInfo' },
  opts = {
    notify_on_error = true,
    format_on_save = false,
    formatters_by_ft = {
      lua = { 'stylua' },
      json = { 'prettier' },
      markdown = { 'prettier' },
    },
  },
}
