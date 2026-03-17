return {
  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    config = function()
      -- vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_cursor = 'auto'
      -- vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_dim_inactive_windows = 1
      -- vim.g.gruvbox_material_sign_column_background = 'linenr'
      -- vim.g.gruvbox_material_ui_contrast = 'high'
      vim.g.gruvbox_material_current_word = 'high contrast background'
      vim.g.gruvbox_material_enable_italic = true

      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
