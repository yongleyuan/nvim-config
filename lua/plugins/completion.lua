return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets', {
    'saghen/blink.compat',
    version = '*',
    lazy = true,
    opts = {},
  } },
  version = '*',
  opts = {
    keymap = {
      preset = 'default',
      ['<C-\\>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<Tab>'] = {
        'snippet_forward',
        function() -- sidekick next edit suggestion
          return require('sidekick').nes_jump_or_apply()
        end,
        'fallback',
      },

    },
    cmdline = { completion = { menu = { auto_show = true } } },
    appearance = { use_nvim_cmp_as_default = true, nerd_font_variant = 'mono' },
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
    signature = { enabled = true },
  },
}
