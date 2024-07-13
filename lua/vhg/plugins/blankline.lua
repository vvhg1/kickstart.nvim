-- blankline, this shows the indent lines and is color matched to the rainbow delimiters
return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = {
    debounce = 250,
    indent = {
      -- highlight = { 'indentguides' },
      char = '│',
      smart_indent_cap = true,
    },
    scope = {
      highlight = {
        'RainbowDelimiterFuchs',
        'RainbowDelimiterBlu',
        'RainbowDelimiterYel',
        'RainbowDelimiterGre',
      },
      show_start = false,
      show_end = false,
      char = '│',
      -- char = '│',
      include = {
        node_type = {
          python = { 'while_statement', 'if_statement', 'for_statement', 'with_statement', 'expression_statement' },
          lua = { 'table_constructor' },
        },
      },
    },
  },
  config = function(_, opts)
    require('ibl').setup(opts)
    local hooks = require 'ibl.hooks'
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
