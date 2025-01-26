-- Highlight todo, notes, etc in comments
return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    signs = false,
    merge_keywords = true,
    highlight = {
      multiline = false,
    },
    keywords = {
      FIX = { icon = '', color = '#F200FF', alt = { 'FIXME', 'Fix', 'Fixme', 'fix', 'fixme' } },
      TODO = { icon = '', color = '#ff7c20', alt = { 'todo', 'Todo', 'TODO' } },
      INFO = { icon = 'i', color = '#8af5fd', alt = { 'info', 'INFO', 'Info' } },
      HACK = { icon = '', color = '#9d7cd8', alt = { 'hack', 'Hack' } },
      WARN = { icon = '', color = '#F200FF', alt = { 'WARNING', 'XXX', 'Warning', 'warning', 'Warn', 'warn' } },
      TEST = { icon = '⏲', color = '#00ff00', alt = { 'Test', 'TESTING', 'PASSED', 'FAILED' } },
      QUESTION = { icon = '', color = '#FFFF00', alt = { 'Question', 'QUESTION', 'Q', 'Help' } },
    },
  },

  -- define some colors for the todo comments
  -- config = function()
  --   require('todo-comments').setup {
  --     signs = false,
  --     keywords = {
  --       FIX = { icon = '', color = '#F200FF', alt = { 'FIXME', 'Fix', 'Fixme', 'fix', 'fixme' } },
  --       TODO = { icon = '', color = '#ff7c20', alt = { 'todo', 'Todo', 'TODO' } },
  --       INFO = { icon = 'i', color = '#8af5fd', alt = { 'info', 'INFO', 'Info' } },
  --       HACK = { icon = '', color = '#9d7cd8', alt = { 'hack', 'Hack' } },
  --       WARN = { icon = '', color = '#F200FF', alt = { 'WARNING', 'XXX', 'Warning', 'warning', 'Warn', 'warn' } },
  --       TEST = { icon = '⏲', color = '#00ff00', alt = { 'Test', 'TESTING', 'PASSED', 'FAILED' } },
  --     },
  --   }
  -- end,
}
