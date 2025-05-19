#!/bin/bash

set -e

# Set the hostname
echo "${archlinux}" > /etc/hostname

pacman -S grub-efi-x86_64 efibootmgr dosfstools mtools wireless_tools \
          noto-fonts noto-fonts-emoji noto-fonts-cjk pipewire-pulse \
          ntfs-3g os-prober ntp xfce4 cinnamon-screensaver \
          gnome-keyring chromium tlp lightdm lightdm-gtk-greeter \
          networkmanager network-manager-applet apparmor

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ArchLinux

grub-mkconfig -o /boot/grub/grub.cfg

mkinitcpio -p linux-lts

systemctl enable lightdm
systemctl enable NetworkManager
systemctl enable apparmor
systemctl enable tlp
systemctl enable ntpd

exit

# Unmount filesystems
umount -R /mnt

reboot
