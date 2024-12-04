return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "vim",
      "lua",
      "vimdoc",
      "markdown",
      "markdown_inline",
      "html",
      "css",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = {
        "markdown",
      },
    },
  },
}
