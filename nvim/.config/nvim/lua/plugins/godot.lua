return {
  {
    "Mathijs-Bakker/godotdev.nvim",
    dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui", "nvim-treesitter" },
    opts = {},
    config = function(opts, _)
      vim.keymap.set("n", "gK", "<cmd>GodotDocs<cr>", { desc = "Godot docs" })
      require("godotdev").setup(opts)
    end,
  },
}
