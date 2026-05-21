local function wordcount()
  local count = vim.fn.wordcount()
  if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
    return "W:" .. count.visual_words
  else
    return "W:" .. count.words
  end
end
return {
  {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    dependencies = {
      { "nvim-tree/nvim-web-devicons", opt = true },
      { "catppuccin/nvim" },
    },
    opts = {
      sections = {
        lualine_z = {
          { "location" },
          { wordcount },
        },
      },
      extensions = {
        "oil",
        "mason",
        "lazy",
        "fzf",
        "quickfix",
        "trouble",
        "toggleterm",
      },
      options = {
        theme = require("catppuccin.utils.lualine"),
      },
    },
  },
}
