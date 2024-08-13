return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  init = function()
    vim.cmd.colorscheme 'catppuccin-frappe'
  end,
  config = function()
    require('catppuccin').setup {
      integrations = {
        aerial = true,
        leap = true,
        neotree = true,
        noice = true,
      },
    }
  end,
}
