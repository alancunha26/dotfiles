return {
  'hedyhli/outline.nvim',
  config = function()
    require('outline').setup {
      outline_window = {
        width = 20,
      },
    }

    vim.keymap.set('n', '<leader>o', '<cmd>Outline<CR>', { desc = 'Toggle [O]utline' })
  end,
}
