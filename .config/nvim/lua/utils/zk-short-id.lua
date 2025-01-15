return function()
  local command = 'suid -l 4 -d "/home/alancunha26/.local/share/assets/alphanum-lower.json"'
  local handle = io.popen(command)

  if handle == nil then
    return
  end

  local result = handle:read '*a'
  handle:close()

  if result == nil then
    return
  end

  return vim.fn.trim(result)
end
