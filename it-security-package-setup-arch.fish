#!/bin/fish


echo "##################"
echo "### Pentesting ###"
echo "##################"

echo "##################"
echo "### cracking ###"
echo "##################"

sudo pacman -Syu --needed \
  john \
  openmp \
  hashcat

echo "########################"
echo "### network analysis ###"
echo "########################"

sudo pacman -Syu --needed \
  nmap \
  wireshark-qt \
  termshark \
  tcpdump \
  netcat \
  whois \
  traceroute


