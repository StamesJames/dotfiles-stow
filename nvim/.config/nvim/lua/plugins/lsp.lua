return {
  {
    "stevearc/conform.nvim",
    opts = {},
    config = function(_, _)
      local prettier_files = {
        ".prettierrc",
        ".prettierrc.json",
        ".prettierrc.json5",
        ".prettierrc.js",
        ".prettierrc.cjs",
        ".prettierrc.mjs",
        ".prettierrc.yaml",
        ".prettierrc.yml",
        ".prettierrc.toml",
        "prettier.config.js",
        "prettier.config.cjs",
        "prettier.config.mjs",
      }
      local eslint_files = {
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.cjs",
        "eslint.config.ts",
        "eslint.config.mts",
        "eslint.config.cts",
      }

      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          typst = { "typstyle" },
          javascript = { "prettier", "eslint_d" },
          javascriptreact = { "prettier", "eslint_d" },
          typescript = { "prettier", "eslint_d" },
          typescriptreact = { "prettier", "eslint_d" },
          vue = { "prettier", "eslint_d" },
          svelte = { "prettier", "eslint_d" },
        },
        formatters = {
          prettier = {
            condition = function(self, ctx)
              return vim.fs.root(ctx.filename, prettier_files) ~= nil
            end,
          },
          eslint_d = {
            condition = function(self, ctx)
              if vim.fs.root(ctx.filename, prettier_files) ~= nil then
                return false
              end
              return vim.fs.root(ctx.filename, eslint_files) ~= nil
            end,
          },
        },
        format_on_save = function(bufnr)
          return { timeout_ms = 500, lsp_fallback = true }
        end,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "tree-sitter-cli", "eslint_d", "prettier" },
      ui = {
        border = "double",
      },
    },
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
      vim.g.inlay_hints_visible = true
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local lsp_enables = {
        -- python
        "basedpyright",
        "ruff",
        -- C/C++
        "clangd",
        -- Rust
        "rust_analyzer",
        -- Zig
        "zls",
        -- TS/JS (vtsls is the single TS server — ts_ls removed to avoid duplicate clients on vue buffers)
        "eslint",
        "jsonls",
        -- vue
        "vue_ls",
        "vtsls",
        -- HTML
        "html",
        -- CSS
        "cssls",
        "tailwindcss",
        -- Webframeworks
        "svelte",
        -- Godot
        -- "gdscript",
        -- Lua
        "stylua",
        "lua_ls",
        -- Typst
        "tinymist",
        -- Fish
        "fish-lsp",
        -- GLSL
        "glsl_analyzer",
        -- PHP
        "intelephense",
        -- DOT langauge
        "dotls",
        -- just
        "just",
      }
      ------------------------- Config -----------------------------------------
      -- python
      vim.lsp.config("basedpyright", { capabilities = capabilities })
      vim.lsp.config("ruff", { capabilities = capabilities })
      -- C, C++
      vim.lsp.config("clangd", { capabilities = capabilities })
      -- rust
      vim.lsp.config("rust_analyzer", { capabilities = capabilities })
      -- zig
      vim.lsp.config("zls", {
        capabilities = capabilities,
        settings = {
          enable_build_on_save = true,
          build_on_save_step = "check",
          inlay_hint = true,
          inlayHint = true,
        },
      })
      -- js, ts (vtsls is configured below with the @vue/typescript-plugin hybrid mode)
      vim.lsp.config("eslint", { capabilities = capabilities })
      vim.lsp.config("jsonls", { capabilities = capabilities })

      -- html
      vim.lsp.config("html", { capabilities = capabilities })
      -- CSS
      vim.lsp.config("cssls", { capabilities = capabilities })
      vim.lsp.config("tailwindcss", { capabilities = capabilities })
      -- Webframeworks
      vim.lsp.config("svelte", { capabilities = capabilities })
      -- godot
      -- vim.lsp.config("gdscript", { capabilities = capabilities })
      -- lua
      vim.lsp.config("stylua", {})
      vim.lsp.config("lua_ls", { capabilities = capabilities, settings = { format = { enable = false } } })
      -- typst
      vim.lsp.config("tinymist", {
        settings = {
          formatterMode = "typstyle",
          exportPdf = "never",
        },
        capabilities = capabilities,
      })
      -- fish
      vim.lsp.config("fish-lsp", { capabilities = capabilities })
      -- glsl
      vim.lsp.config("glsl_analyzer", { capabilities = capabilities })
      -- php
      vim.lsp.config("intelephense", { capabilities = capabilities })
      -- DOT language
      vim.lsp.config("dotls", { capabilities = capabilities })
      -- just
      vim.lsp.config("just", { capabilities = capabilities })

      local vue_language_server_path = vim.fn.expand("$MASON/packages")
        .. "/vue-language-server"
        .. "/node_modules/@vue/language-server"
      -- local vue_language_server_path = vim.fn.stdpath('data') .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
      local tsserver_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
      local vue_plugin = {
        name = "@vue/typescript-plugin",
        location = vue_language_server_path,
        languages = { "vue" },
        configNamespace = "typescript",
      }
      local vtsls_config = {
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                vue_plugin,
              },
            },
          },
        },
        filetypes = tsserver_filetypes,
      }
      -- vue_ls settings: import-on-move tracking + missing-prop inlay hints.
      -- vtsls alone handles TS in vue buffers via the @vue/typescript-plugin
      -- above; ts_ls is intentionally NOT enabled to avoid duplicate TS clients
      -- attaching to the same buffer (vue_ls + ts_ls + vtsls all on one file).
      local vue_ls_config = {
        capabilities = capabilities,
        settings = {
          vue = {
            updateImportsOnFileMove = { enabled = true },
            inlayHints = { missingProps = true },
          },
        },
      }

      vim.lsp.config("vtsls", vtsls_config)
      vim.lsp.config("vue_ls", vue_ls_config)

      --------------------------------------------------------------------------
      vim.lsp.enable(lsp_enables)

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
      vim.keymap.set("n", "<leader>gf", function()
        require("conform").format({ lsp_fallback = true, timeout_ms = 500 })
      end, { desc = "Format buffer" })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end

          if client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true)
          end
        end,
      })
    end,
  },
}
