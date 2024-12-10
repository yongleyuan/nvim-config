return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    { 'BurntSushi/ripgrep' },
    { 'sharkdp/fd' },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        -- mappings = {
        --   i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        -- },
        layout_strategy = 'horizontal',
        sorting_strategy = 'ascending',
        layout_config = {
          prompt_position = 'top',
          horizontal = { preview_width = 0.55 },
        },
      },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
  end,
}
