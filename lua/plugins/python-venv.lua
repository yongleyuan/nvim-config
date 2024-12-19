return {
  'linux-cultist/venv-selector.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'mfussenegger/nvim-dap',
    'mfussenegger/nvim-dap-python', --optional
    'nvim-lua/plenary.nvim',
  },
  lazy = false,
  branch = 'regexp', -- This is the regexp branch, use this for the new version
  config = function()
    require('venv-selector').setup {
      anaconda_base_path = '/Users/jack/miniconda3/condabin/conda',
      anaconda_envs_path = '/Users/jack/miniconda3/envs',
    }
  end,
}
