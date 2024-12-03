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
      'mfussenegger/nvim-dap-python', --optional
      { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
    },
    -- lazy = false,
    branch = 'regexp', -- This is the regexp branch, use this for the new version
    config = function()
      local opts = require 'custom.configs.venv-selector'
      require('venv-selector').setup {
        changed_venv_hooks = { opts.ruff_hook },
      }
    end,

    keys = { { 'vs', '<cmd>VenvSelect<cr>' } },
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('custom.configs.harpoon').setup()
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
}
