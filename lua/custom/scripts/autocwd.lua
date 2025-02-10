local M = {}

M.setup = function()
  vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
      local arg = vim.fn.argv()[1] -- First argument passed to nvim
      if arg then
        local cwd = vim.fn.isdirectory(arg) == 1 and arg or vim.fn.fnamemodify(arg, ':p:h')
        vim.cmd('silent! cd ' .. cwd)
      end
    end,
  })
end

return M
