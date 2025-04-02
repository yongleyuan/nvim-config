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
    local wk = require('which-key')
    wk.setup(opts)

    -- Imports
    local splits = require('smart-splits')
    local snacks = require('snacks')
    local gs = require('gitsigns')
    local oil = require('oil')
    local flash = require('flash')
    local conform = require('conform')
    local ut = require('undotree')
    local harpoon = require('harpoon')
    local dap = require('dap')
    local dapui = require('dapui')
    local ms = require('mini.sessions')
    local vs = require('venv-selector')
    local iron = require('iron.core')

    -- Standalone keybindings
    wk.add({
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
            splits.move_cursor_left()
          end,
          desc = 'Move focus to the left window',
        },
        {
          '<C-l>',
          function()
            splits.move_cursor_right()
          end,
          desc = 'Move focus to the right window',
        },
        {
          '<C-j>',
          function()
            splits.move_cursor_down()
          end,
          desc = 'Move focus to the upper window',
        },
        {
          '<C-k>',
          function()
            splits.move_cursor_up()
          end,
          desc = 'Move focus to the lower window',
        },
        {
          '<C-A-h>',
          function()
            splits.resize_left()
          end,
          desc = 'Resize to the left',
        },
        {
          '<C-A-l>',
          function()
            splits.resize_right()
          end,
          desc = 'Resize to the right',
        },
        {
          '<C-A-j>',
          function()
            splits.resize_down()
          end,
          desc = 'Resize to the bottom',
        },
        {
          '<C-A-k>',
          function()
            splits.resize_up()
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
        {
          ',',
          function()
            oil.open()
            vim.wait(1000, function()
              return oil.get_cursor_entry() ~= nil
            end)
            if oil.get_cursor_entry() then
              oil.open_preview()
            end
          end,
          desc = 'Oil files',
        },
        {
          ']w',
          function()
            snacks.words.jump(1, true)
          end,
          desc = 'Jump to next treesitter word',
        },
        {
          '[w',
          function()
            snacks.words.jump(-1, true)
          end,
          desc = 'Jump to previous treesitter word',
        },
      },
      {
        mode = 'i',
        { 'jk', '<ESC>', desc = 'Exit insert mode' },
        { '<Tab>', '<S-Tab>', desc = 'Print true tabs' }, -- not sure why but works
      },
      { '<ESC><ESC>', '<C-\\><C-n>', desc = 'Exit terminal mode', mode = 't' },
      {
        mode = 'v',
        { 'J', ":m '>+1<CR>gv=gv", desc = 'Move selected text up' },
        { 'K', ":m '<-2<CR>gv=gv", desc = 'Move selected text down' },
      },
      -- flash
      {
        "'",
        mode = { 'n', 'x', 'o' },
        function()
          flash.jump()
        end,
        desc = 'Flash',
      },
      {
        ';',
        mode = { 'n', 'x', 'o' },
        function()
          flash.treesitter()
        end,
        desc = 'Flash Treesitter',
      },
    })

    -- Standalone leader keybindings
    wk.add({
      mode = 'v',
      '<leader>f',
      function()
        conform.format({ async = true, lsp_format = 'fallback' })
      end,
      desc = '[F]ormat selection',
    })
    wk.add({
      mode = 'n',
      {
        '<leader><leader>',
        function()
          snacks.picker.lines()
        end,
        desc = 'Fuzzy find in current buffer',
      },
      {
        '<leader>,',
        '<CMD>lua MiniFiles.open()<CR>',
        desc = 'Mini files',
      },
      {
        '<leader>.',
        function()
          snacks.picker.buffers()
        end,
        desc = 'Fuzzy find buffers',
      },
      {
        "<leader>'",
        function()
          snacks.picker.smart()
        end,
        desc = 'Fuzzy smart find',
      },
      {
        '<leader>/',
        function()
          snacks.picker.files()
        end,
        desc = 'Fuzzy find file in cwd',
      },
      {
        '<leader>f',
        function()
          conform.format({ async = true, lsp_format = 'fallback' })
        end,
        desc = '[F]ormat buffer',
      },
      { '<leader>e', vim.diagnostic.open_float, desc = '[E]rror message' },
      {
        '<leader>u',
        function()
          ut.toggle()
        end,
        desc = '[U]ndotree',
      },
      {
        '<leader><C-h>',
        function()
          splits.swap_buf_left({ move_cursor = true })
        end,
        desc = 'Swap buffer left',
        hidden = true,
      },
      {
        '<leader><C-l>',
        function()
          splits.swap_buf_right({ move_cursor = true })
        end,
        desc = 'Swap buffer right',
        hidden = true,
      },
      {
        '<leader><C-j>',
        function()
          splits.swap_buf_down({ move_cursor = true })
        end,
        hidden = true,
        desc = 'Swap buffer down',
      },
      {
        '<leader><C-k>',
        function()
          splits.swap_buf_up({ move_cursor = true })
        end,
        hidden = true,
        desc = 'Swap buffer up',
      },
    })

    -- Yanky
    wk.add({
      mode = { 'n', 'x' },
      { 'y', '<Plug>(YankyYank)', desc = 'Yank text' },
      { 'p', '<Plug>(YankyPutAfter)', desc = 'Put yanked text after cursor' },
      { 'P', '<Plug>(YankyPutBefore)', desc = 'Put yanked text before cursor' },
      { 'gp', '<Plug>(YankyGPutAfter)', desc = 'Put yanked text after selection' },
      { 'gP', '<Plug>(YankyGPutBefore)', desc = 'Put yanked text before selection' },
    })
    wk.add({
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
    })

    -- [H]arpoon
    wk.add({
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
    })

    -- [S]earch (Snack.picker)
    wk.add({
      mode = 'n',
      { '<leader>s', group = '[S]earch' },
      {
        '<leader>sg',
        function()
          snacks.picker.grep()
        end,
        desc = '[G]rep in current directory',
      },
      {
        '<leader>so',
        function()
          snacks.picker.grep_buffers()
        end,
        desc = '[O]pen buffers grep',
      },
      {
        '<leader>sw',
        function()
          snacks.picker.grep_word()
        end,
        desc = '[W]ord under cursor',
      },
      {
        '<leader>ss',
        function()
          snacks.picker.lsp_symbols()
        end,
        desc = '[S]ymbols in buffer',
      },
      {
        '<leader>sS',
        function()
          snacks.picker.lsp_workspace_symbols()
        end,
        desc = '[S]ymbols in workspace',
      },
      {
        '<leader>sd',
        function()
          snacks.picker.diagnostics_buffer()
        end,
        desc = '[D]iagnostics document',
      },
      {
        '<leader>sD',
        function()
          snacks.picker.diagnostics()
        end,
        desc = '[D]iagnostics workspace',
      },
      {
        '<leader>sc',
        function()
          snacks.picker.command_history()
        end,
        desc = '[C]ommand history',
      },
      {
        '<leader>sC',
        function()
          snacks.picker.commands()
        end,
        desc = '[C]ommands',
      },
      { '<leader>sm', '<CMD>NoiceHistory<CR>', desc = '[M]essages' },
      {
        '<leader>sk',
        function()
          snacks.picker.keymaps()
        end,
        desc = '[K]eymaps',
      },
      {
        '<leader>sh',
        function()
          snacks.picker.help()
        end,
        desc = '[H]elp',
      },
      {
        '<leader>st',
        function()
          snacks.picker.todo_comments({ keywords = { 'TODO', 'FIX', 'FIXME' } })
        end,
        desc = '[T]odos',
      },
      {
        '<leader>sT',
        function()
          snacks.picker.todo_comments()
        end,
        desc = '[T]odos (all)',
      },
      {
        '<leader>sr',
        function()
          snacks.picker.resume()
        end,
        desc = '[R]esume',
      },
    })

    -- Replace
    wk.add({
      mode = 'n',
      { '<leader>r', group = '[R]ename' },
      { '<leader>rn', ':IncRename ', desc = '[R]e[N]ame with IncRename' },
      {
        '<leader>rp',
        [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
        desc = '[R]ename [P]hrase under cursor',
      },
    })

    -- LSP autocommands (mianly [G]oto)
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local maplsp = function(keys, func, desc, mode)
          wk.add({ keys, func, desc = desc .. ' (LSP)', mode = mode })
        end
        maplsp('gd', function()
          snacks.picker.lsp_definitions()
        end, '[G]oto [D]efinitions', 'n')
        maplsp('gr', function()
          snacks.picker.lsp_references()
        end, '[G]oto [R]eferences', 'n')
        maplsp('gi', function()
          snacks.picker.lsp_implementations()
        end, '[G]oto [I]mplementations', 'n')
        maplsp('gD', function()
          snacks.picker.lsp_declarations()
        end, '[G]oto [D]eclaration', 'n')
        maplsp('gt', function()
          snacks.picker.lsp_type_definitions()
        end, '[G]oto [T]ype definitions', 'n')
        maplsp('<leader>rs', vim.lsp.buf.rename, '[R]ename [S]ymbol under cursor', 'n')
        maplsp('<C-a>', vim.lsp.buf.code_action, 'Code action', { 'n', 'x', 'i' })
      end,
    })

    -- [D]ebug
    wk.add({
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
          dapui.toggle()
        end,
        desc = 'Debug: toggle dapui',
      },
      {
        '<leader>d<CR>',
        function()
          dapui.toggle()
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
    })

    -- [G]it
    wk.add({ '<leader>g', group = '[G]it', mode = { 'n', 'v' } })
    wk.add({
      mode = 'n',
      { '<leader>g<leader>', '<CMD>Git<CR>', desc = 'Git status' },
      { '<leader>gi', '<CMD>diffget //2<CR>', desc = 'Git diff get left' },
      { '<leader>go', '<CMD>diffget //3<CR>', desc = 'Git diff get right' },
      {
        '<leader>gl',
        function()
          snacks.lazygit.log()
        end,
        desc = 'Git log',
      },
      {
        '<leader>gL',
        function()
          snacks.lazygit()
        end,
        desc = 'Git lazygit',
      },
    })
    gs.setup({
      on_attach = function(bufnr)
        local function gsmap(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          opts.desc = opts.desc .. ' (Gitsigns)'
          vim.keymap.set(mode, l, r, opts)
        end
        gsmap('n', ']c', function()
          if vim.wo.diff then
            vim.CMD.normal({ ']c', bang = true })
          else
            gs.nav_hunk('next')
          end
        end, { desc = 'Jump to next hunk' })
        gsmap('n', '[c', function()
          if vim.wo.diff then
            vim.CMD.normal({ '[c', bang = true })
          else
            gs.nav_hunk('prev')
          end
        end, { desc = 'Jump to previous hunk' })
        gsmap('v', '<leader>gs', function()
          gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = '[S]tage git hunk' })
        gsmap('v', '<leader>gr', function()
          gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
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
          gs.diffthis('@')
        end, { desc = 'Diff against HEAD' })
      end,
    })

    -- [S]ession
    wk.add({
      mode = 'n',
      { '<leader>S', group = '[S]ession' },
      {
        '<leader>S<leader>',
        function()
          local ms_dir = ms.config.directory
          local handle = io.popen('fd .session$ ' .. ms_dir .. ' --full-path --color never')
          if handle == nil then
            vim.notify('Session dir ' .. ms_dir .. ' not found')
            return
          end
          local output = handle:read('*a')
          handle:close()
          local items = {}
          local i = 1
          for session in output:gmatch('[^\n]+') do
            table.insert(items, {
              idx = i,
              text = string.gsub(string.match(session, 'session/(.*)'), '=', '/'),
              path = string.match(session, 'session/(.*)'),
            })
            i = i + 1
          end
          return snacks.picker({
            title = 'Select session',
            items = items,
            format = function(item)
              local ret = {}
              ret[#ret + 1] = { item.text, 'SnacksPickerText' }
              return ret
            end,
            confirm = function(picker, item)
              picker:close()
              ms.read(item.path)
              vim.notify('Restored ' .. item.text)
            end,
            layout = { preset = 'select', preview = false },
          })
        end,
        desc = '[ ] Search sessions',
      },
      {
        '<leader>Ss',
        function()
          local session_name = string.gsub(vim.fn.getcwd(), '/', '=') .. '.session'
          ms.write(session_name)
        end,
        desc = '[S]ave session',
      },
      {
        '<leader>Sr',
        function()
          local session_name = string.gsub(vim.fn.getcwd(), '/', '=') .. '.session'
          ms.read(session_name)
        end,
        desc = '[R]estore session',
      },
      {
        '<leader>Sd',
        function()
          local session_name = string.gsub(vim.fn.getcwd(), '/', '=') .. '.session'
          ms.delete(session_name, { force = true })
        end,
        desc = '[D]elete current session',
      },
      {
        '<leader>SD',
        function()
          local ms_dir = ms.config.directory
          local handle = io.popen('fd .session$ ' .. ms_dir .. ' --full-path --color never')
          if handle == nil then
            vim.notify('Session dir ' .. ms_dir .. ' not found')
            return
          end
          local output = handle:read('*a')
          handle:close()
          local items = {}
          local i = 1
          for session in output:gmatch('[^\n]+') do
            table.insert(items, {
              idx = i,
              text = string.gsub(string.match(session, 'session/(.*)'), '=', '/'),
              path = session,
            })
            i = i + 1
          end
          return snacks.picker({
            title = 'Delete session',
            items = items,
            format = function(item)
              local ret = {}
              ret[#ret + 1] = { item.text, 'SnacksPickerText' }
              return ret
            end,
            confirm = function(picker, item)
              picker:close()
              os.execute('rm ' .. item.path)
              vim.notify('Deleted ' .. item.text)
            end,
            layout = { preset = 'select', preview = false },
          })
        end,
        desc = '[D]elete session search',
      },
    })

    -- [V]env Selector
    wk.add({
      mode = 'n',
      { '<leader>v', group = '[V]irtual env' },
      {
        '<leader>v<leader>',
        function()
          local venv = vs.venv()
          if not venv then
            vim.notify('No virtual env activated', vim.log.levels.INFO)
          else
            vim.notify('Current virtual env: \n' .. venv, vim.log.levels.INFO)
          end
        end,
        desc = '[ ] Current vitural env',
      },
      {
        '<leader>vs',
        function()
          local handle = io.popen('fd /bin/python$ ~/miniconda3/envs --full-path --color never')
          if handle == nil then
            vim.notify('No virtual env found')
            return
          end
          local output = handle:read('*a')
          handle:close()
          local items = {}
          local i = 1
          for venv in output:gmatch('[^\n]+') do
            table.insert(items, {
              idx = i,
              name = venv,
              text = string.match(venv, 'envs/(.*)/bin/python'),
            })
            i = i + 1
          end
          return snacks.picker({
            title = 'Select virtual env',
            items = items,
            format = function(item)
              local ret = {}
              ret[#ret + 1] = { item.text, 'SnacksPickerText' }
              ret[#ret + 1] = { ' @ ' .. item.name, 'SnacksPickerComment' }
              return ret
            end,
            confirm = function(picker, item)
              picker:close()
              vs.activate_from_path(item.name)
              vim.notify('Activated virtual env: ' .. item.text, vim.log.levels.INFO)
            end,
            layout = { preset = 'select', preview = false },
          })
        end,
        desc = '[S]elect vitural env',
      },
      {
        '<leader>vd',
        function()
          vs.deactivate()
        end,
        desc = '[D]eactivate vitural env',
      },
    })

    -- [O]bsidian
    wk.add({
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
    })

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
    wk.add({
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
          iron.close_repl('python')
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
    })
  end,
}
