return {
  {
    'numToStr/Comment.nvim',
    opts = {},
  },
  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = true,
      highlight = {
        -- keyword = 'bg',
        -- pattern = [[(KEYWORDS)]],
      },
    },
  },
}
