return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufReadPre' },
  cmd = { 'ConformInfo' },
  opts = {
    notify_on_error = true,
    format_on_save = false,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- python = { 'black' }, -- NOTE: ruff already in LSP
      json = { 'prettier' },
      markdown = { 'prettier' },
    },
  },
}
