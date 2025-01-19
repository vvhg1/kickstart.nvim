-- Oil.nvim
return {
  'stevearc/oil.nvim',
  config = function()
    require('oil').setup {
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      git = {
        add = function(path)
          return false
        end,
        mv = function(src_path, dest_path)
          return true
        end,
        rm = function(path)
          return false
        end,
      },
    }
  end,
}
