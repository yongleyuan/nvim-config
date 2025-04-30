return {
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
}
