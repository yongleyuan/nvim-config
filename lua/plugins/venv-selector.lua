return {
  'linux-cultist/venv-selector.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'mfussenegger/nvim-dap',
    'mfussenegger/nvim-dap-python',
    'nvim-lua/plenary.nvim',
  },
  opts = {
    options = {
      picker = "snacks",
    }
  }
}
