return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "tree-sitter-cli" },
      ui = {
        border = "double",
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    config = function(_, _)
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.typstyle,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dev = false,
    dependencies = {
      {
        -- this is imply to configure lua_ls to function properly while additing my nvim config
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv.library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function(_, _)
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      vim.lsp.enable("koka")
      vim.lsp.config("koka", { capabilities = capabilities })
      vim.lsp.enable("basedpyright")
      vim.lsp.config("basedpyright", { capabilities = capabilities })
      vim.lsp.enable("clangd")
      vim.lsp.config("clangd", { capabilities = capabilities })
      vim.lsp.enable("ruff")
      vim.lsp.config("ruff", { capabilities = capabilities })
      vim.lsp.enable("ts_ls")
      vim.lsp.config("ts_ls", { capabilities = capabilities })
      vim.lsp.enable("svelte")
      vim.lsp.config("svelte", { capabilities = capabilities })
      vim.lsp.enable("gdscript")
      vim.lsp.config("gdscript", { capabilities = capabilities })
      vim.lsp.enable("zls")
      vim.lsp.config("zls", {
        capabilities = capabilities,
        settings = {
          enable_build_on_save = true,
          build_on_save_step = "check",
        },
      })
      vim.lsp.enable("rust_analyzer")
      vim.lsp.config("rust_analyzer", { capabilities = capabilities })
      vim.lsp.enable("stylua")
      vim.lsp.config("stylua", {})
      vim.lsp.enable("lua_ls")
      vim.lsp.config("lua_ls", { capabilities = capabilities, settings = { format = { enable = false } } })
      vim.lsp.enable("tinymist")
      vim.lsp.config("tinymist", {
        settings = {
          formatterMode = "typstyle",
          exportPdf = "never",
        },
        capabilities = capabilities,
      })
      vim.diagnostic.config({
        float = { border = "single" },
      })
      vim.keymap.del("i", "<C-s>")
      vim.keymap.set("i", "<C-s>", function()
        vim.lsp.buf.signature_help({ border = "rounded" })
      end, {})
      vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover({ border = "rounded" })
      end, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end

          if client:supports_method("textDocument/formatting") then
            vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end,
  },
}
