return {
  'folke/zen-mode.nvim',
  config = function()
    require('zen-mode').setup {
      window = {
        backdrop = 0.95,
        width = 80, -- width of the Zen window
        height = 1, -- height of the Zen window
        options = {
          number = false, -- disable number column
          signcolumn = 'no', -- disable signcolumn
          relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        options = {
          enabled = true,
          showcmd = false, -- disables the command in the last line of the screen
          laststatus = 0, -- turn off the statusline in zen mode
          ruler = true, -- disables the ruler text in the cmd line area
        },
        gitsigns = { enabled = false }, -- disables git signs
      },
    }

    vim.keymap.set('n', '<leader>z', ':ZenMode<CR>', { desc = '[Z]en Mode' })
  end,
}
