return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup {
      preset = 'classic',
      delay = 500,
      sort = { 'manual', 'local', 'order', 'group', 'alphanum', 'mod', 'lower', 'icase' },
      icons = {
        rules = false,
        group = '',
      },
    }

    require('which-key').add {
      {
        { '<leader>l', group = '[L]SP' },
        { '<leader>g', group = '[G]it hunk' },
        { '<leader>gt', group = '[G]it [T]oggle' },
        { '<leader>n', group = 'Sessio[N]' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>d', group = '[D]ebug' },
        { '<leader>v', group = '[V]irtual env' },
      },
      {
        mode = { 'v' },
        { '<leader>g', group = '[G]it' },
      },
    }

    local wk = require 'which-key'
    local tb = require 'telescope.builtin'

    -- Standablone leader shotcuts
    wk.add {
      {
        '<leader><leader>',
        function()
          tb.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            -- previewer = false,
          })
        end,
        desc = 'Fuzzy find [ ] in current buffer',
        mode = 'n',
      },
      {
        '<leader>/',
        function()
          tb.find_files()
        end,
        desc = 'Fuzzy find file [/] in dir',
        mode = 'n',
      },
      {
        '<leader>.',
        function()
          tb.oldfiles()
        end,
        desc = 'Fuzzy find file [.] recent files ',
        mode = 'n',
      },
      { -- Toggle aerial windows
        '<leader>a',
        '<CMD>AerialToggle<CR>',
        desc = '[A]erial',
        mode = 'n',
      },
      {
        '<leader>p',
        function()
          require('telescope').extensions.yank_history.yank_history {}
        end,
        desc = '[P]aste yank history',
        mode = 'n',
      },
      {
        '<leader>u',
        function()
          require('undotree').toggle()
        end,
        desc = '[U]ndotree',
        mode = 'n',
      },
    }

    -- Search
    wk.add {
      { '<leader>s', group = '[S]earch' },
      {
        '<leader>sg',
        function()
          tb.live_grep {
            prompt_title = 'Live Grep in Current Directory',
          }
        end,
        desc = '[G]rep in current directory',
        mode = 'n',
      },
      {
        '<leader>so',
        function()
          tb.live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Buffers',
          }
        end,
        desc = 'Grep in [O]pen buffers',
        mode = 'n',
      },
      {
        '<leader>sk',
        function()
          tb.keymaps()
        end,
        desc = '[K]eymaps',
        mode = 'n',
      },
      {
        '<leader>sw',
        function()
          tb.grep_string()
        end,
        desc = '[W]ord under cursor',
        mode = 'n',
      },
      {
        '<leader>sd',
        function()
          tb.diagnostics()
        end,
        desc = '[D]iagnostics',
        mode = 'n',
      },
      {
        '<leader>sr',
        function()
          tb.resume()
        end,
        desc = '[R]esume',
        mode = 'n',
      },
      {
        '<leader>sc',
        function()
          tb.command_history()
        end,
        desc = '[C]ommand history',
        mode = 'n',
      },
      {
        '<leader>sb',
        function()
          tb.buffers()
        end,
        desc = '[B]uffers',
        mode = 'n',
      },
      {
        '<leader>sh',
        function()
          tb.help_tags()
        end,
        desc = '[H]elp',
        mode = 'n',
      },
      {
        '<leader>sn',
        function ()
          tb.find_files {
            cwd = vim.fn.stdpath 'config'
          }
        end,
        desc = '[N]eovim files',
        mode = 'n',
      }
    }
  end,
}
