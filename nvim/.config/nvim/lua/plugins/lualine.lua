return {
  {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    dependencies = {
      { "nvim-tree/nvim-web-devicons", opt = true },
    },
    opts = {
      options = {
        theme = "dracula",
      },
    },
    config = function(_, opts)
      local lualine = require("lualine")
      lualine.setup(opts)
    end,
  },
}
