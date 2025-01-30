### git setup
sudo pacman -S git
git config --global user.email "benedict.smit@tu-dortmund.de"
git config --global user.name "Benedict Christian Smit"
git config --global pull.rebase true

### paru setup
rustup default stable
sudo pacman -S --needed base-devel 
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -r paru

### fonts
paru -S ttf-meslo-nerd

### dotfile management
paru -S stow

### shell setup
paru -S zsh

##### wm setup
### i3 setup
# paru -S i3
# paru -S polybar
# paru -S picom
# paru -S feh
# paru -S rofi

### hyprland setup
paru -S wayland
paru -S hyprland
paru -S wofi
paru -S hyprpaper
paru -S hyprlock
paru -S hypridle
paru -S waybar

### terminal setup
paru -S starship
paru -S alacritty
paru -S tmux
paru -S tmuxp

### editor setup
paru -S neovim

### browser setup
paru -S firefox

### terminal tools
paru -S ripgrep
paru -S bat
paru -S fd
paru -S fzf
paru -S lazygit

### tree-sitter-cli
paru -S nodejs
paru -S npm
paru -S tree-sitter-cli
sudo npm install -g tree-sitter-cli

### make zsh as default shell
chsh -s /bin/zsh
