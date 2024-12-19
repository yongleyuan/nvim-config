return {
  'folke/which-key.nvim',
  event = 'VimEnter',

  opts = {
    preset = 'modern',
    sort = { 'manual', 'local', 'order', 'group', 'alphanum', 'mod', 'lower', 'icase' },
    icons = {
      rules = false,
      group = '',
    },
    win = {
      no_overlap = false,
    },
  },

  config = function(_, opts)
    local wk = require 'which-key'
    wk.setup(opts)

    -- Standalone keybindings
    local cmp = require 'cmp'
    wk.add {
      {
        mode = 'n',
        { '\\', '<CMD>AerialToggle<CR>', desc = 'Aerial' },
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
        {
          '<C-A-h>',
          function()
            require('tmux').resize_left()
          end,
          desc = 'Resize to the left',
        },
        {
          '<C-A-l>',
          function()
            require('tmux').resize_right()
          end,
          desc = 'Resize to the right',
        },
        {
          '<C-A-j>',
          function()
            require('tmux').resize_bottom()
          end,
          desc = 'Resize to the bottom',
        },
        {
          '<C-A-k>',
          function()
            require('tmux').resize_top()
          end,
          desc = 'Resize to the top',
        },
        { '<C-A-i>', '<CMD>bnext<CR>', desc = 'Next buffer' },
        { '<C-A-o>', '<CMD>bprev<CR>', desc = 'Previous buffer' },
        { '<C-A-c>', '<CMD>bdelete<CR>', desc = 'Delete buffer' },
        { '<C-A-x>', '<CMD>bdelete!<CR>', desc = 'Delete buffer!' },
        { 'J', 'mzJ`z', desc = '' },
        { 'U', 'i<CR><ESC>', desc = 'Insert new line under cursor' },
        { '<CR>', 'o<ESC>', desc = '' },
        { '<leader><CR>', 'O<ESC>', desc = '', hidden = true },
        { 'vv', 'V', desc = 'Select line' },
        { 'V', 'v$', desc = 'Select until end of line' },
        { '[d', vim.diagnostic.goto_prev(), desc = 'Go to previous [D]iagnostic message', mode = 'n' },
        { ']d', vim.diagnostic.goto_next(), desc = 'Go to previous [D]iagnostic message', mode = 'n' },
        { ',', function ()
          local oil = require('oil')
          oil.open_float()
          vim.wait(1000, function ()
            return oil.get_cursor_entry() ~= nil
          end)
          if oil.get_cursor_entry() then
            oil.open_preview()
          end
        end, desc = 'Open Oil current file' },
      },
      {
        mode = 'i',
        { 'jk', '<ESC>', desc = 'Exit insert mode' },
        { '<Tab>', '<S-Tab>', desc = 'Print true tabs' }, -- NOTE: Not sure why but works
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
          '<C-d>',
          function()
            cmp.scroll_docs(-4)
          end,
          desc = 'Scroll cmp hover docs up',
        },
        {
          '<C-f>',
          function()
            cmp.scroll_docs(4)
          end,
          desc = 'Scroll cmp hover docs down',
        },
      },
      { '<ESC><ESC>', '<C-\\><C-n>', desc = 'Exit terminal mode', mode = 't' },
      {
        mode = 'v',
        { 'J', ":m '>+1<CR>gv=gv", desc = 'Move selected text up' },
        { 'K', ":m '<-2<CR>gv=gv", desc = 'Move selected text down' },
      },
      -- flash
      {
        't',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'T',
        mode = { 'n' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'T',
        mode = { 'o' },
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
    }

    -- Standalone leader keybindings
    wk.add {
      mode = 'v',
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      desc = '[F]ormat selection',
    }
    wk.add {
      mode = 'n',
      { '<leader><leader>', '<CMD>FzfLua grep_curbuf<CR>', desc = 'Fuzzy find in current buffer' },
      { '<leader>.', '<CMD>FzfLua buffers<CR>', desc = 'Fuzzy find buffers' },
      { '<leader>/', '<CMD>FzfLua files<CR>', desc = 'Fuzzy find file in cwd' },
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        desc = '[F]ormat buffer',
      },
      { '<leader>e', vim.diagnostic.open_float, desc = '[E]rror message' },
      {
        '<leader>u',
        function()
          require('undotree').toggle()
        end,
        desc = '[U]ndotree',
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

    -- [S]earch (Fzf-Lua)
    wk.add {
      mode = 'n',
      { '<leader>s', group = '[S]earch' },
      { '<leader>s<leader>', '<CMD>FzfLua<CR>', desc = '[ ] Fzf-Lua' },
      { '<leader>sg', '<CMD>FzfLua live_grep<CR>', desc = '[G]rep in current directory' },
      { '<leader>so', '<CMD>FzfLua lines<CR>', desc = '[O]pen buffers grep' },
      { '<leader>sw', '<CMD>FzfLua grep_cword<CR>', desc = '[W]ord under cursor' },
      { '<leader>sW', '<CMD>FzfLua grep_cWORD<CR>', desc = '[W]ORD under cursor' },
      { '<leader>ss', '<CMD>FzfLua lsp_document_symbols<CR>', desc = '[S]ymbols in buffer' },
      { '<leader>sS', '<CMD>FzfLua lsp_dynamic_workspace_symbols<CR>', desc = '[S]ymbols in workspace' },
      { '<leader>sd', '<CMD>FzfLua lsp_document_diagnostics<CR>', desc = '[D]iagnostics document' },
      { '<leader>sD', '<CMD>FzfLua lsp_workspace_diagnostics<CR>', desc = '[D]iagnostics workspace' },
      { '<leader>sc', '<CMD>FzfLua command_history<CR>', desc = '[C]ommand history' },
      { '<leader>sC', '<CMD>FzfLua commands<CR>', desc = '[C]ommands' },
      { '<leader>sm', '<CMD>NoiceFzf<CR>', desc = '[M]essages' },
      { '<leader>sk', '<CMD>FzfLua keymaps<CR>', desc = '[K]eymaps' },
      { '<leader>sh', '<CMD>FzfLua helptags<CR>', desc = '[H]elp' },
      { '<leader>st', '<CMD>TodoFzfLua<CR>', desc = '[T]odos' },
      { '<leader>sr', '<CMD>FzfLua resume<CR>', desc = '[R]esume' },
    }
    wk.add { '<leader>s', '<CMD>FzfLua grep_visual<CR>', desc = '[S]earch selection', mode = 'v' }

    -- Replace
    wk.add {
      mode = 'n',
      { '<leader>r', group = '[R]ename' },
      { '<leader>rn', '<CMD>IncRename ', desc = '[R]e[N]ame with IncRename' },
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
        maplsp('gd', '<CMD>FzfLua lsp_definitions<CR>', '[G]oto [D]efinitions', 'n')
        maplsp('gr', '<CMD>FzfLua lsp_references<CR>', '[G]oto [R]eferences', 'n')
        maplsp('gi', '<CMD>FzfLua lsp_implementations<CR>', '[G]oto [I]mplementations', 'n')
        maplsp('gD', '<CMD>FzfLua lsp_declarations<CR>', '[G]oto [D]eclaration', 'n')
        maplsp('gt', '<CMD>FzfLua lsp_type_definitions<CR>', '[G]oto [T]ype definitions', 'n')
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

    -- [D]ebug
    local dap = require 'dap'
    wk.add {
      mode = 'n',
      { '<leader>d', group = '[D]ebug' },
      {
        '<leader>d<leader>',
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
        '<F10>',
        function()
          require('dapui').toggle()
        end,
        desc = 'Debug: toggle dapui',
      },
      {
        '<leader>d<CR>',
        function()
          require('dapui').toggle()
        end,
        desc = 'Debug: toggle dapui',
      },
      {
        '<F5>',
        function()
          dap.continue()
        end,
        desc = 'Debug: start/continue',
      },
      {
        '<leader>dd',
        function()
          dap.continue()
        end,
        desc = 'Debug: start/continue',
      },
      {
        '<leader>di',
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
        '<leader>ds',
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
        '<leader>do',
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
        '<leader>dS',
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
        '<leader>dr',
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
        '<leader>dt',
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
        '<leader>dl',
        function()
          dap.list_breakpoints()
        end,
        desc = 'Debug: List breakpoints',
      },
      {
        '<leader>dC',
        function()
          dap.clear_breakpoints()
        end,
        desc = 'Debug: Clear breakpoints',
      },
    }

    -- [G]it
    local gs = require 'gitsigns'
    wk.add { '<leader>g', group = '[G]it', mode = { 'n', 'v' } }
    wk.add {
      mode = 'n',
      { '<leader>g<leader>', '<CMD>Git<CR>', desc = 'Git status' },
      { '<leader>gi', '<CMD>diffget //2<CR>', desc = 'Git diff get left' },
      { '<leader>go', '<CMD>diffget //3<CR>', desc = 'Git diff get right' },
    }
    gs.setup {
      on_attach = function(bufnr)
        local function gsmap(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          opts.desc = opts.desc .. ' (Gitsigns)'
          vim.keymap.set(mode, l, r, opts)
        end
        gsmap('n', ']c', function()
          if vim.wo.diff then
            vim.CMD.normal { ']c', bang = true }
          else
            gs.nav_hunk 'next'
          end
        end, { desc = 'Jump to next hunk' })
        gsmap('n', '[c', function()
          if vim.wo.diff then
            vim.CMD.normal { '[c', bang = true }
          else
            gs.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous hunk' })
        gsmap('v', '<leader>gs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[S]tage git hunk' })
        gsmap('v', '<leader>gr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[R]eset git hunk' })
        gsmap('n', '<leader>gs', gs.stage_hunk, { desc = 'Stage hunk' })
        gsmap('n', '<leader>gr', gs.reset_hunk, { desc = 'Reset hunk' })
        gsmap('n', '<leader>gS', gs.stage_buffer, { desc = 'Stage buffer' })
        gsmap('n', '<leader>gR', gs.reset_buffer, { desc = 'Reset buffer' })
        gsmap('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
        gsmap('n', '<leader>gp', gs.preview_hunk, { desc = 'Preview hunk' })
        gsmap('n', '<leader>gb', gs.blame_line, { desc = 'Blame current line' })
        gsmap('n', '<leader>gB', gs.toggle_current_line_blame, { desc = 'Blame toggle' })
        gsmap('n', '<leader>gv', gs.toggle_deleted, { desc = 'View deleted' })
        gsmap('n', '<leader>gd', gs.diffthis, { desc = 'Diff against last index' })
        gsmap('n', '<leader>gD', function()
          gs.diffthis '@'
        end, { desc = 'Diff against HEAD' })
      end,
    }

    -- [S]ession
    wk.add {
      mode = 'n',
      { '<leader>S', group = '[S]ession' },
      {
        '<leader>S<leader>',
        '<CMD>Autosession search<CR>',
        desc = '[ ] Search sessions',
      },
      {
        '<leader>Ss',
        '<CMD>SessionSave<CR>',
        desc = '[S]ave session',
      },
      {
        '<leader>Sr',
        '<CMD>SessionRestore<CR>',
        desc = '[R]estore session',
      },
      {
        '<leader>Sd',
        '<CMD>SessionDelete<CR>',
        desc = '[D]elete current session',
      },
      {
        '<leader>SD',
        '<CMD>Autosession delete<CR>',
        desc = '[D]elete session search',
      },
      {
        '<leader>SP',
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

    -- Codeium
    vim.keymap.set('i', '<C-A-y>', function()
      return vim.fn['codeium#Accept']()
    end, { expr = true, silent = true, desc = 'Codeium accept' })
    vim.keymap.set('i', '<C-A-[>', function()
      return vim.fn['codeium#CycleCompletions'](-1)
    end, { expr = true, silent = true, desc = 'Codeium cycle previous' })
    vim.keymap.set('i', '<C-A-]>', function()
      return vim.fn['codeium#CycleCompletions'](1)
    end, { expr = true, silent = true, desc = 'Codeium cycle next' })
    vim.keymap.set('i', '<C-A-x>', function()
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
