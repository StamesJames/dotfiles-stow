return {
  "catppuccin/nvim",
  name = "catppuccin",
  priotity = 1000,
  config = function()
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}
