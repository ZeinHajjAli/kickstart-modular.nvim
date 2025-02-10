-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Quicker map function
local map = function(mode, keys, func, opts)
  opts = opts or {}
  vim.keymap.set(mode, keys, func, opts)
end

-- Map ';' to ':' to enter command mode more easily from normal mode
map('n', ';', ':')

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
map('n', '<left>', '<cmd>echo ""<cr>')
map('n', '<right>', '<cmd>echo ""<cr>')
map('n', '<up>', '<cmd>echo ""<CR>')
map('n', '<down>', '<cmd>echo ""<CR>')

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ VSCode Keybindings ]]
local vscode = require 'vscode'

map('n', '<leader>sf', function()
  vscode.action 'workbench.action.quickOpen'
end, { noremap = true, silent = true })

map('n', '<leader>sg', function()
  vscode.action 'workbench.view.search'
end, { noremap = true, silent = true })

map('n', '<leader>ca', function()
  vscode.action 'editor.action.quickFix'
end, { noremap = true, silent = true })

map('n', '<leader>f', function()
  vscode.action 'editor.action.formatDocument'
end, { noremap = true, silent = true })

map('n', '<leader>%', function()
  vscode.action 'workbench.action.splitEditor'
end, { noremap = true, silent = true })

-- vim: ts=2 sts=2 sw=2 et
