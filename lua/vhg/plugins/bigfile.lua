return {
  'LunarVim/bigfile.nvim',
  event = 'BufReadPre',
  opts = {
    file_size = 5,
  },
  config = function(_, opts)
    require('bigfile').setup(opts)
  end,
}
