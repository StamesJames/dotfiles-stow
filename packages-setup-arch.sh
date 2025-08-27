echo "###################"
echo "### git install ###"
echo "###################"
sudo pacman -S --needed git
sudo pacman -S --needed git-lfs
echo "#################"
echo "### git setup ###"
echo "#################"
git config --global user.email "benedict.smit@tu-dortmund.de"
git config --global user.name "Benedict Christian Smit"
git config --global pull.rebase true
git config --global init.defaultBranch main

echo "##################"
echo "### rust setup ###"
echo "##################"
sudo pacman -S --needed rustup
rustup default stable
rustup update

echo "#################"
echo "### c++ setup ###"
echo "#################"
sudo pacman -S --needed \
  clang \
  scons

echo "##############################"
echo "### pacman-contrib install ###"
echo "##############################"
sudo pacman -S --needed pacman-contrib

echo "##################"
echo "### paru setup ###"
echo "##################"
if ! command -v paru >/dev/null 2>&1; then
  sudo pacman -S --needed base-devel 
  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si
  cd ..
  rm -rf paru
fi

echo "#################################"
echo "### system upgrade using paru ###"
echo "#################################"
paru -Syu

echo "#####################"
echo "### fonts install ###"
echo "#########EEEE########"
sudo pacman -S --needed \
  gnu-free-fonts \
  ttf-meslo-nerd \
  woff2-font-awesome \
  otf-font-awesome \
  ttf-roboto \
  adobe-source-sans-fonts \
  ttf-cascadia-code-nerd \
  ttf-fira-sans

echo "##################################"
echo "### dotfile management install ###"
echo "##################################"
sudo pacman -S --needed \
  stow \
  gnupg \
  sops

echo "#####################"
echo "### shell install ###"
echo "#####################"
# sudo pacman -S --needed zsh
sudo pacman -S --needed fish

echo "########################"
echo "### hyprland install ###"
echo "########################"
sudo pacman -S --needed \
  wayland \
  hyprland \
  wofi \
  hyprpaper \
  hyprlock \
  hypridle \
  waybar \
  pavucontrol
paru -S --needed hyprshot
echo "#####################################"
echo "### hyprland screen share install ###"
echo "#####################################"
sudo pacman -S --needed \
  pipewire \
  wireplumber \
  xdg-desktop-portal-hyprland
paru -S --needed xwaylandvideobridge
echo "###################################"
echo "### hyprland screen share setup ###"
echo "###################################"

echo "########################"
echo "### terminal install ###"
echo "########################"
# sudo pacman -S --needed alacritty
sudo pacman -S --needed ghostty
sudo pacman -S --needed \
  starship \
  tmux \
  tmuxp
if [ ! -d ~/.tmux/plugins/tpm]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "###################"
echo "### IDE install ###"
echo "###################"
sudo pacman -S --needed neovim

echo "#######################"
echo "### browser install ###"
echo "#######################"
sudo pacman -S --needed firefox
paru -S --needed zen-browser-bin

echo "##########################"
echo "### messangers install ###"
echo "##########################"
sudo pacman -S --needed \
  signal-desktop \
  telegram-desktop

echo "################################"
echo "### meeting software install ###"
echo "################################"
sudo pacman -S --needed discord
paru -S --needed \
  zoom \
  discord-canary

echo "###########################"
echo "### typesetting install ###"
echo "###########################"
sudo pacman -S --needed \
  typst \
  texlive

echo "################################"
echo "### office programms install ###"
echo "################################"
sudo pacman -S --needed \
  libreoffice \
  gimp

echo "##############################"
echo "### terminal tools install ###"
echo "##############################"
sudo pacman -S --needed \
  ripgrep \
  bat \
  bat-extras \
  fd \
  fzf \
  lazygit \
  man \
  wl-clipboard \
  wget \
  htop \
  yazi \
  ffmpeg \
  7zip \
  jq \
  poppler \
  zoxide \
  imagemagick
paru -S --needed \
  resvg \
  coursier

echo "###########################"
echo "### note taking install ###"
echo "###########################"
sudo pacman -S --needed \
  pandoc-cli \
  obsidian
paru -S --needed \
  zotero-bin

echo "################################"
echo "### nodejs and tools install ###"
echo "################################"
sudo pacman -S --needed \
  nodejs \
  npm \
  pnpm \
  wasm-pack

echo "###########################"
echo "### tree sitter install ###"
echo "###########################"
sudo pacman -S --needed tree-sitter-cli
# sudo npm install -g tree-sitter-cli

### printer and scanner
echo "###################################"
echo "### printer and scanner install ###"
echo "###################################"
sudo pacman -S --needed \
  sane \
  sane-airscan \
  cups
sudo systemctl enable --now cups

echo "###################"
echo "### vlc install ###"
echo "###################"
sudo pacman -S --needed \
  vlc \
  libdvdread \
  libdvdnav \
  libdvdcss

echo "############################"
echo "### devcontainer install ###"
echo "############################"
sudo pacman -S --needed docker
sudo npm install -g @devcontainers/cli

echo "#############################"
echo "### cloud storage install ###"
echo "#############################"
sudo pacman -S --neede \
  nextcloud-client

# echo "###########################"
# echo "### zsh plugins install ###"
# echo "###########################"
# sudo pacman -S --needed \
#   zsh-autosuggestions \
#   zsh-syntax-highlighting \
#   zsh-completions \
#   zsh-history-substring-search

# echo "#################"
# echo "### i3 install ###"
# echo "#################"
# sudo pacman -S --needed \
#   i3-wm \
#   polybar \
#   picom \
#   feh \
#   rofi

echo "###################"
echo "### shell setup ###"
echo "###################"
# sudo chsh -s /bin/zsh
chsh -s /bin/fish

fish
fish_config theme save "Catppuccin Mocha"

