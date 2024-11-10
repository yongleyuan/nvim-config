return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup {
      preset = 'modern',
      -- delay = 500,
      sort = { 'manual', 'local', 'order', 'group', 'alphanum', 'mod', 'lower', 'icase' },
      icons = {
        rules = false,
        group = '',
      },
      win = {
        no_overlap = false,
      },
    }

    local wk = require 'which-key'

    -- Standalone keybindings
    local cmp = require 'cmp'
    wk.add {
      {
        mode = 'n',
        { '<Esc>', '<CMD>nohlsearch<CR>', desc = 'Clear search higlight' },
        { '<left>', '<CMD>echo "Use h to move!!"<CR>', desc = '' },
        { '<right>', '<CMD>echo "Use l to move!!"<CR>', desc = '' },
        { '<up>', '<CMD>echo "Use k to move!!"<CR>', desc = '' },
        { '<down>', '<CMD>echo "Use j to move!!"<CR>', desc = '' },
        {
          '<C-h>',
          function()
            require('tmux').move_left()
          end,
          desc = 'Move focus to the left window',
        },
        {
          '<C-l>',
          function()
            require('tmux').move_right()
          end,
          desc = 'Move focus to the right window',
        },
        {
          '<C-j>',
          function()
            require('tmux').move_bottom()
          end,
          desc = 'Move focus to the upper window',
        },
        {
          '<C-k>',
          function()
            require('tmux').move_top()
          end,
          desc = 'Move focus to the lower window',
        },
        -- { '<C-k>', '<C-w><C-k>', desc = 'Move focus to the left window' },
        -- { '<C-l>', '<C-w><C-l>', desc = 'Move focus to the right window' },
        -- { '<C-j>', '<C-w><C-j>', desc = 'Move focus to the lower window' },
        -- { '<C-k>', '<C-w><C-k>', desc = 'Move focus to the upper window' },
        { '<A-i>', '<CMD>bnext<CR>', desc = 'Next buffer' },
        { '<A-o>', '<CMD>bprev<CR>', desc = 'Previous buffer' },
        { '<A-c>', '<CMD>Bdelete<CR>', desc = 'Delete buffer' },
        { '<A-x>', '<CMD>Bdelete!<CR>', desc = 'Delete buffer!' },
        {
          '<A-h>',
          function()
            require('tmux').resize_left()
          end,
          desc = 'Resize to the left',
        },
        {
          '<A-l>',
          function()
            require('tmux').resize_right()
          end,
          desc = 'Resize to the right',
        },
        {
          '<A-j>',
          function()
            require('tmux').resize_bottom()
          end,
          desc = 'Resize to the bottom',
        },
        {
          '<A-k>',
          function()
            require('tmux').resize_top()
          end,
          desc = 'Resize to the top',
        },
        -- { '<A-h>', '<CMD>vertical resize +5<CR>', desc = 'Make win bigger vertically' },
        -- { '<A-l>', '<CMD>vertical resize -5<CR>', desc = 'Make win smaller vertically' },
        -- { '<A-j>', '<CMD>horizontal resize +5<CR>', desc = 'Make win bigger horizontally' },
        -- { '<A-k>', '<CMD>horizontal resize -5<CR>', desc = 'Make win smaller horizontally' },
        { ',', '<CMD>Yazi<CR>', desc = 'Open Yazi current file' },
        { 'J', 'mzJ`z', desc = '' },
        { 'U', 'i<CR><ESC>', desc = 'Insert new line under cursor' },
        { '<CR>', 'o<ESC>', desc = '' },
        { '<S-CR>', 'O<ESC>', desc = '' },
        { '\\', '<CMD>AerialToggle<CR>', desc = 'Toggle Aerial' },
        { ';', '<Plug>(leap)', desc = 'Leap' },
        { 'vv', 'V', desc = 'Select line' },
        { 'V', 'v$', desc = 'Select until end of line' },
      },
      {
        mode = 'i',
        { 'jk', '<ESC>', desc = 'Exit insert mode' },
        { '<Tab>', '<S-Tab>', desc = 'Print true tabs' }, -- NOTE: Not sure why but works
        -- { '<C-v>', '<C-R>*', desc = 'Paste from clipboard' },
        {
          '<C-\\>',
          function()
            cmp.complete {}
          end,
          desc = 'Force cmp',
        },
        {
          '<C-p>',
          function()
            cmp.select_prev_item()
          end,
          desc = 'Selecte previous item',
        },
        {
          '<C-n>',
          function()
            cmp.select_next_item()
          end,
          desc = 'Selecte next item',
        },
        {
          '<C-y>',
          function()
            cmp.confirm { select = true }
          end,
          desc = 'Confirm cmp',
        },
        {
          '<C-x>',
          function()
            cmp.abort()
          end,
          desc = 'Abort cmp',
        },
        {
          '<C-h>',
          function()
            if cmp.visible_docs() then
              cmp.close_docs()
            else
              cmp.open_docs()
            end
          end,
          desc = 'Toggle cmp hover docs',
        },
        {
          '<C-i>',
          function()
            cmp.scroll_docs(-4)
          end,
          desc = 'Scroll cmp hover docs up',
        },
        {
          '<C-o>',
          function()
            cmp.scroll_docs(4)
          end,
          desc = 'Scroll cmp hover docs down',
        },
      },
      { '<C-\\>', '<C-\\><C-n>', desc = 'Exit terminal mode', mode = 't' },
      {
        mode = 'v',
        { 'J', ":m '>+1<CR>gv=gv", desc = 'Move selected text up' },
        { 'K', ":m '<-2<CR>gv=gv", desc = 'Move selected text down' },
      },
    }

    -- Standalone leader keybindings
    local tb = require 'telescope.builtin'
    wk.add {
      mode = 'v',
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      desc = '[F]ormat',
    }
    wk.add {
      mode = 'n',
      {
        '<leader><leader>',
        function()
          tb.current_buffer_fuzzy_find(
            -- require('telescope.themes').get_dropdown {
            --   winblend = 10,
            --   -- previewer = false,
            -- }
          )
        end,
        desc = 'Fuzzy find in current buffer',
      },
      {
        '<leader>,',
        -- '<CMD>Neotree buffers toggle<CR>',
        '<CMD>Yazi cwd<CR>',
        desc = 'Open Yazi in current working directory',
      },
      {
        '<leader>.',
        function()
          tb.buffers()
        end,
        desc = 'Fuzzy find buffers',
      },
      {
        '<leader>/',
        function()
          tb.find_files()
        end,
        desc = 'Fuzzy find file in dir',
      },
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        desc = '[F]ormat buffer',
      },
      {
        '<leader>u',
        function()
          require('undotree').toggle()
        end,
        desc = '[U]ndotree',
      },
      {
        '<leader>y',
        function()
          require('telescope').extensions.yank_history.yank_history {}
        end,
        desc = '[Y]ank history',
      },
    }

    -- Yanky
    wk.add {
      mode = { 'n', 'x' },
      { 'y', '<Plug>(YankyYank)', desc = 'Yank text' },
      { 'p', '<Plug>(YankyPutAfter)', desc = 'Put yanked text after cursor' },
      { 'P', '<Plug>(YankyPutBefore)', desc = 'Put yanked text before cursor' },
      { 'gp', '<Plug>(YankyGPutAfter)', desc = 'Put yanked text after selection' },
      { 'gP', '<Plug>(YankyGPutBefore)', desc = 'Put yanked text before selection' },
    }
    wk.add {
      mode = 'n',
      { '<C-p>', '<Plug>(YankyPreviousEntry)', desc = 'Select previous entry through yank history' },
      { '<C-n>', '<Plug>(YankyNextEntry)', desc = 'Select next entry through yank history' },
      { ']p', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Put indented after cursor (linewise)' },
      { '[p', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Put indented before cursor (linewise)' },
      { ']P', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Put indented after cursor (linewise)' },
      { '[P', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Put indented before cursor (linewise)' },
      { '>p', '<Plug>(YankyPutIndentAfterShiftRight)', desc = 'Put and indent right' },
      { '<p', '<Plug>(YankyPutIndentAfterShiftLeft)', desc = 'Put and indent left' },
      { '>P', '<Plug>(YankyPutIndentBeforeShiftRight)', desc = 'Put before and indent right' },
      { '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)', desc = 'Put before and indent left' },
      { '=p', '<Plug>(YankyPutAfterFilter)', desc = 'Put after applying a filter' },
      { '=P', '<Plug>(YankyPutBeforeFilter)', desc = 'Put before applying a filter' },
    }

    -- [H]arpoon
    local harpoon = require 'harpoon'
    wk.add {
      mode = 'n',
      { '<leader>a', group = 'H[A]rpoon' },
      {
        '<leader>a<leader>',
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = '[ ] Menu',
      },
      {
        '<leader>aa',
        function()
          harpoon:list():add()
        end,
        desc = '[A]dd mark',
      },
      {
        '<leader>ai',
        function()
          harpoon:list():select(1)
        end,
        desc = 'Harpoon mark 1',
      },
      {
        '<leader>ao',
        function()
          harpoon:list():select(2)
        end,
        desc = 'Harpoon mark 2',
      },
      {
        '<leader>ah',
        function()
          harpoon:list():select(3)
        end,
        desc = 'Harpoon mark 3',
      },
      {
        '<leader>aj',
        function()
          harpoon:list():select(4)
        end,
        desc = 'Harpoon mark 4',
      },
      {
        '<leader>ak',
        function()
          harpoon:list():select(5)
        end,
        desc = 'Harpoon mark 5',
      },
      {
        '<leader>al',
        function()
          harpoon:list():select(6)
        end,
        desc = 'Harpoon mark 6',
      },
    }

    -- [S]earch (Telescope)
    wk.add {
      mode = 'n',
      { '<leader>s', group = '[S]earch' },
      {
        '<leader>s<leader>',
        function()
          tb.resume()
        end,
        desc = '[ ] Resume',
      },
      {
        '<leader>sg',
        function()
          tb.live_grep {
            prompt_title = 'Live Grep in Current Directory',
          }
        end,
        desc = '[G]rep in current directory',
      },
      {
        '<leader>so',
        function()
          tb.live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Buffers',
          }
        end,
        desc = '[O]pen buffers grep',
      },
      {
        '<leader>sw',
        function()
          tb.grep_string()
        end,
        desc = '[W]ord under cursor',
      },
      {
        '<leader>sd',
        function()
          tb.diagnostics()
        end,
        desc = '[D]iagnostics',
      },
      {
        '<leader>sc',
        function()
          tb.command_history()
        end,
        desc = '[C]ommand history',
      },
      {
        '<leader>sm',
        '<CMD>Telescope noice<CR>',
        desc = '[M]essages',
      },
      {
        '<leader>sk',
        function()
          tb.keymaps()
        end,
        desc = '[K]eymaps',
      },
      {
        '<leader>sb',
        function()
          tb.buffers()
        end,
        desc = '[B]uffer fuzzy find',
      },
      {
        '<leader>sn',
        function()
          tb.find_files {
            cwd = vim.fn.stdpath 'config',
          }
        end,
        desc = '[N]eovim files',
      },
      {
        '<leader>sh',
        function()
          tb.help_tags()
        end,
        desc = '[H]elp',
      },
      {
        '<leader>st',
        ':TodoTelescope<CR>',
        desc = '[T]odos',
      },
    }

    -- Replace
    wk.add {
      mode = 'n',
      { '<leader>r', group = '[R]ename' },
      {
        '<leader>rn',
        ':IncRename ',
        desc = '[R]e[N]ame with IncRename',
      },
      {
        '<leader>rp',
        [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
        desc = '[R]ename [P]hrase under cursor',
      },
    }

    -- LSP autocommands (mianly [G]oto)
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local maplsp = function(keys, func, desc, mode)
          wk.add { keys, func, desc = desc .. ' (LSP)', mode = mode }
        end
        maplsp('gd', tb.lsp_definitions, '[G]oto [D]efinitions', 'n')
        maplsp('gr', tb.lsp_references, '[G]oto [R]eferences', 'n')
        maplsp('gi', tb.lsp_implementations, '[G]oto [I]mplementations', 'n')
        maplsp('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration', 'n')
        maplsp('gt', tb.lsp_type_definitions, '[G]oto [T]ype definitions', 'n')
        maplsp('gh', vim.lsp.buf.hover, '[G]oto [H]over documentation', 'n')
        maplsp('<leader>ss', tb.lsp_document_symbols, '[S]ymbols in current buffer', 'n')
        maplsp('<leader>sS', tb.lsp_dynamic_workspace_symbols, '[S]ymbols in directory', 'n')
        maplsp('<leader>rs', vim.lsp.buf.rename, '[R]ename [S]ymbol under cursor', 'n')
        maplsp('<C-a>', vim.lsp.buf.code_action, 'Code action', { 'n', 'x', 'i' })

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })
          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        -- if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
        --   map('<leader>lh', function()
        --     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        --   end, 'Toggle inlay [H]ints')
        -- end
      end,
    })

    -- [D]iagnostics
    wk.add {
      mode = 'n',
      -- { '[d', vim.diagnostic.jump { count = -1 }, desc = 'Go to previous [D]iagnostic message', mode = 'n' },
      -- { ']d', vim.diagnostic.jump { count = 1 }, desc = 'Go to previous [D]iagnostic message', mode = 'n' },
      { '[d', vim.diagnostic.goto_prev(), desc = 'Go to previous [D]iagnostic message', mode = 'n' },
      { ']d', vim.diagnostic.goto_next(), desc = 'Go to previous [D]iagnostic message', mode = 'n' },
      { '<leader>d', group = '[D]iagnostic' },
      { '<leader>de', vim.diagnostic.open_float, desc = 'Show [E]rror messages' },
      { '<leader>dq', vim.diagnostic.setloclist, desc = 'Open [Q]uickfix list' },
    }

    -- De[B]ug
    local dap = require 'dap'
    wk.add {
      mode = 'n',
      { '<leader>b', group = 'De[B]ug' },
      {
        '<leader>b<leader>',
        function()
          dap.toggle_breakpoint()
        end,
        desc = 'Debug: toggle breakpoint',
      },
      {
        '<F12>',
        function()
          dap.toggle_breakpoint()
        end,
        desc = 'Debug: toggle breakpoint',
      },
      {
        '<leader>b<CR>',
        function()
          require('dapui').toggle()
        end,
        desc = 'Debug: toggle dapui',
      },
      {
        '<leader>bb',
        function()
          dap.continue()
        end,
        desc = 'Debug: start/continue',
      },
      {
        '<F10>',
        function()
          require('dapui').toggle()
        end,
        desc = 'Debug: toggle dapui',
      },
      {
        '<leader>bi',
        function()
          dap.step_into()
        end,
        desc = 'Debug: Step into',
      },
      {
        '<F1>',
        function()
          dap.step_into()
        end,
        desc = 'Debug: Step into',
      },
      {
        '<leader>bs',
        function()
          dap.step_over()
        end,
        desc = 'Debug: Step over',
      },
      {
        '<F2>',
        function()
          dap.step_over()
        end,
        desc = 'Debug: Step over',
      },
      {
        '<leader>bo',
        function()
          dap.step_out()
        end,
        desc = 'Debug: Step out',
      },
      {
        '<F3>',
        function()
          dap.step_out()
        end,
        desc = 'Debug: Step out',
      },
      {
        '<leader>bS',
        function()
          dap.step_back()
        end,
        desc = 'Debug: Step back',
      },
      {
        '<F4>',
        function()
          dap.step_back()
        end,
        desc = 'Debug: Step back',
      },
      {
        '<F5>',
        function()
          dap.continue()
        end,
        desc = 'Debug: start/continue',
      },
      {
        '<leader>br',
        function()
          dap.restart()
        end,
        desc = 'Debug: restart',
      },
      {
        '<F6>',
        function()
          dap.restart()
        end,
        desc = 'Debug: restart',
      },
      {
        '<leader>bt',
        function()
          dap.terminate()
        end,
        desc = 'Debug: terminate',
      },
      {
        '<F7>',
        function()
          dap.terminate()
        end,
        desc = 'Debug: terminate',
      },
      {
        '<leader>bl',
        function()
          dap.list_breakpoints()
        end,
        desc = 'Debug: List breakpoints',
      },
      {
        '<leader>bc',
        function()
          dap.clear_breakpoints()
        end,
        desc = 'Debug: Clear breakpoints',
      },
    }

    -- [G]it
    local gs = require 'gitsigns'
    wk.add { '<leader>g', group = '[G]it', mode = { 'n', 'v' } }
    wk.add { '<leader>gt', group = '[T]oggle' }
    wk.add {
      '<leader>gs',
      function()
        tb.git_status()
      end,
      desc = '[G]it [S]tatus',
      mode = 'n',
    }
    gs.setup {
      on_attach = function(bufnr)
        local function gsmap(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          opts.desc = opts.desc .. ' (Git)'
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        gsmap('n', ']c', function()
          if vim.wo.diff then
            vim.CMD.normal { ']c', bang = true }
          else
            gs.nav_hunk 'next'
          end
        end, { desc = 'Jump to next [C]hange' })

        gsmap('n', '[c', function()
          if vim.wo.diff then
            vim.CMD.normal { '[c', bang = true }
          else
            gs.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous [C]hange' })

        -- Actions
        -- visual mode
        gsmap('v', '<leader>gs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[S]tage git hunk' })
        gsmap('v', '<leader>gr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[R]eset git hunk' })
        -- normal mode
        gsmap('n', '<leader>gs', gs.stage_hunk, { desc = '[S]tage hunk' })
        gsmap('n', '<leader>gr', gs.reset_hunk, { desc = '[R]eset hunk' })
        gsmap('n', '<leader>gS', gs.stage_buffer, { desc = '[S]tage buffer' })
        gsmap('n', '<leader>gR', gs.reset_buffer, { desc = '[R]eset buffer' })
        gsmap('n', '<leader>gu', gs.undo_stage_hunk, { desc = '[U]ndo stage hunk' })
        gsmap('n', '<leader>gp', gs.preview_hunk, { desc = '[P]review hunk' })
        gsmap('n', '<leader>gb', gs.blame_line, { desc = '[B]lame line' })
        gsmap('n', '<leader>gd', gs.diffthis, { desc = '[D]iff against index' })
        gsmap('n', '<leader>gD', function()
          gs.diffthis '@'
        end, { desc = '[D]iff against last commit' })
        -- Toggles
        gsmap('n', '<leader>gtb', gs.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        gsmap('n', '<leader>gtd', gs.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
      end,
    }

    -- Sessio[N]
    wk.add {
      mode = 'n',
      { '<leader>n', group = 'Sessio[N]' },
      {
        '<leader>n<leader>',
        '<CMD>Autosession search<CR>',
        desc = '[ ] Search sessions',
      },
      {
        '<leader>ns',
        '<CMD>SessionSave<CR>',
        desc = '[S]ave session',
      },
      {
        '<leader>nr',
        '<CMD>SessionRestore<CR>',
        desc = '[R]estore session',
      },
      {
        '<leader>nd',
        '<CMD>SessionDelete<CR>',
        desc = '[D]elete current session',
      },
      {
        '<leader>nD',
        '<CMD>Autosession delete<CR>',
        desc = '[D]elete session search',
      },
      {
        '<leader>np',
        '<CMD>SessionPurgeOrphaned<CR>',
        desc = '[P]urge orphaned session',
      },
    }

    -- [V]env
    wk.add {
      mode = 'n',
      { '<leader>v', group = '[V]irtual env' },
      {
        '<leader>vs',
        '<CMD>VenvSelect<CR>',
        desc = '[S]elect vitural env',
      },
      {
        '<leader>vd',
        function()
          require('venv-selector').deactivate()
        end,
        -- '<Plug>(deactivate)',
        desc = '[D]eactivate vitural env',
      },
      {
        '<leader>v<leader>',
        function()
          local venv = require('venv-selector').venv()
          if not venv then
            vim.notify 'No virtual env activated'
          else
            vim.notify('Activated virtual env: \n' .. require('venv-selector').venv(), vim.log.levels.INFO)
          end
        end,
        desc = '[ ] Current vitural env',
      },
    }

    -- [O]bsidian
    wk.add {
      mode = 'n',
      { '<leader>o', group = '[O]bsidian' },
      {
        '<leader>o<leader>',
        '<CMD>ObsidianSearch<CR>',
        desc = '[ ] Grep all notes',
      },
      {
        '<leader>o/',
        '<CMD>ObsidianQuickSwitch<CR>',
        desc = '[/] Note name picker',
      },
      {
        '<leader>ow',
        '<CMD>ObsidianWorkspace<CR>',
        desc = '[W]orkspace picker',
      },
      {
        '<leader>ot',
        '<CMD>ObsidianTags<CR>',
        desc = '[T]ags picker',
      },
      {
        '<leader>oi',
        '<CMD>ObsidianTemplate<CR>',
        desc = '[I]nsert template',
      },
      {
        '<leader>op',
        '<CMD>ObsidianPasteImg<CR>',
        desc = '[P]aste image',
      },
      {
        '<leader>on',
        '<CMD>ObsidianNew<CR>',
        desc = '[N]ew note',
      },
      {
        '<leader>or',
        '<CMD>ObsidianRename<CR>',
        desc = '[R]ename',
      },
      {
        '<leader>ol',
        group = '[L]inks',
      },
      {
        '<leader>ol<leader>',
        '<CMD>ObsidianLinks<CR>',
        desc = '[ ] picker',
      },
      {
        '<leader>olb',
        '<CMD>ObsidianBacklinks<CR>',
        desc = '[B]ack links',
      },
      {
        '<leader>oll',
        '<CMD>ObsidianLink<CR>',
        desc = '[L]ink',
      },
      {
        '<leader>oln',
        '<CMD>ObsidianLinkNew<CR>',
        desc = '[N]ew link',
      },
      {
        '<leader>od',
        group = '[D]aily notes',
      },
      {
        '<leader>od<leader>',
        '<CMD>ObsidianDailies<CR>',
        desc = '[ ] Daily note picker',
      },
      {
        '<leader>odd',
        '<CMD>ObsidianToday<CR>',
        desc = '[D]aily',
      },
      {
        '<leader>ody',
        '<CMD>ObsidianYesterday<CR>',
        desc = '[Y]esterday',
      },
      {
        '<leader>odt',
        '<CMD>ObsidianTomorrow<CR>',
        desc = '[T]omorrow',
      },
      {
        '<leader>o<CR>',
        '<CMD>ObsidianOpen<CR>',
        desc = 'Open app',
      },
    }

    -- AI

    -- Codeium
    vim.keymap.set('i', '<M-CR>', function()
      return vim.fn['codeium#Accept']()
    end, { expr = true, silent = true, desc = 'Codeium accept' })
    vim.keymap.set('i', '<M-k>', function()
      return vim.fn['codeium#CycleCompletions'](-1)
    end, { expr = true, silent = true, desc = 'Codeium cycle previous' })
    vim.keymap.set('i', '<M-j>', function()
      return vim.fn['codeium#CycleCompletions'](1)
    end, { expr = true, silent = true, desc = 'Codeium cycle next' })
    vim.keymap.set('i', '<M-x>', function()
      return vim.fn['codeium#Clear']()
    end, { expr = true, silent = true, desc = 'Codeium clear' })

    -- IronRepl (Jupyter Notebook)
    local iron = require 'iron.core'
    wk.add {
      cond = function()
        if vim.bo.filetype == 'python' then
          return true
        end
        return false
      end,
      {
        '<leader>j',
        group = '[J]upyter',
      },
      {
        '<leader>jj',
        '<CMD>IronRepl<CR>j',
        desc = 'Start with split',
        mode = 'n',
      },
      {
        '<leader>jh',
        '<CMD>IronReplHere<CR>j',
        desc = 'Start [H]ere',
        mode = 'n',
      },
      {
        '<leader>jr',
        '<CMD>IronRestart<CR>j',
        desc = '[R]estart',
        mode = 'n',
      },
      {
        '<leader>jx',
        function()
          iron.close_repl 'python'
        end,
        desc = '[X] Close',
        mode = 'n',
      },
      {
        '<leader>jd',
        '<CMD>IronHide<CR>',
        desc = 'Hi[D]e',
        mode = 'n',
      },
      {
        '<leader>jo',
        '<CMD>IronFocus<CR>',
        desc = 'F[O]cus',
        mode = 'n',
      },
      {
        '<leader>jl',
        function()
          iron.send_line()
        end,
        desc = 'Send [L]ine',
        mode = 'n',
      },
      {
        '<leader>js',
        function()
          iron.visual_send()
        end,
        desc = '[S]end',
        mode = 'v',
      },
      {
        '<leader>jc',
        function()
          iron.send_until_cursor()
        end,
        desc = 'Send until [C]ursor',
        mode = 'n',
      },
      {
        '<leader>jp',
        function()
          iron.send_paragraph()
        end,
        desc = 'Send [P]aragraph',
        mode = 'n',
      },
      {
        '<leader>jf',
        function()
          local filetype = vim.bo.filetype
          iron.send_file(filetype)
        end,
        desc = 'Send [F]ile',
        mode = 'n',
      },
    }
  end,
}
