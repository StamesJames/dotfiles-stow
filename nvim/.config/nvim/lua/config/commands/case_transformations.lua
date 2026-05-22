local M = {}

local utils = require("utils")

---@param str string
---@return string
function M.to_acronym(str)
  local words = utils.split_words(str)
  local acronym = ""
  for _, word in ipairs(words) do
    acronym = acronym .. word:sub(1, 1):upper()
  end
  return acronym
end

---@param str string
---@return string
function M.to_snake_case(str)
  return table.concat(utils.split_words(str), "_")
end

---@param str string
---@return string
function M.to_kebab_case(str)
  return table.concat(utils.split_words(str), "-")
end

---@param str string
---@return string
function M.to_camel_case(str)
  local words = utils.split_words(str)
  if #words == 0 then
    return str
  end
  local result = words[1]
  for i = 2, #words do
    result = result .. words[i]:sub(1, 1):upper() .. words[i]:sub(2)
  end
  return result
end

---@param str string
---@return string
function M.to_pascal_case(str)
  local words = utils.split_words(str)
  local result = ""
  for _, word in ipairs(words) do
    result = result .. word:sub(1, 1):upper() .. word:sub(2)
  end
  return result
end

---@param str string
---@return string
function M.to_space_separated(str)
  return table.concat(utils.split_words(str), " ")
end

---@param str string
---@return string
function M.to_title_case(str)
  local words = utils.split_words(str)
  for i, word in ipairs(words) do
    words[i] = word:sub(1, 1):upper() .. word:sub(2)
  end
  return table.concat(words, " ")
end

---@param transform_fn fun(str: string): string
function M.apply_transform(transform_fn)
  local start_line = vim.fn.line("'<")
  local start_col = vim.fn.col("'<")
  local end_line = vim.fn.line("'>")
  local end_col = vim.fn.col("'>")

  for line = start_line, end_line, 1 do
    local line_end_col = math.min(end_col, #vim.fn.getline(line))
    local line_start_col = math.min(start_col, #vim.fn.getline(line))
    local ok, text = pcall(vim.api.nvim_buf_get_text, 0, line - 1, line_start_col - 1, line - 1, line_end_col, {})
    if not ok then
      vim.print("Error: reading buf")
      return
    end
    if #text == 0 then
      vim.print("Error: empty text")
      return
    end
    if #text > 1 then
      vim.print("Error Internal: nvim_buf_get_text should only be applied to a singel line")
      return
    end
    local transformed = {}
    transformed[1] = transform_fn(text[1])

    vim.api.nvim_buf_set_text(0, line - 1, line_start_col - 1, line - 1, line_end_col, transformed)
    vim.cmd("nohlsearch")
  end
end

function M.setup()
  local command_map = {
    SnakeCase = M.to_snake_case,
    PascalCase = M.to_pascal_case,
    CamelCase = M.to_camel_case,
    KebabCase = M.to_kebab_case,
    SpaceCase = M.to_space_separated,
    TitleCase = M.to_title_case,
    Acronym = M.to_acronym,
  }

  for name, fn in pairs(command_map) do
    vim.api.nvim_create_user_command(name, function()
      M.apply_transform(fn)
    end, { range = true })
  end

  vim.keymap.set("v", "<leader>cs", ":'<,'>SnakeCase<CR>", { desc = "snake_case" })
  vim.keymap.set("v", "<leader>cp", ":'<,'>PascalCase<CR>", { desc = "PascalCase" })
  vim.keymap.set("v", "<leader>cc", ":'<,'>CamelCase<CR>", { desc = "camelCase" })
  vim.keymap.set("v", "<leader>ck", ":'<,'>KebabCase<CR>", { desc = "Kebab case" })
  vim.keymap.set("v", "<leader>cw", ":'<,'>SpaceCase<CR>", { desc = "Space separated" })
  vim.keymap.set("v", "<leader>ct", ":'<,'>TitleCase<CR>", { desc = "Title case" })
  vim.keymap.set("v", "<leader>ca", ":'<,'>Acronym<CR>", { desc = "Acronym" })
end

return M
