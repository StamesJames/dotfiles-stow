return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      legacy_commands = false,
      picker = {
        name = "telescope.nvim",
      },
      workspaces = {
        {
          name = "notes",
          path = "~/Nextcloud/notes/",
        },
      },
    },
  },
}
