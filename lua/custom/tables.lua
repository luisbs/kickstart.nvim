--- Utility functions around tables
---

local M = {}

---Appends values to a `vim.Option`
---@param option vim.Option
---@param values string[]
M.appendOpts = function(option, values)
  for _, value in pairs(values) do
    option:append(value)
  end
end

---Extracts the key values on a table
---@param prefix string
---@param values table<string, any>
---@return table<integer, string>
M.keys = function(prefix, values)
  local keyset = {}
  local n = 0

  for k, _ in pairs(values) do
    n = n + 1
    keyset[n] = prefix .. k
  end

  return keyset
end

return M
