return {
  enabled = false,
  'cbosvik/obsidian.nvim', -- Using a fork due to a breaking bug
  branch = 'bug/NewFromTemplate-respect-id', -- This branch fixes the bug
  -- 'epwalsh/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'Notes',
        path = '~/03 Resources/Notes',
      },
      {
        name = 'Alan.md',
        path = '~/04 Archive/Alan.md',
      },
    },

    ui = {
      enable = false,
    },

    note_frontmatter_func = function(note)
      -- Add the title of the note as an alias.
      if note.title then
        note:add_alias(note.title)
      end

      local out = { id = note.id, aliases = note.aliases, tags = note.tags }

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,

    attachments = {
      img_folder = '00-meta/assets',

      img_name_func = function()
        return string.format('%s-', os.time())
      end,

      img_text_func = function(client, path)
        path = client:vault_relative_path(path) or path
        return string.format('![%s](%s)', path.name, path)
      end,
    },

    templates = {
      folder = '00-meta/templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
      -- A map for custom variables, the key should be the variable and the value a function
      -- substitutions = {},
    },

    daily_notes = {
      folder = '02-journal',
      date_format = '%Y-%m-%d',
      alias_format = '%B %-d, %Y',
      default_tags = { 'Daily' },
      template = 'daily.md',
    },

    note_id_func = function(title)
      return tostring(os.date '%Y%m%d%H%M%S')
    end,

    new_notes_location = '01-notes',
    preferred_link_style = 'wiki',
  },
}
