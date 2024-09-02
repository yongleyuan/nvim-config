return { -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
  { 'HiPhish/rainbow-delimiters.nvim' },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
      -- 'echasnovski/mini.nvim',
    },
    config = function()
      require('render-markdown').setup {
        file_types = { 'markdown' },
        render_modes = { 'n', 'c', 'i', 'v' },

        -- Heading
        heading = {
          -- icons = { '󰬺 ', '󰬻 ', '󰬼 ', '󰬽 ', '󰬾 ', '󰬿 ' },
          icons = { '', '', '', '', '', '' },
          width = 'block',
          min_width = 80,
          -- -- background
          -- vim.cmd(string.format([[highlight Headline1Bg guifg=%s guibg=%s]], color_fg, color1_bg)),
          -- vim.cmd(string.format([[highlight Headline2Bg guifg=%s guibg=%s]], color_fg, color2_bg)),
          -- vim.cmd(string.format([[highlight Headline3Bg guifg=%s guibg=%s]], color_fg, color3_bg)),
          -- vim.cmd(string.format([[highlight Headline4Bg guifg=%s guibg=%s]], color_fg, color4_bg)),
          -- vim.cmd(string.format([[highlight Headline5Bg guifg=%s guibg=%s]], color_fg, color5_bg)),
          -- vim.cmd(string.format([[highlight Headline6Bg guifg=%s guibg=%s]], color_fg, color6_bg)),
          -- backgrounds = {
          --   'Headline1Bg',
          --   'Headline2Bg',
          --   'Headline3Bg',
          --   'Headline4Bg',
          --   'Headline5Bg',
          --   'Headline6Bg',
          -- },
          -- -- foreground
          -- vim.cmd(string.format([[highlight Headline1Fg cterm=bold gui=bold guifg=%s]], color_fg)),
          -- vim.cmd(string.format([[highlight Headline2Fg cterm=bold gui=bold guifg=%s]], color_fg)),
          -- vim.cmd(string.format([[highlight Headline3Fg cterm=bold gui=bold guifg=%s]], color_fg)),
          -- vim.cmd(string.format([[highlight Headline4Fg cterm=bold gui=bold guifg=%s]], color_fg)),
          -- vim.cmd(string.format([[highlight Headline5Fg cterm=bold gui=bold guifg=%s]], color_fg)),
          -- vim.cmd(string.format([[highlight Headline6Fg cterm=bold gui=bold guifg=%s]], color_fg)),
          -- foregrounds = {
          --   'Headline1Fg',
          --   'Headline2Fg',
          --   'Headline3Fg',
          --   'Headline4Fg',
          --   'Headline5Fg',
          --   'Headline6Fg',
          -- },
        },

        -- Block quote
        quote = { repeat_linebreak = true },
        win_options = {
          showbreak = { default = '', rendered = '  ' },
          breakindent = { default = false, rendered = true },
          breakindentopt = { default = '', rendered = '' },
        },
      }
    end,
  },
}
