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
        { '<C-h>', '<C-w><C-h>', desc = 'Move focus to the left window' },
        { '<C-l>', '<C-w><C-l>', desc = 'Move focus to the right window' },
        { '<C-j>', '<C-w><C-j>', desc = 'Move focus to the lower window' },
        { '<C-k>', '<C-w><C-k>', desc = 'Move focus to the upper window' },
        { '<A-j>', '<CMD>BufferPrevious<CR>', desc = '' },
        { '<A-k>', '<CMD>BufferNext<CR>', desc = '' },
        { '<A-h>', '<CMD>BufferMovePrevious<CR>', desc = '' },
        { '<A-l>', '<CMD>BufferMoveNext<CR>', desc = '' },
        { '<A-1>', '<CMD>BufferGoto 1<CR>', desc = '' },
        { '<A-2>', '<CMD>BufferGoto 2<CR>', desc = '' },
        { '<A-3>', '<CMD>BufferGoto 3<CR>', desc = '' },
        { '<A-4>', '<CMD>BufferGoto 4<CR>', desc = '' },
        { '<A-5>', '<CMD>BufferGoto 5<CR>', desc = '' },
        { '<A-6>', '<CMD>BufferGoto 6<CR>', desc = '' },
        { '<A-7>', '<CMD>BufferGoto 7<CR>', desc = '' },
        { '<A-8>', '<CMD>BufferGoto 8<CR>', desc = '' },
        { '<A-9>', '<CMD>BufferGoto 9<CR>', desc = '' },
        { '<A-0>', '<CMD>BufferGoto 0<CR>', desc = '' },
        { '<A-p>', '<CMD>BufferPick<CR>', desc = '' },
        { '<A-c>', '<CMD>BufferDelete<CR>', desc = '' },
        { '<A-x>', '<CMD>BufferDelete!<CR>', desc = '' },
        { 'J', 'mzJ`z', desc = '' },
        { '<CR>', 'o<ESC>', desc = '' },
        { '<S-CR>', 'O<ESC>', desc = '' },
        { 'cp', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc = '[C]hange [P]hrase under cursor' },
        { '\\', '<CMD>Neotree toggle<CR>', desc = 'Toggle Neotree' },
        { "'", '<CMD>AerialToggle<CR>', desc = 'Toggle Aerial' },
      },
      {
        mode = 'i',
        { 'jk', '<ESC>', desc = 'Exit insert mode' },
        {
          '<C-\\>',
          function()
            cmp.complete {}
          end,
          desc = '',
        },
        {
          '<C-p>',
          function()
            cmp.select_prev_item()
          end,
          desc = '',
        },
        {
          '<C-n>',
          function()
            cmp.select_next_item()
          end,
          desc = '',
        },
        {
          '<C-y>',
          function()
            cmp.confirm { select = true }
          end,
          desc = '',
        },
      },
      { '<Esc><Esc>', '<C-\\><C-n>', desc = 'Exit terminal mode', mode = 't' },
    }

    -- Standalone leader keybindings
    local tb = require 'telescope.builtin'
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
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        desc = '[F]ormat buffer',
        mode = 'n',
      },
      { '<leader>l', '<Plug>(leap)', desc = '[L]eap', mode = 'n' },
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
        desc = 'Grep in [O]pen buffers',
      },
      {
        '<leader>sk',
        function()
          tb.keymaps()
        end,
        desc = '[K]eymaps',
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
        '<CMD>Telescope notify<CR>',
        desc = '[M]essages',
      },
      {
        '<leader>sb',
        function()
          tb.buffers()
        end,
        desc = '[B]uffers',
      },
      {
        '<leader>sh',
        function()
          tb.help_tags()
        end,
        desc = '[H]elp',
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
        maplsp('<leader>sr', vim.lsp.buf.rename, '[R]ename symbol under cursor', 'n')
        maplsp('<C-a>', vim.lsp.buf.code_action, 'Code action', { 'n', 'x' })

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

    -- [G]it
    local gs = require 'gitsigns'
    wk.add { '<leader>g', group = '[G]it hunk', mode = { 'n', 'v' } }
    wk.add { '<leader>gt', group = '[T]oggle' }
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

    -- [D]iagnostic / [D]ebug
    local dap = require 'dap'
    wk.add {
      mode = 'n',
      { '[d', vim.diagnostic.jump { count = -1 }, desc = 'Go to previous [D]iagnostic message', mode = 'n' },
      { ']d', vim.diagnostic.jump { count = 1 }, desc = 'Go to previous [D]iagnostic message', mode = 'n' },
      { '<leader>d', group = '[D]iagnostic / [D]ebug' },
      { '<leader>de', vim.diagnostic.open_float, desc = 'Diagnostic: Show [E]rror messages' },
      { '<leader>dq', vim.diagnostic.setloclist, desc = 'Diagnostic: Open [Q]uickfix list' },
      {
        '<leader>dl',
        function()
          dap.list_breakpoints()
        end,
        desc = 'Debug: [L]ist breakpoints',
      },
      {
        '<leader>dc',
        function()
          dap.clear_breakpoints()
        end,
        desc = 'Debug: [C]lear breakpoints',
      },
      {
        '<F1>',
        function()
          dap.step_into()
        end,
        desc = 'Debug: Step into',
      },
      {
        '<F2>',
        function()
          dap.step_over()
        end,
        desc = 'Debug: Step over',
      },
      {
        '<F3>',
        function()
          dap.step_out()
        end,
        desc = 'Debug: Step out',
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
        '<F6>',
        function()
          dap.restart()
        end,
        desc = 'Debug: restart',
      },
      {
        '<F7>',
        function()
          dap.terminate()
        end,
        desc = 'Debug: terminate',
      },
      {
        '<F10>',
        function()
          require('dapui').toggle()
        end,
        desc = 'Debug: toggle dapui',
      },
      {
        '<F12>',
        function()
          dap.toggle_breakpoint()
        end,
        desc = 'Debug: toggle breakpoint',
      },
    }

    -- [G]it
    wk.add {
      mode = 'n',
      { '<leader>g', group = '[G]it' },
      {
        '<leader>gs',
        function()
          tb.git_status()
        end,
        desc = '[G]it [S]tatus',
      },
    }

    -- Sessio[N]
    wk.add {
      mode = 'n',
      { '<leader>n', group = 'Sessio[N]' },
      {
        '<leader>n<leader>',
        '<CMD>SessionSave<CR>',
        desc = '[ ] Save session',
      },
      {
        '<leader>nr',
        '<CMD>SessionRestore<CR>',
        desc = '[R]estore session',
      },
      {
        '<leader>nd',
        '<CMD>Autosession delete<CR>',
        desc = '[D]elete session',
      },
      {
        '<leader>ns',
        '<CMD>Autosession search<CR>',
        desc = '[S]earch session',
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

    -- AI
    --
    -- Codeium
    vim.keymap.set('i', '<S-Space>', function()
      return vim.fn['codeium#Accept']()
    end, { expr = true, silent = true, desc = 'Codeium accept' })
    vim.keymap.set('i', '<C-k>', function()
      return vim.fn['codeium#CycleCompletions'](-1)
    end, { expr = true, silent = true, desc = 'Codeium cycle previous' })
    vim.keymap.set('i', '<C-j>', function()
      return vim.fn['codeium#CycleCompletions'](1)
    end, { expr = true, silent = true, desc = 'Codeium cycle next' })
    vim.keymap.set('i', '<C-x>', function()
      return vim.fn['codeium#Clear']()
    end, { expr = true, silent = true, desc = 'Codeium clear' })

    -- Gp
    local function keymapOptions(desc)
      return {
        noremap = true,
        silent = true,
        nowait = true,
        desc = desc,
      }
    end
    -- Chat commands
    vim.keymap.set({ 'n', 'i' }, '<C-g>c', '<cmd>GpChatNew<cr>', keymapOptions 'New Chat')
    vim.keymap.set({ 'n', 'i' }, '<C-g>t', '<cmd>GpChatToggle<cr>', keymapOptions 'Toggle Chat')
    vim.keymap.set({ 'n', 'i' }, '<C-g>f', '<cmd>GpChatFinder<cr>', keymapOptions 'Chat Finder')

    vim.keymap.set('v', '<C-g>c', ":<C-u>'<,'>GpChatNew<cr>", keymapOptions 'Visual Chat New')
    vim.keymap.set('v', '<C-g>p', ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions 'Visual Chat Paste')
    vim.keymap.set('v', '<C-g>t', ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions 'Visual Toggle Chat')

    vim.keymap.set({ 'n', 'i' }, '<C-g><C-x>', '<cmd>GpChatNew split<cr>', keymapOptions 'New Chat Split')
    vim.keymap.set({ 'n', 'i' }, '<C-g><C-v>', '<cmd>GpChatNew vsplit<cr>', keymapOptions 'New Chat Vsplit')
    vim.keymap.set({ 'n', 'i' }, '<C-g><C-t>', '<cmd>GpChatNew tabnew<cr>', keymapOptions 'New Chat New Tab')

    vim.keymap.set('v', '<C-g><C-x>', ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions 'Visual Chat New Split')
    vim.keymap.set('v', '<C-g><C-v>', ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions 'Visual Chat New Vsplit')
    vim.keymap.set('v', '<C-g><C-t>', ":<C-u>'<,'>GpChatNew tabnew<cr>", keymapOptions 'Visual Chat New Tabnew')

    -- Prompt commands
    vim.keymap.set({ 'n', 'i' }, '<C-g>r', '<cmd>GpRewrite<cr>', keymapOptions 'Rewrite Replace')
    vim.keymap.set({ 'n', 'i' }, '<C-g>a', '<cmd>GpAppend<cr>', keymapOptions 'Rewrite Append')
    vim.keymap.set({ 'n', 'i' }, '<C-g>b', '<cmd>GpPrepend<cr>', keymapOptions 'Rewrite Prepend')

    vim.keymap.set('v', '<C-g>r', ":<C-u>'<,'>GpRewrite<cr>", keymapOptions 'Rewrite Replace')
    vim.keymap.set('v', '<C-g>a', ":<C-u>'<,'>GpAppend<cr>", keymapOptions 'Rewrite Append')
    vim.keymap.set('v', '<C-g>b', ":<C-u>'<,'>GpPrepend<cr>", keymapOptions 'Rewrite Prepend')
    vim.keymap.set('v', '<C-g>i', ":<C-u>'<,'>GpImplement<cr>", keymapOptions 'Rewrite based on Comments')

    vim.keymap.set({ 'n', 'i' }, '<C-g>gp', '<cmd>GpPopup<cr>', keymapOptions 'Rewrite Popup')
    vim.keymap.set({ 'n', 'i' }, '<C-g>ge', '<cmd>GpEnew<cr>', keymapOptions 'Rewrite New Buffer')
    vim.keymap.set({ 'n', 'i' }, '<C-g>gn', '<cmd>GpNew<cr>', keymapOptions 'Rewrite Split')
    vim.keymap.set({ 'n', 'i' }, '<C-g>gv', '<cmd>GpVnew<cr>', keymapOptions 'Rewrite Vsplit')
    vim.keymap.set({ 'n', 'i' }, '<C-g>gt', '<cmd>GpTabnew<cr>', keymapOptions 'Rewrite New Tab')

    vim.keymap.set('v', '<C-g>gp', ":<C-u>'<,'>GpPopup<cr>", keymapOptions 'Rewrite Popup')
    vim.keymap.set('v', '<C-g>ge', ":<C-u>'<,'>GpEnew<cr>", keymapOptions 'Rewrite New Buffer')
    vim.keymap.set('v', '<C-g>gn', ":<C-u>'<,'>GpNew<cr>", keymapOptions 'Rewrite Split')
    vim.keymap.set('v', '<C-g>gv', ":<C-u>'<,'>GpVnew<cr>", keymapOptions 'Rewrite Vsplit')
    vim.keymap.set('v', '<C-g>gt', ":<C-u>'<,'>GpTabnew<cr>", keymapOptions 'Rewrite New Tab')

    vim.keymap.set({ 'n', 'i' }, '<C-g>x', '<cmd>GpContext<cr>', keymapOptions 'Toggle Context')
    vim.keymap.set('v', '<C-g>x', ":<C-u>'<,'>GpContext<cr>", keymapOptions 'Toggle Context')

    vim.keymap.set({ 'n', 'i', 'v', 'x' }, '<C-g>s', '<cmd>GpStop<cr>', keymapOptions 'Stop')
    vim.keymap.set({ 'n', 'i', 'v', 'x' }, '<C-g>n', '<cmd>GpNextAgent<cr>', keymapOptions 'Next Agent')
  end,
}
