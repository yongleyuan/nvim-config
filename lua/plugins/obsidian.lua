return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = false,
  event = {
    'BufReadPre ~/Library/Mobile Documents/iCloud~md~obsidian/Documents/vault_103',
    'BufNewFile ~/Library/Mobile Documents/iCloud~md~obsidian/Documents/vault_103',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    legacy_commands = false,

    workspaces = {
      {
        name = 'vault_103',
        path = '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/vault_103',
      },
    },

    notes_subdir = vim.NIL,

    log_level = vim.log.levels.INFO,

    daily_notes = {
      folder = 'dailies',
      date_format = '%Y-%m-%d',
      alias_format = '%B %-d, %Y',
      default_tags = { 'daily-notes' },
      template = nil,
    },

    completion = {
      nvim_cmp = false,
      blink = true,
      min_chars = 0,
    },

    new_notes_location = 'current_dir',

    note_id_func = function(title)
      local newtitle = ''
      if title ~= nil then
        -- If title is given, use as is.
        newtitle = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
        if string.len(newtitle) == 0 then
          newtitle = 'untitled-' .. tostring(os.time())
        end
      else
        -- If title is nil, set it to the time.
        for _ = 1, 4 do
          newtitle = 'untitled-' .. tostring(os.time())
        end
      end
      return newtitle
    end,

    note_path_func = function(spec)
      local path = tostring(spec.id)
      return path .. '.md'
    end,

    wiki_link_func = 'use_alias_only',

    preferred_link_style = 'wiki',

    frontmatter = { enabled = true },

    formatter = {
      func = function(note)
        if note.title then
          note:add_alias(note.title)
        end

        local out = { id = note.id, aliases = note.aliases, tags = note.tags }

        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,
    },

    templates = {
      folder = '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/template',
    },

    follow_url_func = function(url)
      vim.fn.jobstart({ 'open', url })
    end,

    follow_img_func = function(img)
      vim.fn.jobstart({ 'qlmanage', '-p', img })
    end,

    -- use_advanced_uri = false,

    -- open_app_foreground = true,

    picker = { name = 'snacks.pick' },

    search = { sort_by = 'modified', search_reversed = true, max_lines = 1000 },

    open_notes_in = 'current',

    callbacks = {
      post_setup = function(client) end,
      enter_note = function(client, note) end,
      leave_note = function(client, note) end,
      pre_write_note = function(client, note) end,
      post_set_workspace = function(client, workspace) end,
    },

    ui = { enable = false },

    attachments = {
      img_folder = 'images',

      img_name_func = function()
        return string.format('%s-', os.time())
      end,

      img_text_func = function(client, path)
        path = client:vault_relative_path(path) or path
        return string.format('![%s](%s)', path.name, path)
      end,
    },
  },
}
