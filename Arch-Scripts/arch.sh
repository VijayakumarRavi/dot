#!/bin/bash

#This is a lazy script I have for auto-installing Arch.
#It's not officially part of LARBS, but I use it for testing.
#DO NOT RUN THIS YOURSELF because Step 1 is it reformatting /dev/sda WITHOUT confirmation,
#which means RIP in peace qq your data unless you've already backed up all of your drive.

timedatectl set-ntp true

cat <<EOF | fdisk /dev/sda
o
n
p


+200M
n
p


+4G
n
p



n
p


w
EOF
partprobe

cat <<EOF | fdisk /dev/sdb
o
n
p



w
EOF
partprobe


mkfs.ext4 /dev/sdb1
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mount /dev/sda3 /mnt
mkdir -p /mnt/boot
mount /dev/sda1 /mnt/boot
mkdir -p /mnt/home
mount /dev/sdb1 /mnt/home

lsblk
sleep 20

pacman -Sy --noconfirm archlinux-keyring

pacstrap /mnt base base-devel linux linux-lts linux-headers linux-firmware xorg nvidia nvidia-utils gdm gnome git neovim curl telegram-desktop thunderbird gnome-tweaks conky htop neofetch npm python-pip tmux gawk cowsay fortune-mod go grub networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils alsa-utils pulseaudio bash-completion openssh rsync acpi acpi_call tlp virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font cups reflector papirus-icon-theme polkit udisks2

genfstab -U /mnt >> /mnt/etc/fstab

cat /mnt/etc/fstab
sleep 20

echo "archlinux" >> /mnt/etc/hostname
echo "127.0.0.1 localhost" >> /mnt/etc/hosts
echo "::1       localhost" >> /mnt/etc/hosts
echo "127.0.1.1 archlinux.localdomain archlinux" >> /mnt/etc/hosts

curl https://raw.githubusercontent.com/VijayakumarRavi/Dotfiles/main/Arch-Scripts/chroot.sh > /mnt/chroot.sh && arch-chroot /mnt bash chroot.sh && rm /mnt/chroot.sh

