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
          icons = { '', '', '', '', '', '' },
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

        callout = {
          note = { raw = '' },
          tip = { raw = '' },
          important = { raw = '' },
          warning = { raw = '' },
          caution = { raw = '' },
          abstract = { raw = '' },
          summary = { raw = '' },
          tldr = { raw = '' },
          info = { raw = '' },
          todo = { raw = '' },
          hint = { raw = '' },
          success = { raw = '' },
          check = { raw = '' },
          done = { raw = '' },
          question = { raw = '' },
          help = { raw = '' },
          faq = { raw = '' },
          attention = { raw = '' },
          failure = { raw = '' },
          fail = { raw = '' },
          missing = { raw = '' },
          danger = { raw = '' },
          error = { raw = '' },
          bug = { raw = '' },
          example = { raw = '' },
          quote = { raw = '' },
          cite = { raw = '' },
        },
      }
    end,
  },
}
