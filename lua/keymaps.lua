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

-- Diagnostic keymaps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
map('n', '<left>', '<cmd>echo ""<cr>')
map('n', '<right>', '<cmd>echo ""<cr>')
map('n', '<up>', '<cmd>echo ""<CR>')
map('n', '<down>', '<cmd>echo ""<CR>')

-- Split window commands
map('n', '<leader>%', ':vsplit<CR>', { desc = 'Split Vertically' })
map('n', '<leader>"', ':split<CR>', { desc = 'Split Horizontally' })

-- Reset tmux navigator mappings
vim.g.tmux_navigator_no_mappings = 1

-- Reusable tmux navigator mappings
local set_tmux_navigator_keymaps = function()
  map({ 'n', 'i', 'v', 't' }, '<C-h>', '<cmd> TmuxNavigateLeft<CR>', { desc = 'Window Left' })
  map({ 'n', 'i', 'v', 't' }, '<C-l>', '<cmd> TmuxNavigateRight<CR>', { desc = 'Window Right' })
  map({ 'n', 'i', 'v', 't' }, '<C-j>', '<cmd> TmuxNavigateDown<CR>', { desc = 'Window Down' })
  map({ 'n', 'i', 'v', 't' }, '<C-k>', '<cmd> TmuxNavigateUp<CR>', { desc = 'Window Up' })
end

-- Set once globally
set_tmux_navigator_keymaps()
-- Set again for terminal buffers to prevent literal command injection
vim.api.nvim_create_autocmd('TermOpen', {
  callback = set_tmux_navigator_keymaps,
})

-- Split sizing commands
local optKey = 'A'
if vim.loop.os_uname().sysname == 'Darwin' then
  optKey = 'M'
end

map('n', '<' .. optKey .. '-,>', '<C-W>5<', { desc = 'Shrink current split horizontally' })
map('n', '<' .. optKey .. '-.>', '<C-W>5>', { desc = 'Grow current split horizontally' })
map('n', '<' .. optKey .. '-j>', '<C-W>+', { desc = 'Grow current split vertically' })
map('n', '<' .. optKey .. '-k>', '<C-W>-', { desc = 'Shrink current split vertically' })

-- Split sizing commands for terminals (for use with Claude Code)
map('t', '<' .. optKey .. '-,>', [[<C-\><C-n><C-W>5<i]], { desc = 'Shrink current split horizontally' })
map('t', '<' .. optKey .. '-.>', [[<C-\><C-n><C-W>5>i]], { desc = 'Grow current split horizontally' })
map('t', '<' .. optKey .. '-j>', [[<C-\><C-n><C-W>+i]], { desc = 'Grow current split vertically' })
map('t', '<' .. optKey .. '-k>', [[<C-\><C-n><C-W>-i]], { desc = 'Shrink current split vertically' })

-- Claudeplz development reload
map('n', '<leader>rr', function()
  for k in pairs(package.loaded) do
    if k:match '^claudeplz' then
      package.loaded[k] = nil
    end
  end
  require('claudeplz').setup()
  vim.notify('claudeplz reloaded', vim.log.levels.INFO)
end, { desc = 'Reload claudeplz' })

-- Temporary comment commands
map('n', 'gct', function()
  vim.cmd 'normal! yy'
  require('Comment.api').toggle.linewise.current()
  vim.cmd 'normal! p'
end, { noremap = true, silent = true })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
