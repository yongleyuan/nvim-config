return {
  'okuuva/auto-save.nvim',
  version = '^1.0.0',
  cmd = 'ASToggle',
  event = { 'InsertLeave', 'TextChanged' },
  opts = {
    enabled = true,
    trigger_events = {
      immediate_save = { 'BufLeave', 'FocusLost', 'InsertLeave', 'TextChanged' },
      -- defer_save = { 'InsertLeave', 'TextChanged' }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
      cancel_deferred_save = { 'InsertEnter' },
    },
    condition = function(buf)
      local fn = vim.fn
      local utils = require('auto-save.utils.data')
      if
        fn.getbufvar(buf, '&modifiable') == 1
        -- change here is adding harpoon file type to exclusion list 
        and utils.not_in(fn.getbufvar(buf, '&filetype'), { 'harpoon', 'oil' })
      then
        return true
      end
      return false
    end,
    write_all_buffers = false,
    noautocmd = false,
    lockmarks = false,
    debounce_delay = 2000,
    debug = false,
  },
  -- config = function()
  --   require('auto-save').setup {
  --     vim.api.nvim_create_autocmd('User', {
  --       pattern = 'AutoSaveWritePost',
  --       group = vim.api.nvim_create_augroup('autosave', {}),
  --       callback = function(opts)
  --         if opts.data.saved_buffer ~= nil then
  --           -- local fn = vim.api.nvim_buf_get_name(opts.data.saved_buffer)
  --           vim.notify('AutoSave: saved file at ' .. vim.fn.strftime '%H:%M:%S')
  --         end
  --       end,
  --     }),
  --   }
  -- end,
}
