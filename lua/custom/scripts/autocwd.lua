local M = {}

M.setup = function()
  vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
      local arg = vim.fn.argv()[1] -- First argument passed to nvim
      if arg then
        local cwd = vim.fn.isdirectory(arg) == 1 and arg or vim.fn.fnamemodify(arg, ':p:h')
        vim.cmd('silent! cd ' .. cwd)
      end

      -- Handle Oil compatibility
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'oil',
        once = true,
        callback = function()
          local oil_path = vim.fn.expand '%:p:h'
          local real_path = oil_path:gsub('^oil[%+%-]?%w*://', '')
          if vim.fn.isdirectory(real_path) == 1 then
            vim.cmd('cd ' .. real_path)
          else
            vim.notify('Unable to set cwd: invalid directory path', vim.log.levels.WARN)
          end
        end,
      })
    end,
  })
end

return M
