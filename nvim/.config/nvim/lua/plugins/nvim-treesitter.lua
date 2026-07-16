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
      ignore_install = { "idris", "idris2" },
      hgihlight = {
        disable = { "idris", "idris2" },
      },
    },
    config = function(_, opts)
      local ts = require("nvim-treesitter")
      ts.setup(opts)

      local ensure = opts.ensure_installed or {}
      local ignore = opts.ignore_install or {}
      local installed = ts.get_installed()
      local missing = vim.tbl_filter(function(lang)
        return not vim.list_contains(installed, lang) and not vim.list_contains(ignore, lang)
      end, ensure)

      if #missing > 0 then
        ts.install(missing)
      end
    end,
  },
}
