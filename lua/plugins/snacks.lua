return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true, folds = { open = true } },
    scratch = { enabled = true },
    dashboard = { enabled = true },
    indent = { enabled = true, scope = { animate = { enabled = false } } },
    input = { enabled = true },
    zen = { enabled = true },
    picker = {
      enabled = true,
      main = {
        current = true,
      },
      filter = {
        cwd = true,
      },
      win = {
        input = {
          keys = {
            ['<S-Tab>'] = { 'list_up', mode = { 'i', 'n' } },
            ['<Tab>'] = { 'list_down', mode = { 'i', 'n' } },
          },
        },
      },
    },
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
    {
      '<leader>sf',
      function()
        Snacks.picker.smart()
      end,
      desc = '[S]earch [F]iles',
    },
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = '[S]earch [H]elp',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = '[S]earch [K]eymaps',
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.grep()
      end,
      desc = '[S]earch by [G]rep',
    },
    {
      '<leader>sr',
      function()
        Snacks.picker.resume()
      end,
      desc = '[S]earch [R]esume',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.lines()
      end,
      desc = '[/] Fuzzily search in current buffer',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = '[S]earch [D]iagnostics',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = '[S]earch current [W]ord',
      mode = { 'n', 'x' },
    },
    {
      '<leader>sm',
      function()
        Snacks.picker.man()
      end,
      desc = '[S]earch [M]an pages',
    },
    {
      '<leader>ss',
      function()
        Snacks.picker.pickers()
      end,
      desc = '[S]earch [S]elect picker',
    },
    {
      '<leader>p',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Find existing buffers',
    },
    {
      '<leader>s.',
      function()
        Snacks.picker.recent()
      end,
      desc = '[S]earch Recent Files ("." for repeat)',
    },
    {
      '<leader>s/',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = '[S]earch [/] in Open Files',
    },
    {
      '<leader>sn',
      function()
        local config_path = vim.fn.stdpath 'config'
        if type(config_path) == 'table' then
          config_path = config_path[1]
        end
        Snacks.picker.files { cwd = config_path }
      end,
      desc = '[S]earch [N]eovim files',
    },
    {
      '<leader>gl',
      function()
        Snacks.picker.git_log()
      end,
      desc = '[G]it [L]og',
    },
    {
      '<leader>gs',
      function()
        Snacks.picker.git_status()
      end,
      desc = '[G]it [S]tatus',
    },
    {
      '<leader>gb',
      function()
        Snacks.picker.git_branches()
      end,
      desc = '[G]it [B]ranches',
    },
  },
}
