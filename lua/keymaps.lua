-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Map ';' to ':' to enter command mode more easily from normal mode
vim.keymap.set('n', ';', ':')

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo ""<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo ""<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo ""<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo ""<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Split window commands
vim.keymap.set('n', '<leader>%', ':vsplit<CR>', { desc = 'Split Vertically' })
vim.keymap.set('n', '<leader>"', ':split<CR>', { desc = 'Split Horizontally' })

-- vim tmux navigator commands
vim.keymap.set({ 'n', 'i', 'v' }, '<C-h>', '<cmd> TmuxNavigateLeft<CR>', { desc = 'Window Left' })
vim.keymap.set({ 'n', 'i', 'v' }, '<C-l>', '<cmd> TmuxNavigateRight<CR>', { desc = 'Window Right' })
vim.keymap.set({ 'n', 'i', 'v' }, '<C-j>', '<cmd> TmuxNavigateDown<CR>', { desc = 'Window Down' })
vim.keymap.set({ 'n', 'i', 'v' }, '<C-k>', '<cmd> TmuxNavigateUp<CR>', { desc = 'Window Up' })

-- netrw commands
-- vim.keymap.set('n', '<leader>pp', ':Explore<CR>', { desc = 'Open NetRW Explorer Window' })
-- vim.keymap.set('n', '<leader>pv', ':30Vexplore<CR>', { desc = 'Open NetRW Explorer Window (Vertical Split)' })
-- vim.keymap.set('n', '<leader>ph', ':30Hexplore<CR>', { desc = 'Open NetRW Explorer Window (Horizontal Split)' })
-- vim.keymap.set('n', '<leader>pd', ':30Lexplore<CR>', { desc = 'Open NetRW Explorer Drawer' })

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
