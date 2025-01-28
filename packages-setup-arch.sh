sudo pacman -S --needed base-devel 
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -r paru

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
paru -S wofi
paru -S hyprpaper
paru -S hyprlock
paru -S hypridle
paru -S waybar

### terminal setup
paru -S starship
paru -S alacritty
paru -S tmux

paru -S neovim
paru -S firefox

paru -S ripgrep
paru -S bat
paru -S fd
paru -S fzf

paru -S nodejs
paru -S npm
npm install -g tree-sitter-cli

chsh -s /bin/zsh
