return {
  'nvim-telescope/telescope.nvim',
  keys = {
    { '<leader>fb', false },
  },
  -- change some options
  opts = {
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
  },
}
