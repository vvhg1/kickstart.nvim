-- get Chainsaw
return {
  'vvhg1/nvim-chainsaw',
  opts = {},
  config = function()
    require('chainsaw').setup {
      marker = '🪚',
      beepEmojis = { '🔵', '🟩', '⭐', '⭕', '💜', '🔲' },
      logStatements = {
        variableLog = {
          -- javascript = 'console.log("%s %s:", %s);',
          nvim_lua = 'print("%s %s:", %s)',
          c = 'printf("%s %s: placeholder \\n", %s);',
        },
      },
    }
    vim.keymap.set({ 'n', 'v' }, '<leader>l', function()
      require('chainsaw').variableLog()
      -- correct indentation
      vim.cmd 'norm =='
    end, { desc = 'insert log/print statement' })
  end,
}
