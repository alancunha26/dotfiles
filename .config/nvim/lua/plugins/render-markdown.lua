-- https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/114
return {
  'MeanderingProgrammer/render-markdown.nvim',
  enabled = false,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    { 'nvim-tree/nvim-web-devicons', enbled = vim.g.have_nerd_font },
  },
  opts = {
    sign = {
      enabled = false,
    },
    pipe_table = {
      enabled = false,
    },
    -- link = {
    --   enabled = false,
    -- },
    -- quote = {
    --   repeat_linebreak = true,
    -- },
    -- checkbox = {
    --   enabled = false,
    -- },
    -- win_options = {
    --   conceallevel = { rendered = 0 },
    -- },
  },
}
