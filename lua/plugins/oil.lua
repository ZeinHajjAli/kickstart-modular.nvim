return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local detail = false
    require('oil').setup {
      columns = {
        'icon',
      },
      keymaps = {
        ['<C-h>'] = false,
        ['<C-l>'] = false,
        ['gd'] = {
          desc = 'Toggle file detail view',
          callback = function()
            detail = not detail
            if detail then
              require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
            else
              require('oil').set_columns { 'icon' }
            end
          end,
        },
      },
      view_options = {
        show_hidden = true,
      },
    }

    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end,
}
