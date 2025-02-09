return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true, folds = { open = true } },
    -- words = { enabled = true },
    scratch = { enabled = true },
    dashboard = { enabled = true },
    indent = { enabled = true, scope = { animate = { enabled = false } } },
    input = { enabled = true },
    zen = { enabled = true },
    -- dim = { enabled = true },
  },
  keys = {
    {
      '<leader>.',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>S',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select Scratch Buffer',
    },
    {
      '<leader>zm',
      function()
        Snacks.zen()
      end,
      desc = 'Toggle [Z]en [M]ode',
    },
  },
}
