#!/bin/bash

sudo pacman -Syu
sudo pacman -S qemu-full libvirt virt-manager dnsmasq edk2-ovmf
sudo systemctl enable --now libvirtd
sudo systemctl enable --now libvirtd.service
sudo systemctl enable --now libvirtd.socket
sudo usermod -aG libvirt $(whoami)
sudo usermod -aG kvm $(whoami)

# look at [https://wiki.archlinux.org/title/Virt-manager] for further information
# For example how to set the configuration in /etc/libvirt/libvirtd.conf and /etc/libvirt/qemu.conf
# in /etc/libvirt/libvirtd.conf
# ```
# ...
# unix_sock_group = 'libvirt'
# ...
# unix_sock_rw_perms = '0770'
# ...
# ```
# in /etc/libvirt/qemu.conf
# ```
# # Some examples of valid values are:
# #
# #       user = "qemu"   # A user named "qemu"
# #       user = "+0"     # Super user (uid=0)
# #       user = "100"    # A user named "100" or a user with uid=100
# #
# user = "username"
# 
# # The group for QEMU processes run by the system instance. It can be
# # specified in a similar way to user.
# group = "username"
# ```
