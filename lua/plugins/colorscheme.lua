return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  init = function()
    vim.cmd.colorscheme('catppuccin')
  end,
  config = function()
    require('catppuccin').setup({
      flavour = 'frappe',
      integrations = {
        aerial = true,
        leap = true,
        neotree = true,
        noice = true,
        mason = true,
        which_key = true,
      },
      -- transparent_background = true,
    })
  end,
}
