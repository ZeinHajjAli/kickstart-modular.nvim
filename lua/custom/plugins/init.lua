-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
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
}
