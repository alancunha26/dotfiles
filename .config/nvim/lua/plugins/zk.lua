return {
  'zk-org/zk-nvim',
  config = function()
    require('zk').setup {
      picker = 'telescope',

      lsp = {
        config = {
          cmd = { 'zk', 'lsp' },
          name = 'zk',
        },

        auto_attach = {
          enabled = true,
          filetypes = { 'markdown' },
        },
      },
    }

    -- Load the vault config
    local data = vim.fn.readfile(vim.fn.getcwd() .. '/.zk/vault.json')
    local config = vim.fn.json_decode(data)

    local assets_dir = vim.fn.expand(config.assets_dir or 'assets')
    local zettels_dir = vim.fn.expand(config.notes_dir or 'notes')
    local daily_dir = vim.fn.expand(config.daily_dir or 'daily')
    local daily_id_format = config.daily_id_format or '%Y-%m-%d'
    local daily_title_format = config.daily_title_format or '%B %-d, %Y'

    local commands = require 'zk.commands'
    local builtin = require 'telescope.builtin'
    local actions = require 'telescope.actions'
    local action_state = require 'telescope.actions.state'

    local zkNewNoteFromTemplate = function()
      builtin.find_files {
        follow = false,
        search_dirs = { '.zk/templates' },

        attach_mappings = function(prompt_bufnr)
          actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)

            local tmp_name = vim.fn.fnamemodify(selection[1], ':t')
            commands.get 'ZkNew' { dir = zettels_dir, template = tmp_name, title = vim.fn.input 'Title: ' }
          end)

          return true
        end,
      }
    end

    local zkOpenDailyNote = function()
      local file = os.date(daily_id_format) .. '.md'
      local title = os.date(daily_title_format) .. '.md'
      local path = daily_dir .. '/' .. file

      if vim.fn.filereadable(path) == 1 then
        vim.cmd('edit ' .. path)
      else
        commands.get 'ZkNew' { dir = daily_dir, title = title }
      end
    end

    -- Manipulation
    vim.keymap.set('n', '<leader>zn', '<Cmd>ZkNew { dir = "' .. zettels_dir .. '", title = vim.fn.input("Title: ") }<CR>', { desc = '[N]ew Note' })
    vim.keymap.set('v', '<leader>zn', ":'<,'>ZkNewFromTitleSelection { dir = " .. zettels_dir .. ' }<CR>', { desc = '[N]ew Note From Selection' })
    vim.keymap.set('n', '<leader>zt', zkNewNoteFromTemplate, { desc = 'New Note From [T]emplate' })
    vim.keymap.set('n', '<leader>zd', zkOpenDailyNote, { desc = 'Open [D]aily Note' })

    -- Navigation
    vim.keymap.set('n', '<leader>zf', '<Cmd>ZkNotes<CR>', { desc = 'Search [F]iles' })
    vim.keymap.set('n', '<leader>zb', '<Cmd>ZkBacklinks<CR>', { desc = 'Search [B]acklinks' })
    vim.keymap.set('n', '<leader>zl', '<Cmd>ZkLinks<CR>', { desc = 'Search [L]inks' })
    vim.keymap.set('n', '<leader>z#', '<Cmd>ZkTags<CR>', { desc = 'Search [#]Tags' })

    -- Misc
    vim.keymap.set('n', '<leader>z!', '<Cmd>ZkIndex<CR>', { desc = 'Search [!]Index' })
    -- vim.keymap.set('v', '<leader>za', ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)
    -- vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  end,
}
