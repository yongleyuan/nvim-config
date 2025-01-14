return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'vim', 'vimdoc' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
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
      -- Highlight
      vim.cmd [[ highligh @markup.quote guifg=#fab4da cterm=italic gui=italic ]]
      vim.cmd [[ highlight MarkdownTag guifg=#9adbaa cterm=italic gui=italic ]]
      vim.api.nvim_create_autocmd('BufWinEnter', {
        desc = 'Highlight markdown tags',
        group = vim.api.nvim_create_augroup('FormatMarkdownTag', { clear = true }),
        callback = function(opts)
          if vim.bo[opts.buf].filetype == 'markdown' then
            vim.cmd [[ match MarkdownTag "^#\w\+\S*\|\s\+#\w\+\S*" ]]
          else
            vim.cmd [[ match none ]]
          end
        end,
      })

      require('render-markdown').setup {
        file_types = { 'markdown' },
        render_modes = { 'n', 'c', 'i', 'v' },

        -- Heading
        heading = {
          enabled = true,
          -- icons = { '󰬺 ', '󰬻 ', '󰬼 ', '󰬽 ', '󰬾 ', '󰬿 ' },
          icons = { ' ', ' ', ' ', ' ', ' ', ' ' },
          position = 'inline',
          backgrounds = { '', '', '', '', '', '' },
        },

        -- Block quote
        quote = { repeat_linebreak = true },
        win_options = {
          showbreak = { default = '', rendered = '  ' },
          breakindent = { default = false, rendered = true },
          breakindentopt = { default = '', rendered = '' },
        },

        -- List bullets
        bullet = {
          enabled = true,
          icons = { '󰧟', '', '', '', '' },
        },

        -- Indentation
        indent = {
          enabled = true,
        },

        -- Table
        pipe_table = { alignment_indicator = '󰮸' },
      }
    end,
  },
}
