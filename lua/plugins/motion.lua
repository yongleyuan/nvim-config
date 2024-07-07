return {
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').opts.safe_labels = {}
    end,
  },
  {
    'ggandor/flit.nvim',
    config = function()
      require('flit').setup {}
    end,
  },
}
