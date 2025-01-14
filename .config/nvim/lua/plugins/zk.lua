return {
  'zk-org/zk-nvim',
  -- enabled = false,
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

          on_attach = function(client)
            -- Disables definition provider to use marksman instead
            client.server_capabilities.definitionProvider = false
          end,
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

            local tmp_name = vim.fn.fnamemodify(selection[1], ':p')
            vim.ui.input({ prompt = 'Title: ' }, function(title)
              commands.get 'ZkNew' { dir = zettels_dir, template = tmp_name, title = title }
            end)
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

    -- Opens the default index note
    local function zk_open_index()
      vim.cmd('edit ' .. zettels_dir .. '/index.md')
    end

    -- This function opens a telescope list of unlinked mentions (notes) of the current buffer
    -- To run this on cmd -> 'zk unlinked-mentions NOTE_ID --quiet --format "{{path}}" --delimiter "\n"'
    local function zk_find_unlinked_mentions()
      local mention = vim.fn.expand '%:t'

      if mention == nil then
        vim.notify("There's no buffer currently open", vim.log.levels.INFO)
      end

      local options = {
        linkTo = { mention },
        select = { 'path' },
      }

      require('zk.api').list(nil, options, function(err, notes)
        if err ~= nil then
          vim.notify(err, vim.log.levels.ERROR)
          return
        end

        local paths = vim
          .iter(pairs(notes))
          :map(function(_, note)
            return note.path
          end)
          :totable()

        require('zk').pick_notes({ mention = { mention }, excludeHrefs = paths }, nil, function(selected)
          if selected[1] ~= nil then
            vim.cmd('edit ' .. selected[1].absPath)
          end
        end)
      end)
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
    vim.keymap.set('n', '<leader>zm', zk_find_unlinked_mentions, { desc = 'Find [Z]ettelkasten Unlinked [M]entions' })

    -- Misc
    vim.keymap.set('n', '<leader>z!', '<Cmd>ZkIndex<CR>', { desc = '[!]Index Notes' })
    vim.keymap.set('n', '<leader>zz', zk_open_index, { desc = 'Open [Z]ettelkasten Index' })
  end,
}
