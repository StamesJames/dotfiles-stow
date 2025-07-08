return {
  "scalameta/nvim-metals",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "j-hui/fidget.nvim",
      opts = {},
    },
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  },
  ft = { "scala", "sbt", "java" },
  opts = function()
    local metals_config = require("metals").bare_config()
    metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
    metals_config.on_attach = function(client, bufnr)
      print("scala metals attached")
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, id = client })
        end,
      })
    end
    metals_config.settings = {
      showImplicitArguments = true,
      excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
    }
    metals_config.init_options.statusBarProvider = "off"

    return metals_config
  end,
  config = function(self, metals_config)
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
    })
  end,
}
