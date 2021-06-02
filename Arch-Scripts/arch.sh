#!/bin/bash

create-part-d1() {
	cat <<EOF | fdisk /dev/sda
o
n
p


+200M
n
p


+2G
n
p



n
p


w
EOF
	partprobe
	sleep 10
}
create-part-d2() {
	cat <<EOF | fdisk /dev/sdb
o
n
p



w
EOF
	partprobe
	sleep 10
}

makefs() {
	mkfs.ext4 /dev/sdb1
	mkfs.ext4 /dev/sda3
	mkfs.ext4 /dev/sda1
	mkswap /dev/sda2
	sleep 10
}

mountfs() {
	swapon /dev/sda2
	mount /dev/sda3 /mnt
	mkdir -p /mnt/boot
	mount /dev/sda1 /mnt/boot
	mkdir -p /mnt/home
	mount /dev/sdb1 /mnt/home
	mkdir ~/temp
	mkdir -p /mnt/temp
	lsblk
	sleep 20
}

install-pkgs() {
	pacman -Sy --noconfirm archlinux-keyring
	pacstrap /mnt base base-devel linux linux-lts linux-headers linux-firmware xorg nvidia nvidia-utils gdm gnome git neovim curl telegram-desktop thunderbird gnome-tweaks conky htop neofetch npm python-pip tmux gawk cowsay fortune-mod go grub networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils alsa-utils pulseaudio bash-completion openssh rsync acpi acpi_call tlp virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font cups reflector papirus-icon-theme polkit udisks2 pulseaudio-bluetooth
	genfstab -U /mnt >> /mnt/etc/fstab ;
	cat /mnt/etc/fstab ;
	sleep 20
}

install-yay() {
	cd ~/temp/
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -s
	mv -v *.pkg.tar.zst /mnt/temp/
	sleep 10
}

install-brave() {
	cd ~/temp/
	git clone https://aur.archlinux.org/brave-bin.git
	cd brave-bin
	makepkg -s
	mv -v *.pkg.tar.zst /mnt/temp
	sleep 10
}

chroot-fun() {
	curl https://raw.githubusercontent.com/VijayakumarRavi/Dotfiles/main/Arch-Scripts/chroot.sh > /mnt/chroot.sh
	printf "\e[1;32m*********CHROOT Scripts Started**********\e[0m"
	arch-chroot /mnt bash chroot.sh
	rm -v /mnt/chroot.sh
	rm -rv /mnt/temp
	umount -a
	swapoff /dev/sda2
	lsblk
}

printf "\e[1;32m*********Arch Scripts Started**********\e[0m"
timedatectl set-ntp true
create-part-d1
create-part-d2
makefs
mountfs
install-pkgs
install-yay
install-brave
chroot-fun

