-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = 'master',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          layout_strategy = 'vertical',
          sorting_strategy = 'ascending', -- display results top->bottom

          layout_config = {
            prompt_position = 'bottom', -- search bar at the top
            height = 0.9,
            width = 0.9,
          },

          path_display = {
            filename_first = {
              reverse_directories = false,
            },
          },
        },

        pickers = {
          live_grep = {
            file_ignore_patterns = { 'node_modules', '.git', '.venv' },
            additional_args = function(_)
              return { '--hidden' }
            end,
          },
          find_files = {
            file_ignore_patterns = { 'node_modules', '.git', '.venv' },
            hidden = true,
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      local actions = require 'telescope.actions'
      local finders = require 'telescope.finders'
      local pickers = require 'telescope.pickers'
      local conf = require('telescope.config').values
      local entry_display = require 'telescope.pickers.entry_display'
      local action_state = require 'telescope.actions.state'

      -- This method enables to delete buffers from the telescope menu
      function buffer_searcher()
        builtin.buffers {
          sort_mru = true,
          ignore_current_buffer = false,
          show_all_buffers = true,
          initial_mode = 'insert',

          attach_mappings = function(prompt_bufnr, map)
            local refresh_buffer_searcher = function()
              actions.close(prompt_bufnr)
              vim.schedule(buffer_searcher)
            end

            local delete_buf = function()
              local selection = action_state.get_selected_entry()
              vim.api.nvim_buf_delete(selection.bufnr, { force = true })
              refresh_buffer_searcher()
            end

            local delete_multiple_buf = function()
              local picker = action_state.get_current_picker(prompt_bufnr)
              local selection = picker:get_multi_selection()
              for _, entry in ipairs(selection) do
                vim.api.nvim_buf_delete(entry.bufnr, { force = true })
              end
              refresh_buffer_searcher()
            end

            map('n', 'dd', delete_buf)
            map('n', '<C-d>', delete_multiple_buf)
            map('i', '<C-d>', delete_multiple_buf)

            return true
          end,
        }
      end

      local emojis = require 'utils.emojis'
      local icons = require 'utils.nerd-font-icons'

      local function find_emojis()
        local displayer = entry_display.create {
          separator = ' ',
          items = {
            { width = 40 },
            { width = 18 },
            { remaining = true },
          },
        }
        local make_display = function(entry)
          return displayer {
            entry.value .. ' ' .. entry.name,
            entry.category,
            entry.description,
          }
        end

        pickers
          .new(opts, {
            prompt_title = 'Emojis',
            sorter = conf.generic_sorter(opts),
            finder = finders.new_table {
              results = emojis,
              entry_maker = function(emoji)
                return {
                  ordinal = emoji.name .. emoji.category .. emoji.description,
                  display = make_display,

                  name = emoji.name,
                  value = emoji.value,
                  category = emoji.category,
                  description = emoji.description,
                }
              end,
            },
            attach_mappings = function(prompt_bufnr)
              actions.select_default:replace(function()
                local emoji = action_state.get_selected_entry()
                actions.close(prompt_bufnr)

                vim.fn.setreg('+', emoji.value)
                print([[Press p or "*p to paste this emoji]] .. emoji.value)
              end)
              return true
            end,
          })
          :find()
      end

      local function find_icons()
        local displayer = entry_display.create {
          separator = ' ',
          items = {
            { width = 40 },
            { width = 18 },
            { remaining = true },
          },
        }

        local make_display = function(entry)
          return displayer {
            entry.char .. ' ' .. entry.name,
          }
        end

        pickers
          .new(opts, {
            prompt_title = 'Nerd Font Icons',
            sorter = conf.generic_sorter(opts),
            finder = finders.new_table {
              results = icons,
              entry_maker = function(icon)
                return {
                  ordinal = icon.name,
                  display = make_display,

                  name = icon.name,
                  char = icon.char,
                }
              end,
            },
            attach_mappings = function(prompt_bufnr)
              actions.select_default:replace(function()
                local icon = action_state.get_selected_entry()
                actions.close(prompt_bufnr)

                vim.fn.setreg('+', icon.char)
                print([[Press p or "*p to paste this icon]] .. icon.char)
              end)
              return true
            end,
          })
          :find()
      end

      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
      vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', buffer_searcher, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>ss', builtin.spell_suggest, { desc = '[S]pellcheck Suggestions' })
      vim.keymap.set('n', '<leader>fe', find_emojis, { desc = '[F]ind [E]mojis' })
      vim.keymap.set('n', '<leader>fi', find_icons, { desc = '[F]ind [I]cons' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily find in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>f/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[F]ind [/] in Open Files' })

      -- Shortcut for finding your Neovim configuration files
      vim.keymap.set('n', '<leader>fn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[F]ind [N]eovim files' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
