-- treesitter context
return {
  'nvim-treesitter/nvim-treesitter-context',
  after = 'nvim-treesitter',
  config = function()
    require('treesitter-context').setup {
      enable = true,
      multiline_threshold = 1,
    }
  end,
}
