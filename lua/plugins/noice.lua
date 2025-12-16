return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      cmdline = {
        enabled = true,
        view = 'cmdline_popup',
        format = {
          cmdline = { pattern = '^:', icon = ':', lang = 'vim' },
          search_down = { kind = 'search', pattern = '^/', icon = '/', lang = 'regex' },
          search_up = { kind = 'search', pattern = '^%?', icon = '?', lang = 'regex' },
          filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
          lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
          help = { pattern = '^:%s*he?l?p?%s+', icon = '󰠩' },
          input = { view = 'cmdline_input', icon = '󰥻 ' }, -- Used by input()
        },
      },
      views = {
        cmdline_popup = {
          position = {
            row = '30%',
            col = '50%',
          },
        },
        notify = {
          -- replace = true,
        },
        mini = {
          position = {
            row = 1,
          },
        },
      },
      presets = {
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
    },
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = function()
      require('noice').setup()
      vim.keymap.set('i', '<C-c>', function()
        local nldocs = require('noice.lsp.docs')
        local message = nldocs.get('signature')
        nldocs.hide(message)
      end)
    end,
  },
}
