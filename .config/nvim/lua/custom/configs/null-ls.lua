local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local sources = {
  -- Lua
  formatting.stylua,

  -- cpp
  formatting.clang_format,

  -- typescript/javascript
  -- b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  formatting.prettier.with {
    filetypes = {
      "html",
      "markdown",
      "css",
      "typescript",
      "javascript",
      "scss",
      "sass",
    },
  },
  diagnostics.eslint_d.with {
    condition = function(utils)
      return utils.root_has_file ".eslintrc.js" or utils.root_has_file ".eslintrc.json"
    end,
  },
}

local on_attach = function(current_client, bufnr)
  if current_client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format {
          filter = function(client)
            --  only use null-ls for formatting instead of lsp server
            return client.name == "null-ls"
          end,
          bufnr = bufnr,
        }
      end,
    })
  end
end

null_ls.setup {
  debug = true,
  sources = sources,
  on_attach = on_attach,
}
