return {
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
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'gruvbox-material',
        },
      }
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
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
}
