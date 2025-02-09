return {
  'saghen/blink.cmp',
  lazy = false,
  dependencies = 'rafamadriz/friendly-snippets',

  version = '*',

  opts = {
    keymap = { preset = 'enter', ['<Tab>'] = { 'select_next', 'fallback' }, ['<S-Tab>'] = { 'select_prev', 'fallback' } },

    completion = {
      list = { selection = { preselect = false, auto_insert = true } },
      documentation = { auto_show = true },
      menu = {
        draw = {
          columns = {
            { 'label', 'label_description', gap = 1 },
            { 'kind_icon', 'kind', gap = 1 },
          },
        },
      },
    },

    -- appearance = {
    --   nerd_font_variant = 'mono',
    -- },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    signature = { enabled = true },
  },
  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  -- opts_extend = { 'sources.default' },
}
