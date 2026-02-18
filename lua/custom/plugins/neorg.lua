return {
  'nvim-neorg/neorg',
  lazy = false,
  version = '*',
  config = {
    load = {
      ['core.defaults'] = {},
      ['core.concealer'] = {},
      ['core.dirman'] = {
        config = {
          workspaces = {
            notes = '~/notes',
          },
          default_workspace = 'notes',
        },
      },
      ['core.integrations.image'] = {},
      ['core.latex.renderer'] = {},
    },
  },
}
