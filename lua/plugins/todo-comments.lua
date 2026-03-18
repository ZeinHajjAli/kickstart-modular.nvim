-- Highlight todo, notes, etc in comments
return {
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
    keys = {
      {
        '<leader>td',
        function()
          Snacks.picker.todo_comments()
        end,
        desc = 'All [T]o[D]os',
      },
      {
        '<leader>T',
        function()
          Snacks.picker.todo_comments { keywords = { 'TODO', 'FIX', 'FIXME' } }
        end,
        desc = '[T]o[D]o comments',
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
