return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        natrual_order = true,
        is_hidden_file = function(name, _)
          local hide_patterns = {
            -- Godot
            "%.uid[/]?$",    -- .uid files
            "%.import[/]?$", -- .import files
            "^%.godot[/]?$", -- .godot directory
            "^%.mono[/]?$",  -- .mono directory
            "godot.*%.tmp$", -- godot temp files
            -- dotfiles
            "^%.",
          }
          for _, pat in ipairs(hide_patterns) do
            if name:match(pat) then
              return true
            end
          end
          return false
        end,
        is_always_hidden = function(name, _)
          return name == ".." or name == ".git"
        end,
      },
      win_options = {
        wrap = true,
      },
    },
    -- Optional dependencies
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function(_, opts)
      require("oil").setup(opts)
      vim.keymap.set("n", "<leader>pv", ":Oil<CR>")
    end,
  },
}
