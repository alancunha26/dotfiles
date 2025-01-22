-- [[ General Keymaps ]]
--  See `:help vim.keymap.set()`

-- Exit insert mode
vim.keymap.set('i', 'jk', '<Esc>')

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR><cmd>Noice dismiss<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', 'zZ', 'zszH', { desc = 'Move screen to the center of cursor (horizontal)' })

-- Beter gx -> Open files with vim.ui.open relative to the current buffer
vim.keymap.set('n', 'gx', function()
  local filename = vim.fn.expand '<cfile>%:t'
  local buffer_dir = vim.fn.expand '%:h'

  -- Check if the filename is a url or not
  if not string.match(filename, '[a-z]*://[^ >,;]*') then
    vim.ui.open(buffer_dir .. '/' .. filename)
  else
    vim.ui.open(filename)
  end
end, { desc = '[X]Open url/file relative to current buffer' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Spellcheck ]]
--  See `:help spell`

-- Toggle spell check
vim.keymap.set('n', '<leader>st', function()
  vim.opt.spell = not (vim.opt.spell:get())
end, { desc = '[S]pellcheck [T]oggle' })

-- Show spelling suggestions / spell suggestions.
-- NOTE: Overridden by telescope builtin.spell_suggest
vim.keymap.set('n', '<leader>ss', function()
  vim.cmd 'normal! z='
end, { desc = '[S]pellcheck [S]uggestions' })

-- Fix spelling with first suggestion
vim.keymap.set('n', '<leader>sf', function()
  vim.cmd 'normal! 1z='
end, { desc = '[F]ix spelling with first suggestion' })

-- Add word under the cursor as a good word
vim.keymap.set('n', '<leader>sa', function()
  vim.cmd 'normal! zg'
end, { desc = '[A]dd word to spellcheck' })

-- Undo zw, remove the word from the entry in 'spellfile'.
vim.keymap.set('n', '<leader>sd', function()
  vim.cmd 'normal! zug'
end, { desc = '[D]elete word from spellcheck' })

-- Repeat the replacement done by |z=| for all matches with the replaced word
-- in the current window.
vim.keymap.set('n', '<leader>msr', function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(':spellr\n', true, false, true), 'm', true)
end, { desc = '[R]epeat spellcheck for all matches' })

-- vim: ts=2 sts=2 sw=2 et
