#!/bin/fish

echo "#######################"
echo "### haskell install ###"
echo "#######################"
paru -S --needed \
  ghcup-hs-bin
ghcup install ghc
ghcup install cabal
ghcup install stack
ghcup install hls
