-- Harpoon
return {
  'ThePrimeagen/harpoon',
  opts = {},
  config = function()
    require('harpoon').setup()
    -- set up harpoon
    local mark = require 'harpoon.mark'
    local ui = require 'harpoon.ui'
    vim.keymap.set('n', '<leader>a', mark.add_file, { desc = '[a]dd file to harpoon' })
    vim.keymap.set('n', '<leader>h', ui.toggle_quick_menu, { desc = 'toggle [h]arpoon' })
    -- navigate files with harpoon and center cursor
    vim.keymap.set('n', '<leader>n', function()
      ui.nav_file(1)
      vim.cmd 'norm zz'
    end, { desc = '[nn]avigate first, index finger, harpoon' })
    vim.keymap.set('n', '<leader>e', function()
      ui.nav_file(2)
      vim.cmd 'norm zz'
    end, { desc = '[n]avigate s[e]cond, middle finger, harpoon' })
    vim.keymap.set('n', '<leader>i', function()
      ui.nav_file(3)
      vim.cmd 'norm zz'
    end, { desc = '[n]avigate th[i]rd, ring finger, harpoon' })
    vim.keymap.set('n', '<leader>o', function()
      ui.nav_file(4)
      vim.cmd 'norm zz'
    end, { desc = '[n]avigate f[o]urth, pinky, harpoon' })
  end,
}
