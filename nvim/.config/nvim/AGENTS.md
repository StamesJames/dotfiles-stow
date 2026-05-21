# Neovim Config — Agent Guide

## Structure
- **Plugin manager:** lazy.nvim, bootstrapped at `config/lazy.lua`
- **Plugin specs:** `lua/plugins/*.lua`, loaded via `{ import = "plugins" }`
- **Core setup:** `lua/config/vim-options.lua`, `lua/config/vim-keymaps.lua`, `lua/config/vim-autocmds.lua`
- **Entry point:** `init.lua` sources `config.lazy` first, then all vim-config modules

## Key conventions
- **Leader:** `<Space>` (global), `\` (local)
- **Indentation:** 2 spaces (enforced by `.editorconfig` + `vim-options.lua`)
- **Colorscheme:** catppuccin-mocha (set last in `init.lua`)

## AI & completions
- **Copilot:** disabled on startup (`vim.cmd(":Copilot disable")`). `copilot.lua` provides inline suggestions; `<Tab>` accepts via blink.cmp chain
- **blink.cmp:** `sources.default = ["lazydev", "lsp", "path", "snippets", "buffer"]`. `<Tab>` = snippet_forward → AI accept → fallback; `<S-Tab>` = snippet_backward
- **opencode.nvim:** `<C-a>` ask, `<C-x>` select, `<C-/>` toggle, `go` operator
- **vim.g.ai_accept** is wired to copilot suggestion accept

## LSP & formatting
- **Formatters:** none-ls.nvim → stylua (Lua), typstyle (Typst)
- **Auto-format on save:** per-buffer autocmd added in `LspAttach` if server supports formatting
- **lua_ls:** formatting disabled in server settings (uses stylua instead)
- **tinymist (Typst):** `formatterMode = "typstyle"`, `exportPdf = "never"`
- **zls (Zig):** `enable_build_on_save = true`, `build_on_save_step = "check"`, inlay hints on
- **Active servers:** basedpyright, ruff, clangd, rust_analyzer, zls, ts_ls, eslint, jsonls, html, cssls, tailwindcss, svelte, gdscript, lua_ls, tinymist, fish-lsp, glsl_analyzer, intelephense, dotls, just

## Notable plugins & quirks
- **obsidian.nvim:** workspaces at `~/Nextcloud/notes/` and `~/Nextcloud/writing/`
- **telescope:** fzf-native requires `make` build; `<leader>fd` find files, `<leader>fg` live multigrep, `<leader>en` nvim config, `<leader>ep` plugin files, `<leader>fn` notes folder
- **harpoon:** v2 branch; `<leader>a` add, `<C-e>` menu, `<C-7/8/9/0>` select
- **oil.nvim:** `<leader>pv` opens file explorer (replaced `vim.cmd.Ex`); hides `..` and `.git`
- **vim-test:** `<leader>t` runs nearest test via Vimux
- **vimtex:** viewer is zathura
- **lean.nvim:** custom abbreviation `:` → `⦂`
- **nvim-metals (Scala):** auto-format on save for scala/sbt/java buffers
- **undodir:** `~/.vim/undodir` must exist for undo persistence

## Git-ignored
- `lazy-lock.json` — plugin lock file, intentionally not tracked
- `vim_keys.txt` — local key reference, not tracked
