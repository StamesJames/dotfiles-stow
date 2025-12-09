local function lsp_supports_formatting()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  for _, client in ipairs(clients) do
    if client.name == "godot-lsp" and client:supports_method("textDocument/formatting") then
      return true
    end
  end
  return false
end

return {
  setup = function()
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = vim.api.nvim_create_augroup("GDScriptFormatter", { clear = true }),
      pattern = { "*.gd" },
      callback = function()
        if vim.bo.filetype == "gdscript" and not lsp_supports_formatting() then
          vim.fn.jobstart({ "gdscript-formatter", vim.fn.expand("%:p") }, {
            on_exit = function()
              vim.cmd("edit!")
            end,
          })
        end
      end,
    })
  end,
}
