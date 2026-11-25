return {
  'lmilojevicc/herdr-splits.nvim',
  commit = '4556fc0e7d4895fd8c86a1727dd9104c39e6e7d4',
  pin = true,
  cond = vim.env.HERDR_ENV == '1' and not vim.env.TMUX,
  lazy = false,
  config = function()
    local splits = require 'herdr-splits'
    splits.setup { at_edge = 'stop', nav_at_edge = 'stop', unzoom_on_nav = false }
    vim.keymap.set('n', '<C-h>', splits.move_cursor_left)
    vim.keymap.set('n', '<C-j>', splits.move_cursor_down)
    vim.keymap.set('n', '<C-k>', splits.move_cursor_up)
    vim.keymap.set('n', '<C-l>', splits.move_cursor_right)
  end,
}
