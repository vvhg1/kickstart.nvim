-- Lua Line
return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = {
          {
            'filename',
          },
        },
        lualine_b = {
          {
            'branch',
            color = { bg = '#292e42' },
          },
          {
            'diff',
            color = { bg = '#292e42' },
          },
          {
            'diagnostics',
            color = { bg = '#292e42' },
          },
        },
        lualine_c = {
          {
            'filename',
            file_status = false,
            path = 1,
          },
        },
        lualine_y = {
          {
            'progress',
            color = { bg = '#292e42' },
          },
        },
        lualine_z = {
          'searchcount',
          {
            function()
              return vim.fn.line '.'
            end,
          },
        },
      },
    }
  end,
}
