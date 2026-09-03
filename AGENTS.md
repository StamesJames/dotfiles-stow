# Dotfiles repo — Agent Guide

## Repo structure
- **Managed with GNU stow.** Each top-level folder (e.g. `nvim/`, `fish/`, `tmux/`) mirrors `$HOME` sub-paths when stowed.
- **Arch Linux** setup scripts: `packages-setup-arch.sh`, `post-packages-setup-arch.fish`, `setup-for-vm-installation.fish`.

## Neovim config (`nvim/.config/nvim`)
- **Plugin manager:** lazy.nvim (bootstraps itself on first run).
- **Leader:** `<Space>` (global), `\` (local).
- **Colorscheme:** catppuccin-mocha (applied in `init.lua`).
- **Copilot:** disabled on startup (`init.lua:9`).
- **Indentation:** 2 spaces (enforced by `.editorconfig` and `vim-options.lua`).
- **Formatter:** none-ls.nvim → stylua (Lua), typstyle (Typst). LSP auto-formats on save per-buffer.
- **LSP stack:** nvim-lspconfig + blink.cmp for completions. Wide set of servers (python, rust, zig, ts/js, lua, typst, haskell, lean, php, godot, etc). See `lua/plugins/lsp.lua` for full list.
- **Notable plugins:** haskell-tools.nvim, lean.nvim, nvim-metals (Scala), obsidian, vimtex, harpoon, oil, telescope, visual-multi, vim-surround.
- **Undodir:** `~/.vim/undodir` (must exist for undo persistence).
- **Godot plugin:** present but commented out in `init.lua:8`.
- **Ignored:** `lazy-lock.json` and `vim_keys.txt` are git-ignored.

## Conventions
- Shell config: fish (primary), with bash and zsh directories present.
- Window manager configs: i3 and hyprland both present (different setups).
- Terminal configs: alacritty and ghostty both present.

## opencode sandbox (`oc`)
- `oc [dir] [--ssh] [--shell] [opencode-args...]` (`fish/.config/fish/functions/oc.fish`) runs opencode in a hardened rootless podman container: only the given folder (default `$PWD`) is mounted writable at `/workspace`; read-only rootfs, `--cap-drop=ALL`, `no-new-privileges`, pids/memory limits, no published ports, no X11/Wayland/DBus/SSH-key mounts.
- Global config is mounted read-only, resolving the stow symlink to the real dir `opencode/.config/opencode/` (dotfiles edits apply live, `.secrets/` included); `~/.local/share/opencode/auth.json` is shared read-write; container state persists under `~/.local/share/opencode-sandbox/`.
- Image `localhost/opencode-sandbox:latest` is built by `oc-build` from `templates/.setups/opencode-container/Containerfile`: official `ghcr.io/anomalyco/opencode` (digest-pinned) plus git, openssh-client, tzdata, non-root user `dev` (UID 1000 to match `--userns=keep-id`). `oc-build --refresh` re-pins the base digest and rebuilds.
- `--ssh` binds only the agent socket (`SSH_AUTH_SOCK`) and a read-only `known_hosts`; private keys never enter the container.
