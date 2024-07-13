-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
--  See `:help vim.keymap.set()`

-- when in the terminal I want to use control+s to go into normal mode
vim.keymap.set('t', '<C-s>', '<C-\\><C-n>', { noremap = true })
-- split window with C-S
vim.keymap.set('n', '<C-S>', ':split<CR>', { noremap = true })
-- we swap a few keys so , is repeat and ; is command and : is repeat backwards
vim.keymap.set('n', ';', ':', { noremap = true })
vim.keymap.set('n', ',', ';', { noremap = true })
vim.keymap.set('n', ':', ',', { noremap = true })

-- remap HOME so it toggles between first non-blank and first column
vim.keymap.set('n', '<Home>', function()
  -- if we are on '^' go to first column
  local current_col = vim.fn.col '.'
  vim.cmd 'normal! ^'
  if vim.fn.col '.' == current_col then
    vim.cmd 'normal! 0'
  end
end, { noremap = true })

-- fix for concat line cursor position
vim.keymap.set('n', 'J', 'mzJ`z', { noremap = true })

-- keep search results centered
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true })

-- leader y to copy to clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { noremap = true })
vim.keymap.set('n', '<leader>Y', '"+Y', { noremap = true })
--same for pasting from clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { noremap = true })
vim.keymap.set('n', '<leader>P', '"+P', { noremap = true })

-- keep selection after indent
vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })

-- keep buffer after paste
vim.keymap.set('x', 'p', '"_dP', { noremap = true })

-- don't continue comments on new line
vim.keymap.set('n', 'o', 'oo<Esc>^"_Da', { noremap = true })
vim.keymap.set('n', 'O', 'Oo<Esc>^"_Da', { noremap = true })

-- insert new line at cursor position
vim.keymap.set('n', '<leader><CR>', 'i<CR><Esc>', { noremap = true })
-- open oil
vim.keymap.set('n', '-', ':Oil<CR>', { noremap = true })

-- move highlighted line up and down with alt arrow up and down instead of j and k
vim.keymap.set('n', '<A-up>', ':m .-2<CR>==', { noremap = true })
vim.keymap.set('n', '<A-down>', ':m .+1<CR>==', { noremap = true })
vim.keymap.set('v', '<A-up>', ":m '<-2<CR>gv=gv", { noremap = true })
vim.keymap.set('v', '<A-down>', ":m '>+1<CR>gv=gv", { noremap = true })

-- add shift for copy line up and down in normal and visual mode
vim.keymap.set('n', '<A-S-up>', ':t.<CR><up>', { noremap = true })
vim.keymap.set('n', '<A-S-down>', ':t.<CR>', { noremap = true })

-- copying blocks of text up and down
vim.keymap.set('v', '<A-S-up>', function()
  -- Get the starting and ending line numbers of the visual selection
  local start_line = vim.fn.line 'v'
  local end_line = vim.fn.line '.'
  -- Get the contents of the visual selection
  local selected_lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  -- Duplicate the visual selection
  vim.api.nvim_buf_set_lines(0, end_line, end_line, false, selected_lines)
end, { noremap = true })
-- same for down
vim.keymap.set('v', '<A-S-down>', function()
  -- Get the starting and ending line numbers of the visual selection
  local start_line = vim.fn.line 'v'
  local end_line = vim.fn.line '.'
  -- Get the contents of the visual selection
  local selected_lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  -- Duplicate the visual selection
  vim.api.nvim_buf_set_lines(0, start_line - 1, start_line - 1, false, selected_lines)
  vim.cmd 'undojoin'
end, { noremap = true })

