### git setup
sudo pacman -S git
git config --global user.email "benedict.smit@tu-dortmund.de"
git config --global user.name "Benedict Christian Smit"
git config --global pull.rebase true
git config --global init.defaultBranch main

### paru setup
rustup default stable
sudo pacman -S --needed base-devel 
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -r paru

### fonts
sudo pacman -S ttf-meslo-nerd
sudo pacman -S ttf-font-awesome
sudo pacman -S ttf-roboto
sudo pacman -S adobe-source-sans-fonts

### dotfile management
sudo pacman -S stow

### shell setup
sudo pacman -S zsh

##### wm setup

### hyprland setup
sudo pacman -S wayland
sudo pacman -S hyprland
sudo pacman -S wofi
sudo pacman -S hyprpaper
sudo pacman -S hyprlock
sudo pacman -S hypridle
sudo pacman -S waybar
sudo pacman -S pavucontrol
paru -S hyprshot

### terminal setup
sudo pacman -S starship
sudo pacman -S alacritty
sudo pacman -S tmux
sudo pacman -S tmuxp
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

### editor setup
sudo pacman -S neovim

### browser setup
sudo pacman -S firefox

### programs
sudo pacman -S signal-desktop
sudo pacman -S telegram-desktop
sudo pacman -S typst

### terminal tools
sudo pacman -S ripgrep
sudo pacman -S bat
sudo pacman -S bat-extras
sudo pacman -S fd
sudo pacman -S fzf
sudo pacman -S lazygit
sudo pacman -S man
sudo pacman -S wl-clipboard
sudo pacman -S wget

### js & wasm stuff
sudo pacman -S nodejs
sudo pacman -S npm
sudo pacman -S pnpm
sudo pacman -S wasm-pack

### tree-sitter-cli
sudo pacman -S tree-sitter-cli
sudo npm install -g tree-sitter-cli

### make zsh as default shell
chsh -s /bin/zsh

### i3 setup
# sudo pacman -S i3-wm
# sudo pacman -S polybar
# sudo pacman -S picom
# sudo pacman -S feh
# sudo pacman -S rofi

