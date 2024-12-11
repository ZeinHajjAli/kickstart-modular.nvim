-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
  },
  {
    'windwp/nvim-ts-autotag',
    ft = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'html',
      'markdown',
      'astro',
    },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  {
    'tpope/vim-fugitive',
    lazy = false,
  },
  { 'wakatime/vim-wakatime', lazy = false },
  {
    'linux-cultist/venv-selector.nvim',
    ft = { 'python' },
    dependencies = {
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      'mfussenegger/nvim-dap-python',
      { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
    },
    branch = 'regexp', -- This is the regexp branch, use this for the new version
    config = function()
      require 'custom.configs.venv-selector'
    end,

    keys = { { 'vs', '<cmd>VenvSelect<cr>' } },
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'custom.configs.harpoon'
    end,
  },
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup {
        mappings = {
          '<C-u>',
          '<C-d>',
          '<C-b>',
          '<C-f>',
        },
        duration_multiplier = 0.7,
        easing = 'linear',
      }
    end,
  },
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require 'custom.configs.oil'
    end,
  },
  {
    'numToStr/Comment.nvim',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    config = function()
      require 'custom.configs.comment'
    end,
  },
  {
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
  },
  {
    'sphamba/smear-cursor.nvim',
    opts = {
      smear_between_buffers = false,
      -- smear_between_neighbor_lines = true,
      legacy_computing_symbols_support = true,
      stiffness = 0.8,
      trailing_stiffness = 0.5,
      distance_stop_animating = 0.5,
      hide_target_hack = false,
    },
  },
  {
    'stevearc/dressing.nvim',
    opts = {
      input = {
        enabled = false,
      },
    },
  },
}
