require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "K", vim.lsp.buf.hover, { desc = "LSP hover symbol under cursor" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "CMD save current file" })
map("n", "<leader>to", function()
  require("base46").toggle_transparency()
end, { desc = "Toggle transparency" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
