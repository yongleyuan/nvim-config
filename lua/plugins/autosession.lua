return {
  {
    'rmagatti/auto-session',
    dependencies = {
      'nvim-telescope/telescope.nvim', -- Only needed if you want to use sesssion lens
    },
    config = function()
      require('auto-session').setup {
        suppressed_dirs = {
          '~/',
          '~/Downloads/',
          '/',
          '~/Desktop/',
        },
        -- auto_save = false,
      }
    end,
  },
}
