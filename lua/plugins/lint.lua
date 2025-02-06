return {

  { -- Linting
    'mfussenegger/nvim-lint',
    config = function()
      local lint = require('lint')
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        json = { 'jsonlint' },
      }

      -- Markdownlint config
      local markdownlint = require('lint').linters.markdownlint
      markdownlint.args = {
        '--disable',
        'MD007', -- unordered list indentation
        'MD012', -- multiple consecutive blank lines
        'MD013', -- line length
        'MD029', -- ordered list prefix
        'MD032', -- list surround with blank lines
        'MD018', -- no space after after hash
        'MD024', -- duplicated headings
        '--', -- required
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      local event = { 'BufEnter', 'BufReadPre', 'BufNewFile', 'InsertLeave' }
      vim.api.nvim_create_autocmd(event, {
        group = lint_augroup,
        callback = function()
          require('lint').try_lint()
        end,
      })

      -- Show linters for the current buffer's file type
      vim.api.nvim_create_user_command('LintInfo', function()
        local filetype = vim.bo.filetype
        local linters = require('lint').linters_by_ft[filetype]

        if linters then
          print('Linters for ' .. filetype .. ': ' .. table.concat(linters, ', '))
        else
          print('No linters configured for filetype: ' .. filetype)
        end
      end, {})
    end,
  },
}
