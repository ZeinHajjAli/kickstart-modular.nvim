-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Enable mouse mode, can be useful for resizing splits for example!
-- vim.opt.mouse = 'a'

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Enable folding using treesitter expression
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99

vim.filetype.add {
  filename = {
    ['docker-compose.yml'] = 'yaml.docker-compose',
    ['docker-compose.yaml'] = 'yaml.docker-compose',
    ['compose.yml'] = 'yaml.docker-compose',
    ['compose.yaml'] = 'yaml.docker-compose',
  },
}

-- vim: ts=2 sts=2 sw=2 et
