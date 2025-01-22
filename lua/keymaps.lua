-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Quicker map function
local map = function(mode, keys, func, opts)
  opts = opts or {}
  vim.keymap.set(mode, keys, func, opts)
end

-- Map ';' to ':' to enter command mode more easily from normal mode
map('n', ';', ':')

-- A quick 'jk', or 'kj' in insert mode goes to normal mode
-- map('i', 'jk', '<Esc>')
-- map('i', 'kj', '<Esc>')

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
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
map('n', '<left>', '<cmd>echo ""<cr>')
map('n', '<right>', '<cmd>echo ""<cr>')
map('n', '<up>', '<cmd>echo ""<CR>')
map('n', '<down>', '<cmd>echo ""<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Split window commands
map('n', '<leader>%', ':vsplit<CR>', { desc = 'Split Vertically' })
map('n', '<leader>"', ':split<CR>', { desc = 'Split Horizontally' })

-- vim tmux navigator commands
map({ 'n', 'i', 'v' }, '<C-h>', '<cmd> TmuxNavigateLeft<CR>', { desc = 'Window Left' })
map({ 'n', 'i', 'v' }, '<C-l>', '<cmd> TmuxNavigateRight<CR>', { desc = 'Window Right' })
map({ 'n', 'i', 'v' }, '<C-j>', '<cmd> TmuxNavigateDown<CR>', { desc = 'Window Down' })
map({ 'n', 'i', 'v' }, '<C-k>', '<cmd> TmuxNavigateUp<CR>', { desc = 'Window Up' })

-- netrw commands
-- map('n', '<leader>pp', ':Explore<CR>', { desc = 'Open NetRW Explorer Window' })
-- map('n', '<leader>pv', ':30Vexplore<CR>', { desc = 'Open NetRW Explorer Window (Vertical Split)' })
-- map('n', '<leader>ph', ':30Hexplore<CR>', { desc = 'Open NetRW Explorer Window (Horizontal Split)' })
-- map('n', '<leader>pd', ':30Lexplore<CR>', { desc = 'Open NetRW Explorer Drawer' })

-- Split sizing commands
-- map('n', '<M-,>', '<C-W>5<')
-- map('n', '<M-.>', '<C-W>5>')
-- map('n', '<M-j>', '<C-W>+')
-- map('n', '<M-k>', '<C-W>-')

-- Temporary comment commands
map('n', 'gct', function()
  vim.cmd 'normal! yy'
  require('Comment.api').toggle.linewise.current()
  vim.cmd 'normal! p'
end, { noremap = true, silent = true })

-- map('v', 'gct', ':y<CR>gvgcp')

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

-- vim: ts=2 sts=2 sw=2 et
