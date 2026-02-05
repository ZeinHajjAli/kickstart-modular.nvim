return {
  'linux-cultist/venv-selector.nvim',
  ft = { 'python' },
  dependencies = {
    'neovim/nvim-lspconfig',
    'mfussenegger/nvim-dap',
    'mfussenegger/nvim-dap-python',
  },
  opts = {
    search = {},
    options = { picker = 'snacks' },
  },
  keys = { { 'vs', '<cmd>VenvSelect<cr>' } },
}
