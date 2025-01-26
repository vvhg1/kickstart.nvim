return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '│' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    on_attach = function()
      local gs = package.loaded.gitsigns
      vim.keymap.set('n', '<leader>Gb', gs.toggle_current_line_blame, { desc = '[G]it [b]lame toggle' })
    end,
  },
}
