return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      css = { "prettier" },
      html = { "prettier" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
    },

    format_on_save = {
      -- These options will be passed to conform.format()
      -- async = true,
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
