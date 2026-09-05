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
- `oc [dir] [--ssh] [--shell] [opencode-args...]` (`fish/.config/fish/functions/oc.fish`) runs opencode in a hardened rootless podman container: only the given folder (default `$PWD`) at `/workspace` plus persistent sandbox tool state (rustup, cargo, package-manager caches, fish history) are writable; read-only rootfs, `--cap-drop=ALL`, `no-new-privileges`, pids/memory limits, no published ports, no X11/Wayland/DBus/SSH-key mounts. `--shell` opens an interactive fish shell instead of opencode.
- Global config is mounted read-only, resolving the stow symlink to the real dir `opencode/.config/opencode/` (dotfiles edits apply live, `.secrets/` included); `~/.local/share/opencode/auth.json` is shared read-write; container state persists under `~/.local/share/opencode-sandbox/`.
- Image `localhost/opencode-sandbox:latest` is built by `oc-build` from `templates/.setups/opencode-container/Containerfile`: Arch Linux (`archlinux:base-devel`, digest-pinned) with a dev toolset mirroring the host (git/git-lfs, neovim, fish, python+pip+numpy/scipy, nodejs/npm/pnpm, bun, deno, rustup, ffmpeg, clang/scons, php, pandoc-cli, typst, docker/podman CLIs, ripgrep/fd/bat/fzf/jq/eza/zoxide, 7zip/unzip/zip, stow, imagemagick, poppler, man) and the opencode CLI from the upstream glibc release tarball (version + sha256 pinned; the official ghcr.io image binary is musl-linked and cannot run on Arch). `oc-build --refresh` re-pins both the opencode release and the Arch base digest and rebuilds.
- Non-root user `dev` (UID 1000, login shell fish) matches `--userns=keep-id`. Rust is provided via rustup: a minimal stable toolchain (rust-src, rustfmt, clippy) is baked into the image and seeded into the persistent `~/.rustup` on first start — `rustup update` and extra toolchains work inside the sandbox. Tool caches (cargo, npm, pip, deno, bun, pnpm) persist under `~/.local/share/opencode-sandbox/{rustup,cargo,tooling}`.
- Caveats for agents working inside the sandbox: docker/podman are CLI-only (no daemon can run — don't attempt docker/podman builds); install Python deps via a venv in `/workspace` (system site-packages are read-only and externally-managed); `npm i -g` fails (read-only `/usr`) — use project-local installs.
- Git identity in the sandbox is the dedicated AI identity (`AI for Benedict Smit <stames.for.ai@gmail.com>`, plus the host's `pull.rebase`/`init.defaultBranch`/`core.editor` prefs), mounted read-only from `~/.setups/opencode-container/gitconfig` (`templates/.setups/opencode-container/gitconfig` in this repo — edit it live, no image rebuild). Host `~/.gitconfig` is intentionally NOT mounted: commits made inside the sandbox must stay distinguishable from the user's own.
- `--ssh` binds only the agent socket (`SSH_AUTH_SOCK`) and a read-only `known_hosts`; private keys never enter the container.
