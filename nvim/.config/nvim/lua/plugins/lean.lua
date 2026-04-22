return {
  "Julian/lean.nvim",
  dev = false,
  event = { "BufReadPre *.lean", "BufNewFile *.lean" },
  lsp = { enable = true },

  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",
    "saghen/blink.cmp",
  },

  ---@type lean.Config
  opts = { -- see below for full configuration options
    mappings = true,
    abbreviations = {
      extra = {
        [":"] = "⦂",
      },
    },
  },
}
