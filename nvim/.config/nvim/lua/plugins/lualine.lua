return {
  {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    dependencies = {
      { "nvim-tree/nvim-web-devicons", opt = true },
    },
    opts = {
      extensions = {
        "oil",
        "mason",
        "lazy",
        "fzf",
        "quickfix",
        "trouble",
      },
      options = {
        theme = "dracula",
      },
    },
  },
}
