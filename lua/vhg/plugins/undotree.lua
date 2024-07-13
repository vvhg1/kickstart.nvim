-- UndoTree
return {
  'mbbill/undotree',
  opts = {},
  config = function()
    -- we want to toggle and if open, focus on the window
    vim.keymap.set('n', '<leader>u', function()
      vim.cmd 'UndotreeToggle'
      if vim.fn.bufwinnr 'undotree' ~= -1 then
        vim.cmd 'wincmd p'
      end
    end, { desc = '[U]ndo tree' })
  end,
}
