-- rainbow delimiters
return {
  'HiPhish/rainbow-delimiters.nvim',
  config = function()
    require('rainbow-delimiters.setup').setup {
      highlight = {
        'RainbowDelimiterFuchs',
        'RainbowDelimiterBlu',
        'RainbowDelimiterYel',
        'RainbowDelimiterGre',
      },
    }
  end,
}
