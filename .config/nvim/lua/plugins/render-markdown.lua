-- https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/114
return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    { 'nvim-tree/nvim-web-devicons', enbled = vim.g.have_nerd_font },
  },
  opts = {
    sign = {
      enabled = false,
    },
    link = {
      enabled = false,
    },
    quote = {
      repeat_linebreak = true,
    },
    win_options = {
      conceallevel = { rendered = 0 },
    },
  },
}
