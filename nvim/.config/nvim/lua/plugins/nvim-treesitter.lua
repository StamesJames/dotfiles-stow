return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "vue",
        "typescript",
        "tsx",
        "javascript",
        "jsdoc",
        "css",
      },
    },
    config = function(_, opts)
      local ts = require("nvim-treesitter")
      ts.setup(opts)

      local ensure = opts.ensure_installed or {}
      local installed = ts.get_installed()
      local missing = vim.tbl_filter(function(lang)
        return not vim.list_contains(installed, lang)
      end, ensure)

      if #missing > 0 then
        ts.install(missing)
      end
    end,
  },
}