local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

M.find_notes_with_aliases = function(opts)
  opts = opts or {}
  local cwd = vim.fn.expand(opts.cwd or "~/Nextcloud/notes/"):gsub("/+$", "")

  local file_list
  local ok = pcall(function()
    file_list = vim.fn.systemlist({ "fd", "-e", "md", ".", cwd })
  end)
  if not ok or vim.v.shell_error ~= 0 then
    file_list = vim.fn.globpath(cwd, "**/*.md", false, true)
  end

  local entries = {}

  for _, path in ipairs(file_list) do
    local fullpath = path:sub(1, 1) == "/" and path or (cwd .. "/" .. path)

    local lines = vim.fn.readfile(fullpath, "", 50)
    local id, title
    local aliases = {}
    local in_frontmatter = false
    local current_key

    for _, line in ipairs(lines) do
      if line == "---" then
        if in_frontmatter then
          break
        end
        in_frontmatter = true
      elseif in_frontmatter then
        local key, val = line:match("^(%w[%w_-]*):%s*(.-)$")
        if key then
          current_key = key
          if key == "id" and val ~= "" then
            id = val
          elseif key == "title" and val ~= "" then
            title = val
          end
        elseif current_key == "aliases" then
          local alias = line:match("^%s*%-%s*(.+)$")
          if alias then
            table.insert(aliases, alias)
          end
        end
      end
    end

    local stem = vim.fn.fnamemodify(fullpath, ":t:r")
    local display_name = title or id or stem

    local ordinal_parts = { stem }
    if title and title ~= stem then
      table.insert(ordinal_parts, title)
    end
    for _, alias in ipairs(aliases) do
      table.insert(ordinal_parts, alias)
    end
    local ordinal = table.concat(ordinal_parts, " ")

    table.insert(entries, {
      display = display_name,
      ordinal = ordinal,
      filename = fullpath,
    })
  end

  pickers.new(opts, {
    prompt_title = "Notes",
    finder = finders.new_table({
      results = entries,
      entry_maker = function(entry)
        return entry
      end,
    }),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection then
          vim.cmd("edit " .. vim.fn.fnameescape(selection.filename))
        end
      end)
      return true
    end,
  }):find()
end

return M
