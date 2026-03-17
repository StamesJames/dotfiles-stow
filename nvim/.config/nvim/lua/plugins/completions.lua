return {
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",

    version = "*",

    opts = function(_, opts)
      if not opts.keymap then
        opts.keymap = {}
      end
      -- opts.keymap = { preset = "default" }
      opts.keymap["<Tab>"] = {
        "snippet_forward",
        function()
          if vim.g.ai_accept then
            return vim.g.ai_accept()
          end
        end,
        "fallback",
      }
      opts.keymap["<S-Tab>"] = { "snippet_backward", "fallback" }
      opts.completion = {
        menu = { border = "single" },
        documentation = { window = { border = "single" } },
      }
      opts.appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      }
      opts.signature = { enabled = true, window = { border = "single" } }
      opts.sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      }
    end,
  },
}
