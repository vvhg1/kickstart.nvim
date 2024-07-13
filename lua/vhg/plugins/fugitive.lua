
  -- fugitive
  return {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>Gs', ':Git<CR>', { desc = '[G]it [S]tatus' })
      vim.keymap.set('n', '<leader>Gd', ':Gvdiffsplit<CR>', { desc = '[G]it [D]iff' })
      -- remap : to ;
      vim.keymap.set('n', '<leader>Gp', ':diffput<CR>', { desc = '[G]it [P]ut' })
    end,
  }
