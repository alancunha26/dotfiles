return {
  'OXY2DEV/markview.nvim',
  lazy = false, -- Recommended
  ft = 'markdown', -- If you decide to lazy-load anyway
  enabled = false,

  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },

  opts = {
    hybrid_modes = { 'n' },
  },
}
