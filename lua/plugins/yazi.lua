return {
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  opts = {
    open_for_directories = true,
    keymaps = {
      show_help = '<f1>',
      open_file_in_vertical_split = '<C-v>',
      open_file_in_horizontal_split = '<C-s>',
      open_file_in_tab = '<C-t>',
      grep_in_directory = '<C-S-s>',
      replace_in_directory = '<C-g>',
      cycle_open_buffers = '<tab>',
      copy_relative_path_to_selected_files = '<C-y>',
      send_to_quickfix_list = '<C-q>',
      change_working_directory = '<C-\\>',
    },
    floating_window_scaling_factor = 0.8,
    integrations = {
      resolve_relative_path_application = 'grealpath',
    },
  },
}
