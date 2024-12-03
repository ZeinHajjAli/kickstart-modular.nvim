local M = {}

local venv_selector = require 'venv-selector'

--- @param venv_path string A string containing the absolute path to selected virtualenv
--- @param venv_python string A string containing the absolute path to python binary in selected venv
function M.ruff_hook(venv_path, venv_python)
  venv_selector.hooks.execute_for_client('ruff', function(client)
    if client.settings then
      client.settings = vim.tbl_deep_extend('force', client.settings, { python = { pythonPath = venv_python } })
    else
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = venv_python } })
    end
    client.notify('workspace/didChangeConfiguration', { settings = nil })
  end)
end

return M
