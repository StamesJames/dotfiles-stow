#!/bin/fish

echo "##################"
echo "### fish setup ###"
echo "##################"

fish_config theme save "Catppuccin Mocha"
set -U EDITOR nvim

fish_add_path ~/.ghcup/bin
