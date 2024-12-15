return {
  'zk-org/zk-nvim',
  -- enabled = false,
  -- For some reason the condition is not working correctly
  cond = function()
    return vim.fn.isdirectory(vim.fn.getcwd() .. '/.zk') == 1
  end,
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

    local config = require 'utils.zk-vault-config'()
    local builtin = require 'telescope.builtin'
    local actions = require 'telescope.actions'
    local action_state = require 'telescope.actions.state'
    local commands = require 'zk.commands'

    if not config then
      return
    end

    local zettels_dir = vim.fn.expand(config.notes_dir)
    local daily_dir = vim.fn.expand(config.daily_dir)
    local daily_id_format = config.daily_id_format
    local daily_title_format = config.daily_title_format

    local function zk_new_note_from_template()
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

    local function zk_open_daily_note()
      local file = os.date(daily_id_format) .. '.md'
      local title = os.date(daily_title_format)
      local path = daily_dir .. '/' .. file

      if vim.fn.filereadable(path) == 1 then
        vim.cmd('edit ' .. path)
      else
        commands.get 'ZkNew' { dir = daily_dir, title = title, group = 'daily' }
      end
    end

    local function zk_open_index()
      vim.cmd('edit ' .. zettels_dir .. '/index.md')
    end

    -- Manipulation
    vim.keymap.set('n', '<leader>zn', '<Cmd>ZkNew { dir = "' .. zettels_dir .. '", title = vim.fn.input("Title: ") }<CR>', { desc = '[N]ew Note' })
    vim.keymap.set('v', '<leader>zn', ":'<,'>ZkNewFromTitleSelection { dir = \"" .. zettels_dir .. '" }<CR>', { desc = '[N]ew Note From Selection' })
    vim.keymap.set('n', '<leader>zt', zk_new_note_from_template, { desc = 'New Note From [T]emplate' })
    vim.keymap.set('n', '<leader>zd', zk_open_daily_note, { desc = 'Open [D]aily Note' })

    -- Navigation
    vim.keymap.set('n', '<leader>zf', '<Cmd>ZkNotes<CR>', { desc = 'Find [F]iles' })
    vim.keymap.set('n', '<leader>zb', '<Cmd>ZkBacklinks<CR>', { desc = 'Find [B]acklinks' })
    vim.keymap.set('n', '<leader>zl', '<Cmd>ZkLinks<CR>', { desc = 'Find [L]inks' })
    vim.keymap.set('n', '<leader>z#', '<Cmd>ZkTags<CR>', { desc = 'Find [#]Tags' })

    -- Misc
    vim.keymap.set('n', '<leader>z!', '<Cmd>ZkIndex<CR>', { desc = '[!]Index Notes' })
    vim.keymap.set('n', '<leader>zz', zk_open_index, { desc = 'Open [Z]ettelkasten Index' })
  end,
}
