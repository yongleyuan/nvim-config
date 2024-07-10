return {
  'linux-cultist/venv-selector.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'mfussenegger/nvim-dap',
    'mfussenegger/nvim-dap-python', --optional
    { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
  },
  lazy = false,
  branch = 'regexp', -- This is the regexp branch, use this for the new version
  config = function()
    require('venv-selector').setup {
      settings = {
        search = {
          anaconda_envs = {
            -- change path here to your anaconda envs
            command = 'fd python$ ~/miniconda3/bin --full-path --color never -E /proc',
          },
          anaconda_base = {
            -- change path here to your anaconda base
            command = 'fd bin/python$ ~/miniconda3/envs --full-path --color never -E /proc',
          },
        },
        options = {
          debug = true,
        },
      },
    }
  end,
  keys = {
    { '<leader>vs', '<cmd>VenvSelect<cr>', desc = '[S]elect venv' },
    { '<leader>vd', '<Plug>(deactivate)', desc = '[D]activate venv' },
  },
}
