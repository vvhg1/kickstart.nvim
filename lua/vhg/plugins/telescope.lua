-- Telescope
return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for install instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of help_tags options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    local actions = require 'telescope.actions'
    local finders = require 'telescope.finders'
    local pickers = require 'telescope.pickers'
    local previewers = require 'telescope.previewers'
    local sorters = require 'telescope.sorters'
    local make_entry = require 'telescope.make_entry'
    local conf = require('telescope.config').values
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      defaults = {
        layout_strategy = 'flex',
        layout_config = {
          flex = {
            flip_columns = 220,
            vertical = {
              mirror = true,
              -- prompt_position = 'top',
            },
            -- height = 0.9,
          },
          --   mappings = {
          --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
          --   },
        },
      },
      pickers = {
        buffers = {
          -- additional_params = function()
          -- return {
          -- we want to filter out terminal buffers term://
          -- 'term://',
          -- }
          -- end,
          mappings = {
            n = {
              ['dd'] = actions.delete_buffer,
            },
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sF', function()
      require('telescope.builtin').find_files {
        hidden = true,
        find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/*' },
      }
    end, { desc = '[S]earch [H]idden files excluding .git' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    -- finding cword and cWORD
    vim.keymap.set('n', '<leader>gw', function()
      local word = vim.fn.expand '<cword>'
      builtin.grep_string { search = word }
    end, { desc = '[g]rep [w]ord' })
    vim.keymap.set('n', '<leader>gW', function()
      local word = vim.fn.expand '<cWORD>'
      builtin.grep_string { search = word }
    end, { desc = '[g]rep [W]ORD' })
    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- Also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- live grep over all files in pwd
    vim.keymap.set('n', '<leader>gg', function()
      builtin.live_grep {
        search_dirs = { vim.fn.getcwd() },
        prompt_title = 'Live Grep in ' .. vim.fn.getcwd(),
      }
    end, { desc = '[S]earch [A]ll workspace files' })
    -- Shortcut for searching your neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })

    -- custom telescope multi live grep
    local live_multi_grep = function(opts)
      opts = opts or {}
      opts.cwd = opts.cwd or vim.fn.getcwd()
      local finder = finders.new_async_job {
        command_generator = function(prompt)
          if not prompt or prompt == '' then
            return nil
          end

          local search_strings = vim.split(prompt, '  ')
          local args = { 'rg' }
          if search_strings[1] then
            table.insert(args, '-e')
            table.insert(args, search_strings[1])
          end

          if search_strings[2] then
            table.insert(args, '-g')
            table.insert(args, search_strings[2])
          end

          return vim.tbl_flatten {
            args,
            { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' },
          }
        end,
        entry_maker = make_entry.gen_from_vimgrep(opts),
        cwd = opts.cwd,
      }
      pickers
        .new(opts, {
          debounce = 100,
          prompt_title = 'Live Multi Grep',
          finder = finder,
          previewer = conf.grep_previewer(opts),
          sorter = sorters.empty(),
        })
        :find()
    end
    vim.keymap.set('n', '<leader>gl', live_multi_grep, { desc = '[S]earch [L]ive Multi Grep' })
  end,
}
