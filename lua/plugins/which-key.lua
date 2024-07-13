return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup {
      preset = 'classic',
      delay = 500,
      sort = { 'local', 'order', 'group', 'alphanum', 'mod', 'lower', 'icase' },
      icons = {
        rules = false,
        group = '',
      },
    }

    require('which-key').add {
      {
        { '<leader>s', group = '[S]earch' },
        { '<leader>l', group = '[L]SP' },
        { '<leader>g', group = '[G]it hunk' },
        { '<leader>gt', group = '[G]it [T]oggle' },
        { '<leader>S', group = '[S]ession' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>d', group = '[D]ebug' },
        { '<leader>v', group = '[V]irtual env' },
      },
    }
  end,
}
