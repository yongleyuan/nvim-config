-- Suppress optional provider warnings
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Do not use codeium default keybindings
vim.g.codeium_disable_bindings = 1

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

vim.opt.showmode = false

vim.opt.clipboard = 'unnamedplus'

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250

vim.opt.timeoutlen = 500

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.opt.termguicolors = true

vim.opt.hlsearch = true

vim.opt.conceallevel = 1

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  require 'plugins.aerial',
  require 'plugins.autopairs',
  require 'plugins.autosave',
  require 'plugins.autosession',
  require 'plugins.avante',
  require 'plugins.completion',
  require 'plugins.codeium',
  require 'plugins.colorscheme',
  require 'plugins.comment',
  require 'plugins.conform',
  require 'plugins.dap',
  require 'plugins.dashboard',
  require 'plugins.flash',
  require 'plugins.fzf',
  require 'plugins.git',
  require 'plugins.grug-far',
  require 'plugins.harpoon',
  require 'plugins.indent',
  require 'plugins.image', -- NOTE: This plugin works best with Kitty/Ghostty
  require 'plugins.ironrepl',
  require 'plugins.lualine',
  require 'plugins.lint',
  require 'plugins.lsp',
  require 'plugins.mini',
  require 'plugins.noice',
  require 'plugins.obsidian',
  require 'plugins.oil',
  require 'plugins.python-venv',
  require 'plugins.tmux',
  require 'plugins.treesitter',
  require 'plugins.undotree',
  require 'plugins.which-key',
  require 'plugins.yanky',
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
