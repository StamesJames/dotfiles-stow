vim.api.nvim_create_user_command("SplitAfter", function(opts)
  local line = vim.api.nvim_get_current_line()
  local delimiters = vim.split(opts.args, "%s+", { trimempty = true })

  -- Sort delimiters by length, longest first
  table.sort(delimiters, function(a, b)
    return #a > #b
  end)

  local result = {}
  local start = 1

  while start <= #line do
    local found_pos = #line + 1
    local found_delim = nil

    -- Find the earliest occurrence of the longest delimiter
    for _, delim in ipairs(delimiters) do
      local pos = line:find(vim.pesc(delim), start, true)
      if pos and pos < found_pos then
        found_pos = pos
        found_delim = delim
      end
    end

    if found_pos <= #line then
      table.insert(result, line:sub(start, found_pos + #found_delim - 1))
      start = found_pos + #found_delim
    else
      table.insert(result, line:sub(start))
      break
    end
  end

  -- Replace the current line with the split lines
  local buf = vim.api.nvim_get_current_buf()
  local current_line_num = vim.api.nvim_win_get_cursor(0)[1] - 1
  vim.api.nvim_buf_set_lines(buf, current_line_num, current_line_num + 1, false, result)
end, { nargs = "+", complete = "file" })
