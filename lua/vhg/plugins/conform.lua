return { -- Autoformat
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = false, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      json = { 'jq' },
      c = { 'clang-format' },
      sh = { 'shfmt' },
      -- Conform can also run multiple formatters sequentially
      python = { 'ruff_imports', 'ruff_check_fix', 'ruff_format' },
      -- python = { 'isort', 'ruff_check_fix', 'ruff_format' },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- javascript = { { "prettierd", "prettier" } },
    },
    formatters = {
      ruff_format = { command = 'ruff', args = { 'format' }, stdin = false },
      ruff_check_fix = { command = 'ruff', args = { 'check', '--fix' }, stdin = false },
      ruff_imports = { command = 'ruff', args = { 'check', '--select', 'I', '--fix' }, stdin = false },
    },
  },
}
