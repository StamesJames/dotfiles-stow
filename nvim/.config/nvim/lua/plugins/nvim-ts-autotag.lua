return {
  {
    "windwp/nvim-ts-autotag",
    opts = {
      opts = {
        -- Defaults
        enable_close = true,           -- Auto close tags
        enable_rename = true,          -- Auto rename pairs of tags
        enable_close_on_slash = false, -- Auto close on trailing </
      },
      per_filetype = {
        ["rust"] = {
          enable_close = false,
          enable_rename = false,
          enable_close_on_slash = false,
        },
        ["lean"] = {
          enable_close = false,
          enable_rename = false,
          enable_close_on_slash = false,
        },
      },
    },
  },
}