local toggle_terminal = function()
  local term_buf = vim.fn.bufnr 'term://*:bash'
  if term_buf == -1 then
    -- if not found, open a new terminal and focus on it
    vim.cmd 'botright 22split term://bash'
    vim.api.nvim_feedkeys('i', 'n', true)
  else
    -- check if the terminal is focused
    local win_id = vim.fn.bufwinnr(term_buf)
    if win_id ~= -1 then
      -- if it is open, check if it is the currently focused window
      local current_win = vim.fn.win_getid()
      if current_win == vim.fn.win_getid(win_id) then
        -- if it is, close the terminal
        vim.cmd(win_id .. 'wincmd c')
      else
        -- if it is not, focus on the terminal
        vim.cmd(win_id .. 'wincmd w')
        -- go into terminal mode
        if vim.api.nvim_buf_get_option(term_buf, 'buflisted') then
          vim.cmd 'startinsert'
        end
      end
      -- vim.cmd(win_id .. 'wincmd c')
    else
      vim.cmd('split | buffer ' .. term_buf .. ' | resize 22')
      vim.api.nvim_feedkeys('i', 'n', true)
    end
  end
end

-- toggle my bash terminal in split bottom
vim.keymap.set({ 'n', 't' }, '<leader><Esc>', toggle_terminal, { desc = 'Toggle terminal' })
-- vim.keymap.set('t', '<leader>t', toggle_terminal, { desc = '[T]oggle terminal' })

-- NOTE: jump marks
local show_jumpmarks = false
if show_jumpmarks then
  vim.fn.sign_define('JumpMark5', { text = '5', texthl = 'Comment', linehl = '', numhl = '' })
  vim.fn.sign_define('JumpMark10', { text = '10', texthl = 'Comment', linehl = '', numhl = '' })
  vim.fn.sign_define('JumpMarkl', { text = '-', texthl = 'Comment', linehl = '', numhl = '' })
  local add_jump_signs = function()
    local current_buf = vim.fn.bufnr '%'
    local current_line = vim.fn.line '.'
    -- remove any existing jump signs by their name
    vim.fn.sign_unplace('JumpMark', { buffer = current_buf })
    vim.fn.sign_place(101, 'JumpMark', 'JumpMarkl', '', { lnum = current_line })
    for _, i in ipairs { -10, -5, 5, 10 } do
      -- add sign to gutter
      local this_line = current_line + i
      if this_line < 1 then
        -- skip if line is less than 1
        goto continue
      end
      if i == -5 or i == 5 then
        vim.fn.sign_place(101, 'JumpMark', 'JumpMark5', '', { lnum = this_line })
      else
        vim.fn.sign_place(101, 'JumpMark', 'JumpMark10', '', { lnum = this_line })
      end
      ::continue::
    end
  end
  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    desc = 'Add jump signs',
    callback = add_jump_signs,
  })
  vim.keymap.set('n', '<leader>j', add_jump_signs, { desc = '[J]ump sign' })
end

-- remap page up and down to half page up and down and center cursor
vim.keymap.set('n', '<PageUp>', '<C-u>zz', { noremap = true })
vim.keymap.set('n', '<PageDown>', '<C-d>zz', { noremap = true })
--
-- map leader Shift+s to save and close buffer on leader shift+enter
vim.keymap.set('n', '<leader><S-s>', ':w<CR>:bd<CR>', { desc = '[S]ave and close buffer' })

-- next buffer
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = '[b]uffer [n]ext' })
-- previous buffer
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { desc = '[b]uffer [p]revious' })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>L', vim.diagnostic.open_float, { desc = 'Show diagnostic Error messages [L]og' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a double <Esc>, not needed as leader t is used to toggle
-- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set('t', '<Esc><Esc>', function()
--   vim.defer_fn(function()
--     vim.cmd 'stopinsert'
--   end, 50)
--   toggle_terminal()
-- end, { noremap = true })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- also do this in terminal mode
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w><C-k>', { desc = 'Move focus to the upper window' })

local virtual_text_flag = true
-- toggle inline diagnostics virtual text
local toggle_diagnostics = function()
  -- flag to track if virtual text is enabled
  if virtual_text_flag then
    -- if it is, disable it
    vim.diagnostic.config { virtual_text = false }
    virtual_text_flag = false
    vim.notify 'Disabled inline diagnostics'
  else
    -- if it is not, enable it
    vim.diagnostic.config { virtual_text = true }
    virtual_text_flag = true
    vim.notify 'Enabled inline diagnostics'
  end
end

vim.keymap.set('n', '<leader>f', toggle_diagnostics, { desc = 'Toggle [L]SP inline diagnostics' })
