local M = {}

M.setup = function()
  require('oil').setup {
    columns = {
      'icon',
      'permissions',
      'size',
      'mtime',
    },
    keymaps = {
      ['<C-h>'] = false,
      ['<C-l>'] = false,
    },
    view_options = {
      show_hidden = true,
    },
  }

  vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
end

return M
