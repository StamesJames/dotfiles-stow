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
pacman -S ttf-meslo-nerd
pacman -S ttf-font-awesome

### dotfile management
pacman -S stow

### shell setup
pacman -S zsh

##### wm setup
### i3 setup
# pacman -S i3-wm
# pacman -S polybar
# pacman -S picom
# pacman -S feh
# pacman -S rofi

### hyprland setup
pacman -S wayland
pacman -S hyprland
pacman -S wofi
pacman -S hyprpaper
pacman -S hyprlock
pacman -S hypridle
pacman -S hyprshot
pacman -S waybar
pacman -S pavucontrol

### terminal setup
pacman -S starship
pacman -S alacritty
pacman -S tmux
pacman -S tmuxp

### editor setup
pacman -S neovim

### browser setup
pacman -S firefox

### terminal tools
pacman -S ripgrep
pacman -S bat
pacman -S fd
pacman -S fzf
pacman -S lazygit
pacman -S man
pacman -S wl-clipboard

### tree-sitter-cli
pacman -S nodejs
pacman -S npm
pacman -S tree-sitter-cli
sudo npm install -g tree-sitter-cli

### make zsh as default shell
chsh -s /bin/zsh
