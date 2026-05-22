local M = {}

---@param str string
---@return string[]
function M.split_words(str)
  str = str:gsub("[_%-%.%s]", " ")
  str = str:gsub("([%l])([%u])", "%1 %2")
  str = str:gsub("([%u])([%u][%l])", "%1 %2")
  local words = {}
  for word in str:gmatch("%S+") do
    table.insert(words, word:lower())
  end
  return words
end

return M
