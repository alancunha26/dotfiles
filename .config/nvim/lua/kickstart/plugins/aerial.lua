return {
  'stevearc/aerial.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('aerial').setup {
      manage_folds = true,

      layout = {
        width = 40,
      },

      -- optionally use on_attach to set keymaps when aerial has attached to a buffer
      -- on_attach = function(bufnr)
      --   -- Jump forwards/backwards with '{' and '}'
      --   vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
      --   vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
      -- end,
    }
    -- You probably also want to set a keymap to toggle aerial
    vim.keymap.set('n', '<leader>o', '<cmd>AerialToggle!<CR>')
  end,
}
