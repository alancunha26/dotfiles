return {
  'zk-org/zk-nvim',
  enabled = true,
  config = function()
    require('zk').setup {
      -- can be "telescope", "fzf", "fzf_lua", "minipick", or "select" (`vim.ui.select`)
      -- it's recommended to use "telescope", "fzf", "fzf_lua", or "minipick"
      picker = 'telescope',

      lsp = {
        -- `config` is passed to `vim.lsp.start_client(config)`
        config = {
          cmd = { 'zk', 'lsp' },
          name = 'zk',
          -- on_attach = ...
          -- etc, see `:h vim.lsp.start_client()`
        },

        -- automatically attach buffers in a zk notebook that match the given filetypes
        auto_attach = {
          enabled = true,
          filetypes = { 'markdown' },
        },
      },
    }

    vim.keymap.set('n', '<leader>zn', "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", { desc = '[N]ew Note' })
    vim.keymap.set('v', '<leader>zn', ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", { desc = '[N]ew Note From Selection' })
    vim.keymap.set('n', '<leader>zb', '<Cmd>ZkBacklinks<CR>', { desc = 'Search [B]acklinks' })
    vim.keymap.set('n', '<leader>zl', '<Cmd>ZkLinks<CR>', { desc = 'Search [L]inks' })
    -- vim.keymap.set('v', '<leader>za', ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)
    -- vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  end,
}
