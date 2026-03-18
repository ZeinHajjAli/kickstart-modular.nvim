return {
  'saghen/blink.cmp',
  lazy = false,
  dependencies = 'rafamadriz/friendly-snippets',

  version = '1.*',

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

    appearance = {
      nerd_font_variant = 'mono',
    },

    sources = {
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },

    signature = { enabled = true },
  },
}
