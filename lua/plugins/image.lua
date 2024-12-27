return {
  '3rd/image.nvim',
  build = false,
  opts = {
    processor = 'magick_cli',
    integrations = {
      markdown = {
        only_render_image_at_cursor = true,
        clear_in_insert_mode = true,
      },
    },
    tmux_show_only_in_active_window = true,
  },
}
