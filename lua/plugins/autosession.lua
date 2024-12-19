return {
  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        suppressed_dirs = {
          '~/',
          '~/Downloads/',
          '/',
          '~/Desktop/',
        },
        -- auto_save = false,
        session_lens = {
          load_on_setup = false
        }
      }
    end,
  },
}
