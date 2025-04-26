return {
  'MagicDuck/grug-far.nvim',
  version = 'v1.6.3',
  config = function()
    require('grug-far').setup({
      keymaps = {
        replace = { n = '<localleader>R' },
        qflist = { n = '<localleader>Q' },
        syncLocations = { n = '<localleader>S' },
        syncLine = { n = '<localleader>L' },
        close = { n = '<localleader>C' },
        historyOpen = { n = '<localleader>H' },
        historyAdd = { n = '<localleader>A' },
        refresh = { n = '<localleader>F' },
        openLocation = { n = '<localleader>O' },
        abort = { n = '<localleader>X' },
        toggleShowCommand = { n = '<localleader>M' },
        swapEngine = { n = '<localleader>E' },
        previewLocation = { n = '<localleader>P' },
        openNextLocation = { n = '<down>' },
        openPrevLocation = { n = '<up>' },
        gotoLocation = { n = '<enter>' },
        pickHistoryEntry = { n = '<enter>' },
        help = { n = 'g?' },
      },
    })
  end,
}
