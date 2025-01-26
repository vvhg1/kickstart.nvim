return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  dependencies = {
    -- Treesitter textobjects
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  opts = {
    ensure_installed = { 'python', 'json', 'jsonc', 'markdown', 'css', 'javascript', 'typescript', 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          ['if'] = { query = '@function.inner', desc = 'Select inner part of a function' },
          ['af'] = { query = '@function.outer', desc = 'Select outer part of a function' },
          ['al'] = { query = '@loop.outer', desc = 'Select loop region' },
          ['il'] = { query = '@loop.inner', desc = 'Select inner part of a loop' },
          ['am'] = { query = '@call.outer', desc = 'Select call region' },
          ['im'] = { query = '@call.inner', desc = 'Select inner part of a call' },
          ['vl'] = { query = '@assignment.lhs', desc = 'Select left-hand side of an assignment' },
          ['vr'] = { query = '@assignment.rhs', desc = 'Select right-hand side of an assignment' },
          ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
          ['ac'] = { query = '@class.outer', desc = 'Select class region' },
          ['ai'] = { query = '@conditional.outer', desc = 'Select conditional region' },
          ['ii'] = { query = '@conditional.inner', desc = 'Select inner part of a conditional' },
          -- You can also use captures from other query groups like `locals.scm`
          ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
        },
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        -- selection_modes = {
        -- ['@parameter.outer'] = 'v', -- charwise
        -- ['@function.outer'] = 'V', -- linewise
        -- ['@class.outer'] = '<c-v>', -- blockwise
        -- },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * selection_mode: eg 'v'
        -- and should return true or false
        -- include_surrounding_whitespace = true,
      },
    },
  },
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
