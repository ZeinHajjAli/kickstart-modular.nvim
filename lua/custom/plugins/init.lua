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
  -- {
  --   'mrcjkb/rustaceanvim',
  --   version = '^7',
  --   lazy = false,
  -- },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'catppuccin',
        },
      }
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    '3rd/image.nvim',
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    opts = {
      processor = 'magick_cli',
    },
  },
  -- {
  --   'amitds1997/remote-nvim.nvim',
  --   version = '*', -- Pin to GitHub releases
  --   dependencies = {
  --     'nvim-lua/plenary.nvim', -- For standard functions
  --     'MunifTanjim/nui.nvim', -- To build the plugin UI
  --     'nvim-telescope/telescope.nvim', -- For picking b/w different remote methods
  --   },
  --   config = true,
  -- },
}
