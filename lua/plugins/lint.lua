return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPost', 'BufWritePost', 'InsertLeave' },
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      bash = { 'shellcheck' },
      -- python = { 'flake8', 'mypy', 'codespell' },
      sh = { 'shellcheck' },
    }

    lint.linters.flake8.cmd = 'flake8'

    vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
