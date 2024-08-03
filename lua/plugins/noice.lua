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
      -- NOTE: Using mini with nvim-notify disabled
      --
      -- messages = { enabled = false },
      -- popupmenu = { enabled = false },
      notify = {
        replace = true,
        merge = true,
      },
      -- lsp = {
      --   progress = { enabled = false},
      --   hover = { enabed = false },
      --   signature = { enabled = false },
      --   message = { enabled = false },
      -- }
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
        -- bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- {
      --   'rcarriga/nvim-notify',
      --   opts = {
      --     stages = 'fade',
      --     render = 'compact',
      --     -- top_down = false,
      --   },
      -- },
    },
  },
}
