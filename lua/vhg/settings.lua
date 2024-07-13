-- Global var for python
-- python3_host_prog = '/usr/bin/python3'

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- set the height of the command line at the bottom (there is a bug with 0)
-- vim.opt.cmdheight = 0

-- INFO: color settings
vim.api.nvim_set_hl(0, 'indentguides', { fg = '#272730' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterFuchs', { fg = '#c869be' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterBlu', { fg = '#1894e2' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterYel', { fg = '#eac805' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterGre', { fg = '#80dc70' })
-- vim.api.nvim_set_hl(0, 'RainbowDelimiterPur', { fg = '#af00ff' })
