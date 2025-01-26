-- Which key
return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'

  opts = {
    delay = 300, -- default is 500ms
    -- Document existing key chains
    -- TODO: hunk seems to be new
    spec = {
      { '<leader>b', group = '[B]uffer' },
      { '<leader>c', group = '[C]ode' },
      { '<leader>d', group = '[D]ocument' },
      { '<leader>G', group = '[G]it' },
      { '<leader>g', group = '[G]rep' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>w', group = '[W]orkspace' },
    },
  },
}
