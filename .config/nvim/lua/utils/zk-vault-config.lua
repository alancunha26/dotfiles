return function()
  local zk_dir = vim.fn.getcwd() .. '/.zk'
  if vim.fn.isdirectory(zk_dir) == 0 then
    return false
  end

  local vault_path = zk_dir .. '/vault.json'
  if vim.fn.filereadable(vault_path) == 0 then
    return false
  end

  local data = vim.fn.readfile(vault_path)
  local config = vim.fn.json_decode(data)

  config.assets_dir = config.assets_dir or 'assets'
  config.notes_dir = config.notes_dir or 'notes'
  config.daily_dir = config.daily_dir or 'daily'
  config.daily_id_format = config.daily_id_format or '%B %-d, %Y'
  config.daily_title_format = config.daily_title_format or '%B %-d, %Y'

  return config
end
