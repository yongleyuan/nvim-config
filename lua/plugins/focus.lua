local ignore_filetypes = {
  'aerial',
  'neo-tree',
  'dapui_scopes',
  'dapui_breakpoints',
  'dapui_stacks',
  'dapui_watches',
  'dapui_repl',
  'dapui_console',
  'dashboard',
}
local ignore_buftypes = { 'nofile', 'prompt', 'popup' }
local augroup = vim.api.nvim_create_augroup('FocusDisable', { clear = true })

return {
  'nvim-focus/focus.nvim',
  version = '*',
  config = function()
    require('focus').setup {
      ui = {
        -- number = true,
        relativenumber = true,
        hybridnumber = true,
        absolutenumber_unfocussed = true,
      },

      vim.api.nvim_create_autocmd('WinEnter', {
        group = augroup,
        callback = function(_)
          if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
            vim.w.focus_disable = true
          else
            vim.w.focus_disable = false
          end
        end,
        desc = 'Disable focus autoresize for BufType',
      }),
      vim.api.nvim_create_autocmd('FileType', {
        group = augroup,
        callback = function(_)
          if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
            vim.b.focus_disable = true
          else
            vim.b.focus_disable = false
          end
        end,
        desc = 'Disable focus autoresize for FileType',
      }),
    }
  end,
}
