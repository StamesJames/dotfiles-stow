return {
  { "nvim-treesitter/playground" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
      parser_configs.koka = {
        install_info = {
          url = "/home/stames/programs/koka/tree-sitter-koka/",
          files = { "src/parser.c", "src/scanner.c" },
        },
        filetype = "koka",
      }

      configs.setup({
        modules = {},
        ignore_install = {},
        auto_install = true,
        sync_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        ensure_installed = {
          "bibtex",
          "c",
          "cmake",
          "cpp",
          "css",
          "csv",
          "gdscript",
          "gdshader",
          "gitattributes",
          "gitcommit",
          "gitignore",
          "godot_resource",
          "html",
          "javascript",
          "json",
          "latex",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "rust",
          "scala",
          "scss",
          "svelte",
          "tmux",
          "toml",
          "typescript",
          "typst",
          "vim",
          "vimdoc",
          "xml",
          "yaml",
          "zig",
        },
      })
    end,
  },
}
