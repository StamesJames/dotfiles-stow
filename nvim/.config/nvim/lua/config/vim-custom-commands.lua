local M = {}

function M.setup()
  require("config.commands.case_transformations").setup()
  require("config.commands.split_after")
end

return M
