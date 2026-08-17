#!/bin/bash

echo "#####################"
echo "### system update ###"
echo "#####################"

sudo pacman -Syu \
  base-devel

echo "###################"
echo "### git install ###"
echo "###################"
sudo pacman -S --needed git
sudo pacman -S --needed git-lfs
echo "#################"
echo "### git setup ###"
echo "#################"
git config --global user.email "benedict.smit@tuta.com"
git config --global user.name "Benedict Christian Smit"
git config --global pull.rebase true
git config --global init.defaultBranch main
git config --global core.editor "nvim"

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

echo "#################"
echo "### php setup ###"
echo "#################"
sudo pacman -S --needed \
  php

echo "##############################"
echo "### pacman-contrib install ###"
echo "##############################"
sudo pacman -S --needed \
  pacman-contrib

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
echo "#####################"
sudo pacman -S --needed \
  gnu-free-fonts \
  ttf-meslo-nerd \
  woff2-font-awesome \
  otf-font-awesome \
  ttf-roboto \
  adobe-source-sans-fonts \
  ttf-cascadia-code-nerd \
  ttf-fira-sans \
  ttf-lato \
  ttf-croscore

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
sudo pacman -S --needed \
  fish

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
  pavucontrol \
  hyprcursor \
  hyprshot \
  hyprshutdown \
  hyprpicker
echo "#####################################"
echo "### hyprland screen share install ###"
echo "#####################################"
sudo pacman -S --needed \
  pipewire \
  wireplumber \
  xdg-desktop-portal-hyprland
paru -S --needed xwaylandvideobridge

echo "#####################################"
echo "### hyprland screen share install ###"
echo "#####################################"
sudo pacman -S --needed \
  libxkbcommon

echo "########################"
echo "### terminal install ###"
echo "########################"
sudo pacman -S --needed \
  ghostty
sudo pacman -S --needed \
  starship \
  tmux

echo "###################"
echo "### IDE install ###"
echo "###################"
sudo pacman -S --needed \
  neovim

echo "#######################"
echo "### browser install ###"
echo "#######################"
sudo pacman -S --needed \
  firefox
paru -S --needed \
  zen-browser-bin

echo "##########################"
echo "### messangers install ###"
echo "##########################"
sudo pacman -S --needed \
  signal-desktop

echo "################################"
echo "### meeting software install ###"
echo "################################"
sudo pacman -S --needed \
  discord

echo "###########################"
echo "### typesetting install ###"
echo "###########################"
sudo pacman -S --needed \
  typst \
  texlive \
  python-pylatexenc \
  python-pygments

echo "################################"
echo "### office programms install ###"
echo "################################"
sudo pacman -S --needed \
  libreoffice

echo "################################"
echo "### graphic programms install ###"
echo "################################"
sudo pacman -S --needed \
  gimp \
  inkscape

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
  7zip \
  jq \
  zoxide \
  qrencode \
  television \
  eza

echo "####################################"
echo "### terminal media tools install ###"
echo "####################################"
sudo pacman -S --needed \
  chafa \
  ffmpeg \
  ffmpegthumbnailer \
  poppler \
  gnome-epub-thumbnailer \
  imagemagick

echo "###########################"
echo "### note taking install ###"
echo "###########################"
sudo pacman -S --needed \
  pandoc-cli

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
sudo pacman -S --needed \
  tree-sitter-cli

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
  vlc-plugins-all \
  libdvdread \
  libdvdnav \
  libdvdcss \
  libbluray \
  libaacs

echo "##################################"
echo "### dvd/bluray-backups install ###"
echo "##################################"
pacman -S --needed \
  jre-openjdk \
  dvdbackup
paru -S --needed \
  bluraybackup

echo "############################"
echo "### devcontainer install ###"
echo "############################"
sudo pacman -S --needed \
  docker \
  docker-buildx \
  podman
sudo npm install -g @devcontainers/cli

echo "#############################"
echo "### cloud storage install ###"
echo "#############################"
sudo pacman -S --needed \
  nextcloud-client

echo "#########################"
echo "### bluetooth install ###"
echo "#########################"
sudo pacman -S --neede \
  bluez \
  bluez-utils \
  blueman

echo "###################"
echo "### shell setup ###"
echo "###################"
chsh -s /bin/fish
fish

echo "######################"
echo "### audio software ###"
echo "######################"

sudo pacman -S --needed \
  pipewire \
  pipewire-jack \
  pipewire-alsa \
  pipewire-pulse \
  wireplumber \
  realtime-privileges \
  lmms \
  surge-xt \
  ardour \
  qtractor
paru -S --needed \
  zrythm
sudo usermod -aG realtime $USER

echo "#####################"
echo "### notifications ###"
echo "#####################"

sudo pacman -S --needed \
  libnotify \
  dunst

echo "##############"
echo "### python ###"
echo "##############"

sudo pacman -Syu --needed \
  python \
  python-numpy \
  python-scipy

echo "###########################"
echo "### post packages setup ###"
echo "###########################"

./stow-used-packages.fish
./post-packages-setup-arch.fish

