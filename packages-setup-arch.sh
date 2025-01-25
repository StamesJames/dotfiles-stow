sudo pacman -S --needed base-devel 
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -r paru

paru -S zsh
paru -S i3
paru -S picom
paru -S feh
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
