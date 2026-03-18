return {
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
  commands = {
    OrganizeImports = {
      function()
        local client = vim.lsp.get_clients({ bufnr = 0, name = 'ts_ls' })[1]

        if client then
          client:exec_cmd {
            title = 'Organize Imports',
            command = '_typescript.organizeImports',
            arguments = { vim.api.nvim_buf_get_name(0) },
          }
        end
      end,
      description = 'Organize Imports',
    },
  },
}
