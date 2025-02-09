return {
  'linux-cultist/venv-selector.nvim',
  ft = { 'python' },
  dependencies = {
    'neovim/nvim-lspconfig',
    'mfussenegger/nvim-dap',
    'mfussenegger/nvim-dap-python',
    { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
  },
  branch = 'regexp', -- This is the regexp branch, use this for the new version
  config = function()
    local venv_selector = require 'venv-selector'

    --- @param venv_path string A string containing the absolute path to selected virtualenv
    --- @param venv_python string A string containing the absolute path to python binary in selected venv
    function ruff_hook(venv_path, venv_python)
      venv_selector.hooks.execute_for_client('ruff', function(client)
        if client.settings then
          client.settings = vim.tbl_deep_extend('force', client.settings, { python = { pythonPath = venv_python } })
        else
          client.config.settings = vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = venv_python } })
        end
        client.notify('workspace/didChangeConfiguration', { settings = nil })
      end)
    end

    venv_selector.setup {
      changed_venv_hooks = { ruff_hook },
    }
  end,

  keys = { { 'vs', '<cmd>VenvSelect<cr>' } },
}
