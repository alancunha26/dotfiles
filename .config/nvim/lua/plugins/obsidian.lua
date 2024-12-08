return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    workspaces = {
      {
        name = 'Notes',
        path = '~/Documents/Notes',
      },
      {
        name = 'Alan.md',
        path = '~/Documents/Alan.md',
      },
    },
    ui = {
      enable = false,
    },

    preferred_link_style = 'markdown',
  },
}
