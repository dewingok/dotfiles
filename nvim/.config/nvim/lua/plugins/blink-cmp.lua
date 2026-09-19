return {
  'saghen/blink.cmp',
  'L3MON4D3/LuaSnip',
  config = function ()
    require('luasnip').setup {}

    require('blink.cmp').setup {
      keymap = {
        -- Key mappings:
        -- <c-y> to accept ([y]es) the completion.
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        preset = 'default',
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = {
        -- Don't automatically show documentation, press `<c-space>`
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets' },
      },
      snippets = { preset = 'luasnip' },

      fuzzy = { implementation = 'prefer_rust_with_warning' },
      signature = { enabled = true },
    }
  end,
}
